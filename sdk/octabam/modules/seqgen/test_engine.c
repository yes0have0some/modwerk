/* Firmware-free behavioural tests for the SEQGEN engine. No stock bytes. */
#include "engine.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>

static void blank(uint8_t *r) {
    memset(r, 0, SG_TRACK_BYTES);
    memset(r + SG_LOCKS, 255, 64 * 32);
    memset(r + 0x40, 0xaa, 8); r[0x50] = 16; r[0x51] = 2;
}
static int on(const uint8_t *r, unsigned i, unsigned m) { return (r[m * 8 + 7 - i / 8] >> (i % 8)) & 1; }
static int same(const SgPhrase *a, const SgPhrase *b) {
    if (a->length != b->length) return 0;
    for (unsigned i = 0; i < a->length; ++i) {
        const SgStep *x = &a->steps[i], *y = &b->steps[i];
        if (x->on != y->on || x->slide != y->slide || x->hold != y->hold || x->volume != y->volume ||
            x->pitch != y->pitch || x->chance != y->chance || x->micro != y->micro || x->retrig != y->retrig) return 0;
    }
    return 1;
}
static void check_phrase(const SgPhrase *ph, const SgParams *p, unsigned base) {
    for (unsigned i = 0; i < SG_STEPS; ++i) {
        const SgStep *s = &ph->steps[i];
        if (i >= ph->length) { assert(!s->on); continue; }
        if (!s->on) continue;
        assert(s->volume <= base && s->hold <= 127);
        if (s->pitch != SG_PITCH_NONE) {
            assert(s->pitch >= -12 && s->pitch <= 12);
            assert(sg_in_scale(s->pitch, p->root, p->scale));
        }
    }
}

static void scales(void) {
    for (unsigned s = 0; s < SG_SCALE_COUNT; ++s) {
        assert(sg_scale_masks[s] & 1u);                 /* every scale holds its root */
        for (unsigned root = 0; root < 12; ++root)
            for (int p = -20; p <= 20; ++p) {
                int f = sg_fit(p, root, s);
                assert(f >= -12 && f <= 12 && sg_in_scale(f, root, s));
                if (p >= -12 && p <= 12 && sg_in_scale(p, root, s)) assert(f == p);
            }
    }
    assert(sg_in_scale(0, 0, 1) && !sg_in_scale(1, 0, 1) && sg_in_scale(4, 0, 1));
    assert(sg_in_scale(9, 9, 2) && sg_in_scale(0, 9, 2) && !sg_in_scale(1, 9, 2)); /* A minor */
    assert(sg_fit(1, 0, 1) == 0);                        /* ties resolve down */
}

static void generation(void) {
    unsigned cases = 0;
    SgPhrase a, b;
    for (unsigned algo = 0; algo < SG_ALGO_COUNT; ++algo)
    for (unsigned scale = 0; scale < SG_SCALE_COUNT; ++scale)
    for (unsigned root = 0; root < 12; root += 5)
    for (unsigned len = 1; len <= 64; len += 9)
    for (unsigned dens = 0; dens <= 16; dens += 4)
    for (unsigned seed = 0; seed < 6; ++seed) {
        SgParams p = sg_defaults;
        p.algo = (uint8_t)algo; p.scale = (uint8_t)scale; p.root = (uint8_t)root;
        p.density = (uint8_t)dens; p.seed = (uint8_t)seed; p.span = (uint8_t)(seed * 2);
        p.prob = (uint8_t)(seed * 15); p.ratchet = (uint8_t)(seed * 10); p.groove = (uint8_t)(seed * 4);
        p.gate = seed == 5 ? 127 : 40; p.transpose = (uint8_t)(10 + seed);
        assert(sg_generate(&a, &p, len, 100));
        assert(sg_generate(&b, &p, len, 100));
        assert(same(&a, &b));                            /* deterministic */
        check_phrase(&a, &p, 100);
        unsigned notes = 0;
        for (unsigned i = 0; i < len; ++i) notes += a.steps[i].on;
        if (!dens) assert(notes == 0);
        if (algo == SG_ALGO_DRUM)
            for (unsigned i = 0; i < len; ++i) assert(!a.steps[i].on || a.steps[i].pitch == SG_PITCH_NONE);
        if (!p.prob) for (unsigned i = 0; i < len; ++i) assert(!a.steps[i].chance);
        if (!p.groove) for (unsigned i = 0; i < len; ++i) assert(!a.steps[i].micro);
        ++cases;
    }
    SgParams p = sg_defaults;
    assert(!sg_generate(&a, &p, 0, 100) && !sg_generate(&a, &p, 65, 100) && !sg_generate(&a, &p, 16, 128));
    /* EUCL: exactly k evenly spaced notes. */
    p.algo = SG_ALGO_EUCL; p.density = 8; assert(sg_generate(&a, &p, 16, 100));
    unsigned n = 0; for (unsigned i = 0; i < 16; ++i) n += a.steps[i].on;
    assert(n == 8);
    /* A new seed gives a different phrase for a busy generator. */
    p.algo = SG_ALGO_ACID; p.density = 12; p.seed = 3; assert(sg_generate(&a, &p, 16, 100));
    p.seed = (uint8_t)sg_next_seed(p.seed); assert(sg_generate(&b, &p, 16, 100));
    assert(!same(&a, &b));
    assert(sg_next_seed(127) == 0);
    printf("generation: %u cases\n", cases);
}

