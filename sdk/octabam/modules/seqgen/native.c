/* SEQGEN native adapter for locally verified Octatrack OS 1.40C.
 * Copyright (c) 2026 yes0have0some. MIT. Original implementation.
 * Opens from PROJECT > CONTROL > SEQGEN, edits runtime-only settings and
 * commits phrases into the current pattern's audio track record. The stock
 * sequencer plays them; SEQGEN keeps no clock. Window, layer and publication
 * idioms follow octabam (MIT) and VECTOR (MIT). Addresses are documented in
 * TESTING.md with how each was read or measured. */
#include "engine.h"
#define U8(a) (*(volatile uint8_t *)(uintptr_t)(a))
#define U32(a) (*(volatile uint32_t *)(uintptr_t)(a))
#define BANK_PTR 0x46c82456u
#define PART_IDX 0x100b14cfu
#define TRACK_IDX 0x100b14ccu
#define PATTERN_IDX 0x100b14d0u
#define PART_OFF 0x8ed80u
#define PART_STRIDE 0x18b2u
#define PATTERN_STRIDE 0x8ed8u
#define SRAM_PATTERNS 0x1001614eu
#define TRANSPORT 0x800065b8u
#define TRACK_STEP 0x800064d0u
#define MIDI_MODE 0x80000012u
#define SCREEN_DIRTY 0x46c7c72cu
#define KEYS_DOWN 0x46100b18u
#define FONT 0x400ba876u
#define K_YES 0x31u
#define K_NO 0x32u
#define K_LEFT 0x34u
#define K_RIGHT 0x21u
#define K_FUNC 0x2du

extern uint32_t seqgen_layer[];
void seqgen_close(void);

enum { OP_GEN, OP_EVO, OP_ROT, OP_FIT, OP_TRNS, OP_INV, OP_DBL };
static const char *const page_names[3] = {"GEN", "EVO", "KEY"};
static const char *const root_names[12] = {"C","C#","D","D#","E","F","F#","G","G#","A","A#","B"};
static const char *const auto_names[6] = {"OFF","1","2","4","8","16"};

static SgParams params[8] = {{0}};
static uint32_t params_ready = 0;
static uint32_t evo_seed[8] = {0};
static uint32_t win = 0, page = 0, shown_track = 0xff, shown_midi = 0;
static uint32_t close_pending = 0;
static uint8_t mine[64] = {0};
static const char *status = 0;
static uint8_t staging[SG_TRACK_BYTES] = {0};
static uint8_t undo_rec[SG_TRACK_BYTES] = {0};
static uint32_t undo_valid = 0, undo_bank = 0, undo_off = 0, undo_track = 0, undo_part = 0;
static SgPhrase phrase = {{{0}}, 0};
static uint8_t last_step[8] = {0}, loops[8] = {0}, auto_due[8] = {0};
static uint32_t last_transport = 0, auto_next = 0;

static void ensure_params(void) {
    if (params_ready) return;
    for (unsigned t = 0; t < 8; ++t) { params[t] = sg_defaults; evo_seed[t] = t + 1u; }
    params_ready = 1;
}
static int valid_bank(void) { uint32_t b = U32(BANK_PTR); return b >= 0x40000000u && b < 0x47f00000u; }
static unsigned key_held(unsigned key) { return (U8(KEYS_DOWN + (key >> 3)) >> (key & 7u)) & 1u; }
static unsigned audio_track(void) { return !U32(MIDI_MODE) && U8(TRACK_IDX) < 8; }
static volatile uint8_t *current_part(void) {
    return (volatile uint8_t *)(uintptr_t)(U32(BANK_PTR) + PART_OFF + (U8(PART_IDX) & 3u) * PART_STRIDE);
}
static void toast(const char *text) { ((void (*)(const char *, unsigned))0x4005a2b8u)(text, 48); }
static void dirty_part(unsigned part) {
    U8(U32(BANK_PTR) + 0x95048u) |= (uint8_t)(1u << part);
    U8(0x100b145eu) |= (uint8_t)(1u << part);
    U32(U32(BANK_PTR) + 0x9b332u) = 1; U32(0x100f8598u) = 1;
    ((void (*)(void))0x40027e00u)();
}
static void publish(unsigned t) {
    ((void (*)(void))0x400339d8u)();
    ((void (*)(unsigned))0x4009da20u)(t);
    U32(SCREEN_DIRTY) = 1;
}

/* Edit the current pattern's record of track t on the UI task. Returns 1
 * when the record changed, 2 when the result equals the record, 0 when the
 * edit was refused. Never called from an interrupt. */
static unsigned commit(unsigned t, unsigned op, int arg) {
    if (!valid_bank() || t >= 8) return 0;
    unsigned p = U8(PATTERN_IDX);
    if (p >= 16) return 0;
    uint32_t bank = U32(BANK_PTR), part = U8(PART_IDX), off = p * PATTERN_STRIDE + t * SG_TRACK_BYTES;
    volatile uint8_t *src = (volatile uint8_t *)(uintptr_t)(bank + off);
    const volatile uint8_t *pat = (const volatile uint8_t *)(uintptr_t)(bank + p * PATTERN_STRIDE);
    for (unsigned k = 0; k < SG_TRACK_BYTES; ++k) staging[k] = src[k];
    unsigned length = pat[0x8e55u] ? staging[0x50u] : pat[0x8e53u];
    unsigned volume = current_part()[0x123u + 24u * t];
    if (!length || length > SG_STEPS || volume > 127) return 0;
    const SgParams *sp = &params[t];
    int ok = 0;
    switch (op) {
    case OP_GEN: ok = sg_generate(&phrase, sp, length, volume) &&
                      sg_write_phrase(staging, sizeof staging, &phrase); break;
    case OP_ROT: ok = sg_rotate_record(staging, sizeof staging, length, arg); break;
    case OP_FIT: ok = sg_fit_record(staging, sizeof staging, sp); break;
    default:
        ok = sg_read_phrase(&phrase, staging, sizeof staging, length);
        if (ok && op == OP_EVO) { evo_seed[t] = sg_next_seed(evo_seed[t] + (uint32_t)arg);
                                  ok = sg_evolve(&phrase, sp, volume, evo_seed[t]); }
        if (ok && op == OP_TRNS) sg_transpose(&phrase, sp, arg);
        if (ok && op == OP_INV) sg_invert(&phrase, sp);
        if (ok && op == OP_DBL) sg_double(&phrase);
        ok = ok && sg_write_phrase(staging, sizeof staging, &phrase);
    }
    /* The result belongs to the bank, Part and pattern it was read from. */
    if (!ok || bank != U32(BANK_PTR) || p != U8(PATTERN_IDX) || part != U8(PART_IDX)) return 0;
    unsigned changed = 0;
    for (unsigned k = 0; k < SG_TRACK_BYTES; ++k) if (src[k] != staging[k]) { changed = 1; break; }
    if (!changed) return 2;
    for (unsigned k = 0; k < SG_TRACK_BYTES; ++k) undo_rec[k] = src[k];
    undo_valid = 1; undo_bank = bank; undo_off = off; undo_track = t; undo_part = part;
    volatile uint8_t *mirror = (volatile uint8_t *)(uintptr_t)(SRAM_PATTERNS + off);
    for (unsigned k = 0; k < SG_TRACK_BYTES; ++k)
        if (src[k] != staging[k]) { src[k] = staging[k]; mirror[k] = staging[k]; }
    dirty_part(part & 3u);
    publish(t);
    return 1;
}
static unsigned undo(void) {
    if (!undo_valid || undo_bank != U32(BANK_PTR) || undo_part != U8(PART_IDX) ||
        undo_off != U8(PATTERN_IDX) * PATTERN_STRIDE + undo_track * SG_TRACK_BYTES) return 0;
    volatile uint8_t *src = (volatile uint8_t *)(uintptr_t)(undo_bank + undo_off);
    volatile uint8_t *mirror = (volatile uint8_t *)(uintptr_t)(SRAM_PATTERNS + undo_off);
    /* Swap through staging (undo again redoes). Plain copies: GCC fused the
     * in-place swap into `move.b (%a0)+,(%a0,%d1.l)`, whose destination uses
     * the incremented a0 (measured under the port: a one-byte shift).
     * prepare.py compiles with -fno-ivopts and refuses that shape. */
    for (unsigned k = 0; k < SG_TRACK_BYTES; ++k) staging[k] = src[k];
    for (unsigned k = 0; k < SG_TRACK_BYTES; ++k) { src[k] = undo_rec[k]; mirror[k] = undo_rec[k]; }
    for (unsigned k = 0; k < SG_TRACK_BYTES; ++k) undo_rec[k] = staging[k];
    dirty_part(undo_part & 3u);
    publish(undo_track);
    return 1;
}