static void evolution(void) {
    SgPhrase a, b;
    for (unsigned evo = 0; evo < SG_EVO_COUNT; ++evo)
    for (unsigned scale = 0; scale < SG_SCALE_COUNT; scale += 3)
    for (unsigned amount = 0; amount <= 100; amount += 25)
    for (unsigned seed = 0; seed < 8; ++seed) {
        SgParams p = sg_defaults; p.scale = (uint8_t)scale; p.evo = (uint8_t)evo;
        p.amount = (uint8_t)amount; p.density = 10;
        assert(sg_generate(&a, &p, 32, 110));
        b = a;
        assert(sg_evolve(&a, &p, 110, seed));
        check_phrase(&a, &p, 110);
        if (!amount) assert(same(&a, &b));
        if (evo >= SG_EVO_SWIZ) {   /* swaps keep the multiset of notes */
            unsigned na = 0, nb = 0; int sa = 0, sb = 0;
            for (unsigned i = 0; i < 32; ++i) {
                na += a.steps[i].on; nb += b.steps[i].on;
                if (a.steps[i].on) sa += a.steps[i].pitch + a.steps[i].hold + a.steps[i].volume;
                if (b.steps[i].on) sb += b.steps[i].pitch + b.steps[i].hold + b.steps[i].volume;
            }
            assert(na == nb && sa == sb);
        }
    }
}

static void transforms(void) {
    SgParams p = sg_defaults; p.scale = 1; p.root = 0;
    SgPhrase a; assert(sg_generate(&a, &p, 16, 100));
    SgPhrase up = a; sg_transpose(&up, &p, 2); check_phrase(&up, &p, 100);
    SgPhrase inv = a; sg_invert(&inv, &p); check_phrase(&inv, &p, 100);
    SgPhrase dbl = a; sg_double(&dbl);
    for (unsigned i = 8; i < 16; ++i) assert(dbl.steps[i].on == a.steps[i - 8].on);
    p.scale = 14; sg_fit_phrase(&a, &p); check_phrase(&a, &p, 100);
}

static void record(void) {
    static uint8_t r[SG_TRACK_BYTES], before[SG_TRACK_BYTES];
    blank(r);
    /* unrelated locks, a recorder trig, swing, and a step past the length */
    r[SG_LOCKS + 32 * 3 + 20] = 77;                     /* FX1 lock on step 4 */
    r[4 * 8 + 7] = 0x01;                                /* recorder mask */
    r[SG_LOCKS + 32 * 40 + SG_SLOT_PTCH] = 90; r[7 - 40 / 8] |= 1u << (40 % 8);
    memcpy(before, r, sizeof r);
    SgParams p = sg_defaults; p.density = 16; p.algo = SG_ALGO_ACID;
    SgPhrase ph; assert(sg_generate(&ph, &p, 16, 100));
    ph.steps[3].on = 0;
    assert(sg_write_phrase(r, sizeof r, &ph));
    for (unsigned i = 0; i < 16; ++i) {
        assert(on(r, i, SG_MASK_TRIG) == ph.steps[i].on);
        if (ph.steps[i].on && ph.steps[i].pitch != SG_PITCH_NONE)
            assert(r[SG_LOCKS + 32 * i] == 64 + 5 * ph.steps[i].pitch);
    }
    assert(r[SG_LOCKS + 32 * 3 + 20] == 77 && on(r, 3, SG_MASK_PLOCK));   /* kept as a trigless lock */
    assert(memcmp(r + 0x40, before + 0x40, 8) == 0);                    /* swing untouched */
    assert(r[4 * 8 + 7] == 0x01);                                       /* recorder untouched */
    assert(r[SG_LOCKS + 32 * 40] == 90 && on(r, 40, SG_MASK_TRIG));     /* past length kept */
    SgPhrase back; assert(sg_read_phrase(&back, r, sizeof r, 16));
    for (unsigned i = 0; i < 16; ++i) {
        assert(back.steps[i].on == ph.steps[i].on);
        if (ph.steps[i].on) assert(back.steps[i].pitch == ph.steps[i].pitch && back.steps[i].hold == ph.steps[i].hold);
    }
    /* invalid input changes nothing */
    memcpy(before, r, sizeof r);
    SgPhrase bad = ph; bad.steps[2].pitch = 13; bad.steps[2].on = 1;
    assert(!sg_write_phrase(r, sizeof r, &bad) && memcmp(r, before, sizeof r) == 0);
    assert(!sg_write_phrase(r, SG_TRACK_BYTES - 1, &ph));
    /* rotation is reversible and keeps swing on the grid */
    assert(sg_rotate_record(r, sizeof r, 16, 1));
    assert(memcmp(r + 0x40, before + 0x40, 8) == 0);
    assert(on(r, 1, SG_MASK_TRIG) == on(before, 0, SG_MASK_TRIG));
    assert(sg_rotate_record(r, sizeof r, 16, -1));
    assert(memcmp(r, before, sizeof r) == 0);
    assert(!sg_rotate_record(r, sizeof r, 1, 1) && !sg_rotate_record(r, sizeof r, 16, 2));
    /* FIT moves only PTCH locks, into the scale */
    p.scale = 14; p.root = 2; assert(sg_fit_record(r, sizeof r, &p));
    for (unsigned i = 0; i < 64; ++i) {
        uint8_t v = r[SG_LOCKS + 32 * i];
        if (v != SG_NO_LOCK) assert(sg_in_scale(((int)v - 64) / 5, 2, 14));
    }
    assert(r[SG_LOCKS + 32 * 3 + 20] == 77);
}