/* ---- drawing -------------------------------------------------------------- */
static unsigned put_text(char *out, unsigned at, const char *text) {
    while (*text && at < 15) out[at++] = *text++;
    out[at] = 0; return at;
}
static unsigned put_number(char *out, unsigned at, int value) {
    char digits[4]; unsigned n = 0;
    if (value < 0) { if (at < 15) out[at++] = '-'; value = -value; }
    do { digits[n++] = (char)('0' + value % 10); value /= 10; } while (value && n < 4);
    while (n && at < 15) out[at++] = digits[--n];
    out[at] = 0; return at;
}
static void format_value(char *out, unsigned control, unsigned v) {
    out[0] = 0;
    switch (control) {
    case 0: put_text(out, 0, sg_algo_names[v % SG_ALGO_COUNT]); break;
    case 6: put_text(out, 0, sg_evo_names[v % SG_EVO_COUNT]); break;
    case 8: put_text(out, 0, auto_names[v % 6]); break;
    case 12: put_text(out, 0, root_names[v % 12]); break;
    case 13: put_text(out, 0, sg_scale_names[v % SG_SCALE_COUNT]); break;
    case 14: put_text(out, 0, v ? "ON" : "OFF"); break;
    case 15: put_number(out, 0, (int)v - 12); break;
    case 3: if (v >= 127) { put_text(out, 0, "INF"); break; } /* fall through */
    default: put_number(out, 0, (int)v);
    }
}
static void text(uint32_t surface, int x, int y, const char *s) {
    ((void (*)(uint32_t, uint32_t, int, int, int, const char *))0x40012bd8u)(FONT, surface, x, y, -1, s);
}
static void draw(void) {
    if (!win) return;
    unsigned t = U8(TRACK_IDX);
    char title[16]; unsigned at = put_text(title, 0, "SEQGEN T");
    at = put_number(title, at, (int)(t < 8 ? t + 1 : 0)); at = put_text(title, at, " ");
    put_text(title, at, page_names[page % 3]);
    ((void (*)(uint32_t, const char *, unsigned))0x400570b8u)(win, title, 0);
    uint32_t surface = win + 0x24u;
    ((void (*)(uint32_t))0x4003567cu)(surface);
    int height = (int)U32(win + 0x28u);
    if (!audio_track()) {
        text(surface, 5, height - 30, "AUDIO TRACKS ONLY");
    } else {
        ensure_params();
        for (unsigned i = 0; i < 6; ++i) {
            unsigned control = page * 6u + i;
            int x = 5 + 37 * (int)(i % 3u), y = height - 22 - 18 * (int)(i / 3u);
            char value[16];
            if (control >= 16) { text(surface, x, y, control == 16 ? "INV" : "DBL"); put_text(value, 0, "TURN"); }
            else { text(surface, x, y, sg_control_names[control]);
                   format_value(value, control, sg_get(&params[t], control)); }
            text(surface, x, y - 7, value);
        }
        if (status) text(surface, 5, height - 58, status);
    }
    shown_track = t; shown_midi = U32(MIDI_MODE);
    U32(SCREEN_DIRTY) = 1;
}

/* ---- the page ------------------------------------------------------------- */
/* PROJECT > CONTROL > SEQGEN: the stock menu calls a row's action from its
 * YES key handler, so toasts here are on the key path. */