static void settings(void) {
    uint8_t packed[SG_PACKED_BYTES];
    for (unsigned c = 0; c < 16; ++c) for (unsigned v = 0; v <= sg_control_max[c]; ++v) {
        SgParams p = sg_defaults, q; sg_set(&p, c, v);
        sg_pack(packed, &p); sg_unpack(&q, packed);
        assert(sg_get(&q, c) == v && memcmp(&p, &q, sizeof p) == 0);
    }
    SgParams p = sg_defaults; sg_set(&p, 1, 200); assert(p.density == 16);
    memset(packed, 0xff, sizeof packed); sg_unpack(&p, packed);
    for (unsigned c = 0; c < 16; ++c) assert(sg_get(&p, c) <= sg_control_max[c]);
}

static void trig_word(void) {
    assert(sg_trig_word(0, 0) == 0);
    assert(sg_chance_code(0) == 0 && sg_chance_code(100) == 0 && sg_chance_code(50) == 19);
    assert(((sg_trig_word(0, -1) >> 7) & 0x3f) == 0x3f && ((sg_trig_word(0, 23) >> 7) & 0x3f) == 23);
    /* Emulator readbacks of stock edits (1.40C, MKI mode). */
    assert(sg_trig_word(0, 1) == 0x0080 && sg_trig_word(1, 0) == 0x0009);
    assert(sg_trig_word(0, -3) == 0x1e80 && sg_trig_word(0, -23) == 0x1480 && sg_trig_word(0, 23) == 0x0b80);
    assert(sg_chance_code(87) == 24 && sg_chance_code(99) == 29);
}

static void retrig_and_flags(void) {
    static uint8_t r[SG_TRACK_BYTES];
    blank(r);
    r[SG_TRIGWORD + 2 * 5] = 0xe0;                   /* unexplained high bits */
    SgPhrase ph; SgParams p = sg_defaults; p.density = 0;
    assert(sg_generate(&ph, &p, 16, 100));
    ph.steps[5].on = 1; ph.steps[5].pitch = 0; ph.steps[5].hold = 20; ph.steps[5].volume = 100;
    ph.steps[5].chance = 50; ph.steps[5].micro = -3; ph.steps[5].retrig = 3;
    assert(sg_write_phrase(r, sizeof r, &ph));
    assert(r[SG_LOCKS + 32 * 5 + SG_SLOT_RTRG] == 2 && r[SG_LOCKS + 32 * 5 + SG_SLOT_RTIM] == 72);
    unsigned w = (unsigned)r[SG_TRIGWORD + 10] << 8 | r[SG_TRIGWORD + 11];
    assert((w & 0x7f) == 19 && ((w >> 7) & 0x3f) == ((unsigned)-3 & 0x3f));
}

int main(void) {
    retrig_and_flags();
    scales(); generation(); evolution(); transforms(); record(); settings(); trig_word();
    puts("SEQGEN engine tests passed (firmware-free; no hardware claim).");
    return 0;
}