void seqgen_open(int unused) {
    (void)unused;
    if (win) return;
    if (!audio_track()) { toast("SEQGEN: AUDIO TRACKS ONLY"); return; }
    ensure_params();
    /* Priority 2 sits above the PROJECT menu's window (priority 1). */
    win = ((uint32_t (*)(int, int, int, int, int, void (*)(void)))0x4005829cu)(0x76, 0x40, -1, 0, 2, seqgen_close);
    if (!win) return;
    seqgen_layer[0] = 0;
    ((void (*)(uint32_t *))0x40031494u)(seqgen_layer);
    page = 0; status = 0; close_pending = 0;
    for (unsigned k = 0; k < 64; ++k) mine[k] = 0;
    draw();
}
/* NO, or the stock window manager replacing this window. Pops only our layer. */
void seqgen_close(void) {
    if (!win) return;
    ((void (*)(uint32_t *))0x40055db4u)(&win);
    ((void (*)(uint32_t *))0x4003146cu)(seqgen_layer);
    close_pending = 0;
    U32(SCREEN_DIRTY) = 1;
}
static void report(unsigned result, const char *done) {
    status = result == 1 ? done : result == 2 ? "NO CHANGE" : "NOT POSSIBLE";
}
void seqgen_key(unsigned code, unsigned edge) {
    if (code >= 64) return;
    if (edge != 1) {   /* a release always reaches the handler that took its press */
        if (!edge && mine[code]) {
            mine[code] = 0;
            if (code == K_NO && close_pending) seqgen_close();
        }
        return;
    }
    mine[code] = 1;
    if (!win) return;
    unsigned t = U8(TRACK_IDX), func = key_held(K_FUNC);
    if (code == K_NO) {
        if (func) { status = undo() ? "UNDONE" : "NOTHING TO UNDO"; draw(); }
        else close_pending = 1;
        return;
    }
    if (!audio_track()) return;
    ensure_params();
    if (code == K_LEFT || code == K_RIGHT) {
        int dir = code == K_RIGHT ? 1 : -1;
        if (func) report(commit(t, OP_ROT, dir), dir > 0 ? "ROTATED >" : "ROTATED <");
        else { page = (page + (dir > 0 ? 1u : 2u)) % 3u; status = 0; }
    } else if (code == K_YES) {
        if (page == 0) {
            sg_set(&params[t], 5, sg_next_seed(params[t].seed));
            report(commit(t, OP_GEN, 0), "GENERATED");
        } else if (page == 1) report(commit(t, OP_EVO, 0), "EVOLVED");
    }
    draw();
}
void seqgen_knob(unsigned index, int delta) {
    if (!win || index >= 6 || !audio_track() || !delta) return;
    ensure_params();
    unsigned t = U8(TRACK_IDX), control = page * 6u + index;
    if (control >= 16) {
        report(commit(t, control == 16 ? OP_INV : OP_DBL, 0), control == 16 ? "INVERTED" : "DOUBLED");
        draw(); return;
    }
    int old = sg_get(&params[t], control), value = old + delta;
    if (value < 0) value = 0;
    if (value > sg_control_max[control]) value = sg_control_max[control];
    if (value == old) return;
    sg_set(&params[t], control, (unsigned)value);
    status = 0;
    if (page == 0) report(commit(t, OP_GEN, 0), "GENERATED");
    else if (control == 12 || control == 13)
        report(commit(t, params[t].fit ? OP_FIT : OP_GEN, 0), params[t].fit ? "FITTED" : "GENERATED");
    else if (control == 15)
        report(commit(t, params[t].fit ? OP_TRNS : OP_GEN, value - old), params[t].fit ? "TRANSPOSED" : "GENERATED");
    draw();
}

/* ---- the UI tick (0x40052232, once per UI frame) ---------------------------- */
/* AUTO counts each track's loops from the sequencer's own per-track step
 * counter. It never advances anything itself, skips missed loops and runs at
 * most one commit per tick. Stopped, or AUTO OFF everywhere: no work. */
void seqgen_tick(void) {
    if (win && (U8(TRACK_IDX) != shown_track || U32(MIDI_MODE) != shown_midi)) draw();
    if (!params_ready) return;
    uint32_t transport = U32(TRANSPORT);
    unsigned any = 0;
    for (unsigned t = 0; t < 8; ++t) any |= params[t].autoloops;
    if (transport != 1 || !any) { last_transport = transport; return; }
    if (last_transport != 1)
        for (unsigned t = 0; t < 8; ++t) { last_step[t] = U8(TRACK_STEP + t); loops[t] = 0; auto_due[t] = 0; }
    last_transport = transport;
    for (unsigned t = 0; t < 8; ++t) {
        unsigned step = U8(TRACK_STEP + t), every = sg_autoloop_values[params[t].autoloops % 6u];
        if (every && step < last_step[t] && ++loops[t] >= every) { loops[t] = 0; auto_due[t] = 1; }
        if (!every) { loops[t] = 0; auto_due[t] = 0; }
        last_step[t] = (uint8_t)step;
    }
    for (unsigned n = 0; n < 8; ++n) {
        unsigned t = (auto_next + n) & 7u;
        if (!auto_due[t]) continue;
        auto_due[t] = 0; auto_next = t + 1u;
        if (commit(t, OP_EVO, 0) == 1 && win && t == U8(TRACK_IDX)) { status = "AUTO EVOLVED"; draw(); }
        break;
    }
}
