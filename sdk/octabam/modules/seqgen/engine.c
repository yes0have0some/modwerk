/* Copyright (c) 2026 yes0have0some. MIT. Original implementation.
 * Musical inspiration: the five12 Vector user guide's generator, evolve and
 * scale descriptions. No five12 code, firmware, tables or assets are used. */
#include "engine.h"

const SgParams sg_defaults = {
    SG_ALGO_ACID, 10, 12, 32, 48, 1,
    SG_EVO_LOW, 25, 0, 0, 0, 0,
    0, 1, 0, 12,
};
const char *const sg_control_names[16] = {
    "ALGO", "DENS", "SPAN", "GATE", "ACNT", "SEED",
    "EVO", "AMNT", "AUTO", "PROB", "RTCH", "GRV",
    "ROOT", "SCAL", "FIT", "TRNS",
};
const uint8_t sg_control_max[16] = {
    SG_ALGO_COUNT - 1, 16, 12, 127, 127, 127,
    SG_EVO_COUNT - 1, 100, 5, 100, 100, 23,
    11, SG_SCALE_COUNT - 1, 1, 24,
};
const char *const sg_algo_names[SG_ALGO_COUNT] = {
    "ACID", "BARL", "CELL", "OBLQ", "RAND", "EUCL", "TEKN", "MIRR", "DRUM",
};
const char *const sg_evo_names[SG_EVO_COUNT] = {
    "LOW", "MED", "HIGH", "SWIZ", "SW-P", "SW-G", "SW-V",
};
const char *const sg_scale_names[SG_SCALE_COUNT] = {
    "CHR", "MAJ", "MIN", "DOR", "PHR", "LYD", "MIX", "LOC", "HMIN",
    "MMIN", "WHL", "OCT1", "OCT2", "PMAJ", "PMIN", "BLUS", "MAJ7", "DOM7",
};
/* Bit n = the pitch class n semitones above the root. */
#define PC(n) (1u << (n))
const uint16_t sg_scale_masks[SG_SCALE_COUNT] = {
    0x0fff,
    PC(0)|PC(2)|PC(4)|PC(5)|PC(7)|PC(9)|PC(11),          /* major */
    PC(0)|PC(2)|PC(3)|PC(5)|PC(7)|PC(8)|PC(10),          /* natural minor */
    PC(0)|PC(2)|PC(3)|PC(5)|PC(7)|PC(9)|PC(10),          /* dorian */
    PC(0)|PC(1)|PC(3)|PC(5)|PC(7)|PC(8)|PC(10),          /* phrygian */
    PC(0)|PC(2)|PC(4)|PC(6)|PC(7)|PC(9)|PC(11),          /* lydian */
    PC(0)|PC(2)|PC(4)|PC(5)|PC(7)|PC(9)|PC(10),          /* mixolydian */
    PC(0)|PC(1)|PC(3)|PC(5)|PC(6)|PC(8)|PC(10),          /* locrian */
    PC(0)|PC(2)|PC(3)|PC(5)|PC(7)|PC(8)|PC(11),          /* harmonic minor */
    PC(0)|PC(2)|PC(3)|PC(5)|PC(7)|PC(9)|PC(11),          /* melodic minor */
    PC(0)|PC(2)|PC(4)|PC(6)|PC(8)|PC(10),                /* whole tone */
    PC(0)|PC(2)|PC(3)|PC(5)|PC(6)|PC(8)|PC(9)|PC(11),    /* octatonic whole-half */
    PC(0)|PC(1)|PC(3)|PC(4)|PC(6)|PC(7)|PC(9)|PC(10),    /* octatonic half-whole */
    PC(0)|PC(2)|PC(4)|PC(7)|PC(9),                       /* major pentatonic */
    PC(0)|PC(3)|PC(5)|PC(7)|PC(10),                      /* minor pentatonic */
    PC(0)|PC(3)|PC(5)|PC(6)|PC(7)|PC(10),                /* blues */
    PC(0)|PC(4)|PC(7)|PC(11),                            /* major 7th arpeggio */
    PC(0)|PC(4)|PC(7)|PC(10),                            /* dominant 7th arpeggio */
};
/* AUTO: OFF, then evolve every N track loops. */
const uint8_t sg_autoloop_values[6] = {0, 1, 2, 4, 8, 16};

static unsigned limit(unsigned v, unsigned max) { return v > max ? max : v; }

uint8_t sg_get(const SgParams *p, unsigned c) {
    const uint8_t *f[16] = {
        &p->algo, &p->density, &p->span, &p->gate, &p->accent, &p->seed,
        &p->evo, &p->amount, &p->autoloops, &p->prob, &p->ratchet, &p->groove,
        &p->root, &p->scale, &p->fit, &p->transpose,
    };
    return c < 16 ? *f[c] : 0;
}
void sg_set(SgParams *p, unsigned c, unsigned v) {
    uint8_t *f[16] = {
        &p->algo, &p->density, &p->span, &p->gate, &p->accent, &p->seed,
        &p->evo, &p->amount, &p->autoloops, &p->prob, &p->ratchet, &p->groove,
        &p->root, &p->scale, &p->fit, &p->transpose,
    };
    if (c < 16) *f[c] = (uint8_t)limit(v, sg_control_max[c]);
}
void sg_clamp(SgParams *p) {
    for (unsigned c = 0; c < 16; ++c) sg_set(p, c, sg_get(p, c));
}
/* 12 bytes: algo|scale<<4, density|fit<<5, span|root<<4, gate, accent,
 * seed, evo|autoloops<<4, amount, prob, ratchet, groove, transpose. */
void sg_pack(uint8_t o[SG_PACKED_BYTES], const SgParams *in) {
    SgParams p = *in; sg_clamp(&p);
    o[0] = (uint8_t)(p.algo | (p.scale & 15u) << 4);
    o[1] = (uint8_t)(p.density | p.fit << 5 | (p.scale >> 4) << 6);
    o[2] = (uint8_t)(p.span | p.root << 4);
    o[3] = p.gate; o[4] = p.accent; o[5] = p.seed;
    o[6] = (uint8_t)(p.evo | p.autoloops << 4);
    o[7] = p.amount; o[8] = p.prob; o[9] = p.ratchet; o[10] = p.groove;
    o[11] = p.transpose;
}
void sg_unpack(SgParams *p, const uint8_t in[SG_PACKED_BYTES]) {
    p->algo = in[0] & 15u;
    p->scale = (uint8_t)((in[0] >> 4) | ((in[1] >> 6) & 3u) << 4);
    p->density = in[1] & 31u; p->fit = (in[1] >> 5) & 1u;
    p->span = in[2] & 15u; p->root = in[2] >> 4;
    p->gate = in[3]; p->accent = in[4]; p->seed = in[5];
    p->evo = in[6] & 15u; p->autoloops = in[6] >> 4;
    p->amount = in[7]; p->prob = in[8]; p->ratchet = in[9]; p->groove = in[10];
    p->transpose = in[11];
    sg_clamp(p);
}

/* ---- deterministic randomness ------------------------------------------ */
static uint32_t hash32(uint32_t x) {
    x ^= x >> 16; x *= 0x21f0aaadu; x ^= x >> 15;
    x *= 0x735a2d97u; return x ^ (x >> 15);
}
typedef struct { uint32_t s; } Rng;
static uint32_t rnd(Rng *r) { r->s += 0x6d2b79f5u; return hash32(r->s); }
static unsigned below(Rng *r, unsigned n) { return n ? rnd(r) % n : 0; }
static unsigned chance(Rng *r, unsigned percent) { return below(r, 100) < percent; }
uint32_t sg_next_seed(uint32_t seed) { return (seed + 1u) & 127u; }

/* ---- pitch ---------------------------------------------------------------- */
static unsigned pclass(int pitch, unsigned root) {
    return (unsigned)(pitch + 48 - (int)root) % 12u;
}
int sg_in_scale(int pitch, unsigned root, unsigned scale) {
    if (pitch < -12 || pitch > 12 || scale >= SG_SCALE_COUNT) return 0;
    return (sg_scale_masks[scale] >> pclass(pitch, root % 12u)) & 1u;
}
int sg_fit(int pitch, unsigned root, unsigned scale) {
    if (pitch < -12) pitch = -12;
    if (pitch > 12) pitch = 12;
    /* Nearest scale tone; ties resolve downwards, as a musician would. */
    for (int d = 0; d <= 12; ++d) {
        if (sg_in_scale(pitch - d, root, scale)) return pitch - d;
        if (sg_in_scale(pitch + d, root, scale)) return pitch + d;
    }
    return 0;
}
/* Scale tones inside [lo, hi], ascending. At most 25. */
static unsigned ladder(int out[25], int lo, int hi, unsigned root, unsigned scale) {
    unsigned n = 0;
    for (int p = lo; p <= hi; ++p) if (sg_in_scale(p, root, scale)) out[n++] = p;
    return n;
}
static unsigned nearest_index(const int *lad, unsigned n, int pitch) {
    unsigned best = 0; int dist = 99;
    for (unsigned i = 0; i < n; ++i) {
        int d = lad[i] - pitch; if (d < 0) d = -d;
        if (d < dist) { dist = d; best = i; }
    }
    return best;
}
/* The root nearest neutral PTCH, as the musician's reference note. */
static int root_pitch(unsigned root) { return root <= 6 ? (int)root : (int)root - 12; }

/* ---- generation ------------------------------------------------------------ */
typedef struct {
    int lad[25]; unsigned n, home;
    unsigned hold, full, soft;
} Ctx;
static void context(Ctx *c, const SgParams *p, unsigned base_volume) {
    int span = (int)limit(p->span, 12);
    c->n = ladder(c->lad, -span, span, p->root, p->scale);
    if (!c->n) { c->lad[0] = sg_fit(0, p->root, p->scale); c->n = 1; }
    c->home = nearest_index(c->lad, c->n, root_pitch(p->root));
    c->hold = limit(p->gate, 127);
    c->full = limit(base_volume, 127);
    c->soft = c->full * (254u - limit(p->accent, 127)) / 254u;
}
static int degree(const Ctx *c, int offset) {
    int i = (int)c->home + offset;
    if (i < 0) i = 0;
    if (i >= (int)c->n) i = (int)c->n - 1;
    return c->lad[i];
}
static int random_pitch(const Ctx *c, Rng *r) { return c->lad[below(r, c->n)]; }
static unsigned note_hold(const Ctx *c, Rng *r) {
    if (c->hold >= 127) return 127;                  /* tie: INF hold */
    return c->hold * (2u + below(r, 3)) / 4u;
}
static void note(SgStep *s, int pitch, unsigned hold, unsigned volume) {
    s->on = 1; s->pitch = (int8_t)pitch;
    s->hold = (uint8_t)limit(hold, 127); s->volume = (uint8_t)limit(volume, 127);
}
/* Choose `count` of the `n` positions with the highest weight+random rank.
 * Insertion sort: at most 2016 comparisons at 64 steps. */
static void pick(uint8_t *on, unsigned n, unsigned count, const uint16_t *weight, Rng *r) {
    unsigned order[SG_STEPS]; uint32_t rank[SG_STEPS];
    for (unsigned i = 0; i < n; ++i) {
        rank[i] = (rnd(r) & 0xffffu) + (uint32_t)weight[i] * 0x10000u;
        unsigned j = i;
        while (j && rank[order[j - 1]] < rank[i]) { order[j] = order[j - 1]; --j; }
        order[j] = i;
    }
    for (unsigned i = 0; i < n; ++i) on[i] = 0;
    for (unsigned i = 0; i < count && i < n; ++i) on[order[i]] = 1;
}
static unsigned share(unsigned n, unsigned density) { return (n * limit(density, 16) + 8u) / 16u; }

static void gen_acid(SgPhrase *ph, const Ctx *c, unsigned L, unsigned dens, Rng *r) {
    uint8_t on[SG_STEPS]; uint16_t w[SG_STEPS];
    for (unsigned i = 0; i < L; ++i) w[i] = (uint16_t)(i % 4u == 0 ? 2 : i % 2u == 0);
    pick(on, L, share(L, dens), w, r);
    int last = degree(c, 0);
    for (unsigned i = 0; i < L; ++i) {
        if (!on[i]) continue;
        unsigned roll = below(r, 100); int pitch;
        if (roll < 35) pitch = degree(c, 0);
        else if (roll < 70) {   /* a neighbouring scale tone of the last note */
            int at = (int)nearest_index(c->lad, c->n, last) + (int)below(r, 3) - 1;
            pitch = c->lad[at < 0 ? 0 : at >= (int)c->n ? (int)c->n - 1 : at];
        } else pitch = random_pitch(c, r);
        if (below(r, 7) == 0 && pitch + 12 <= c->lad[c->n - 1]) pitch += 12;   /* octave jump */
        note(&ph->steps[i], pitch, note_hold(c, r), below(r, 4) == 0 ? c->full : c->soft);
        if (i && on[i - 1] && below(r, 6) == 0) ph->steps[i].slide = 1;
        last = pitch;
    }
}
static void gen_barl(SgPhrase *ph, const Ctx *c, unsigned L, unsigned dens, Rng *r, unsigned root, unsigned scale) {
    unsigned half = (L + 1u) / 2u; uint8_t on[SG_STEPS]; uint16_t w[SG_STEPS];
    for (unsigned i = 0; i < half; ++i) w[i] = (uint16_t)(i % 2u == 0);
    pick(on, half, share(half, dens), w, r);
    int home = degree(c, 0);
    for (unsigned i = 0; i < half; ++i) {
        if (!on[i]) continue;
        unsigned roll = below(r, 100); int pitch = home;
        if (roll >= 50 && roll < 70 && home + 12 <= c->lad[c->n - 1]) pitch = home + 12;
        else if (roll >= 50 && roll < 70 && home - 12 >= c->lad[0]) pitch = home - 12;
        else if (roll >= 70 && roll < 90 && sg_in_scale(home + 7, root, scale) && home + 7 <= c->lad[c->n - 1]) pitch = home + 7;
        else if (roll >= 90) pitch = random_pitch(c, r);
        note(&ph->steps[2u * i], pitch, note_hold(c, r), i % 2u == 0 ? c->full : c->soft);
    }
}
/* A cell of `cell` steps tiled across L; `drift` evolves each repetition. */
static void gen_cell(SgPhrase *ph, const Ctx *c, unsigned L, unsigned cell, unsigned dens,
                     unsigned drift, Rng *r) {
    SgStep proto[8]; uint8_t on[8]; uint16_t w[8];
    for (unsigned i = 0; i < 8; ++i) { SgStep z = {0}; proto[i] = z; w[i] = 0; }   /* no memset in the DRAM unit */
    if (cell > 8) cell = 8;
    unsigned count = share(cell, dens); if (!count && dens) count = 1;
    w[0] = 1; pick(on, cell, count, w, r);
    for (unsigned i = 0; i < cell; ++i)
        if (on[i]) note(&proto[i], random_pitch(c, r), note_hold(c, r), i == 0 ? c->full : c->soft);
    for (unsigned i = 0; i < L; ++i) {
        unsigned k = i % cell;
        if (i && k == 0 && drift) {
            /* OBLQ: one element moves a scale step (radical: any tone). */
            unsigned j = below(r, cell);
            if (proto[j].on) {
                unsigned at = nearest_index(c->lad, c->n, proto[j].pitch);
                if (drift > 1) proto[j].pitch = (int8_t)random_pitch(c, r);
                else proto[j].pitch = (int8_t)c->lad[(at + c->n + (below(r, 2) ? 1u : c->n - 1u)) % c->n];
                proto[j].hold = (uint8_t)note_hold(c, r);
            }
        }
        ph->steps[i] = proto[k];
    }
}
static void gen_rand(SgPhrase *ph, const Ctx *c, unsigned L, unsigned dens, Rng *r) {
    for (unsigned i = 0; i < L; ++i) {
        if (below(r, 16) >= dens) continue;
        unsigned vol = c->soft + below(r, c->full - c->soft + 1u);
        unsigned hold = c->hold >= 127 ? 127 : 1u + below(r, c->hold ? c->hold : 1u);
        note(&ph->steps[i], random_pitch(c, r), hold, vol);
    }
}
static void gen_eucl(SgPhrase *ph, const Ctx *c, unsigned L, unsigned dens, Rng *r) {
    unsigned k = share(L, dens), rot = below(r, L), first = 1;
    for (unsigned i = 0; i < L; ++i) {
        unsigned j = (i + L - rot) % L;
        if (!k || (j * k) % L >= k) continue;
        note(&ph->steps[i], degree(c, 0), note_hold(c, r), first ? c->full : c->soft);
        first = 0;
    }
}
static void gen_tekn(SgPhrase *ph, const Ctx *c, unsigned L, unsigned dens, Rng *r) {
    int set[6]; unsigned m = 1u + limit(dens, 16) / 3u;
    if (m > 6) m = 6;
    for (unsigned i = 0; i < m; ++i) set[i] = i ? random_pitch(c, r) : degree(c, 0);
    unsigned fill = dens ? 30u + 4u * limit(dens, 16) : 0u;   /* DENS 0 is silence */
    for (unsigned i = 0; i < L; ++i) {
        if (!chance(r, fill)) continue;
        note(&ph->steps[i], set[below(r, m)], note_hold(c, r), i % 4u == 0 ? c->full : c->soft);
        if (i && ph->steps[i - 1].on && ph->steps[i - 1].pitch == ph->steps[i].pitch && below(r, 3) == 0)
            ph->steps[i].slide = 1;
    }
}
static void gen_mirr(SgPhrase *ph, const Ctx *c, unsigned L, unsigned dens, Rng *r) {
    static const uint8_t sizes[3] = {2, 4, 8};
    int cell[8]; unsigned m = sizes[below(r, 3)];
    for (unsigned i = 0; i < m; ++i) cell[i] = random_pitch(c, r);
    uint8_t on[SG_STEPS]; uint16_t w[SG_STEPS];
    for (unsigned i = 0; i < L; ++i) w[i] = (uint16_t)(i % m == 0);
    pick(on, L, share(L, dens), w, r);
    for (unsigned i = 0; i < L; ++i) {
        unsigned rep = i / m, k = i % m;
        if (k == 0 && rep) {   /* break the symmetry: swap two cell tones */
            unsigned a = below(r, m), b = below(r, m); int t = cell[a]; cell[a] = cell[b]; cell[b] = t;
        }
        unsigned at = rep % 2u ? m - 1u - k : k;   /* every other pass mirrored */
        if (on[i]) note(&ph->steps[i], cell[at], note_hold(c, r), k == 0 ? c->full : c->soft);
    }
}
static void gen_drum(SgPhrase *ph, const Ctx *c, unsigned L, unsigned dens, Rng *r) {
    uint8_t on[SG_STEPS]; uint16_t w[SG_STEPS];
    for (unsigned i = 0; i < L; ++i) w[i] = (uint16_t)(i % 8u == 0 ? 3 : i % 4u == 0 ? 2 : i % 2u == 0);
    pick(on, L, share(L, dens), w, r);
    for (unsigned i = 0; i < L; ++i) {
        if (!on[i]) continue;
        note(&ph->steps[i], 0, note_hold(c, r), i % 4u == 0 ? c->full : c->soft);
        ph->steps[i].pitch = SG_PITCH_NONE;
    }
}

static void clear(SgPhrase *ph) {
    for (unsigned i = 0; i < SG_STEPS; ++i) {
        SgStep *s = &ph->steps[i];
        s->on = s->slide = s->chance = s->retrig = 0; s->micro = 0;
        s->hold = s->volume = SG_NO_LOCK; s->pitch = SG_PITCH_NONE;
    }
}
/* PROB, RTCH and GRV decorate generated notes; zero writes nothing. */
static void decorate(SgPhrase *ph, const SgParams *p, Rng *r) {
    static const uint8_t pcts[5] = {50, 59, 67, 75, 87};
    for (unsigned i = 0; i < ph->length; ++i) {
        SgStep *s = &ph->steps[i];
        if (!s->on) continue;
        if (p->prob && chance(r, p->prob)) s->chance = pcts[below(r, 5)];
        if (p->ratchet && chance(r, p->ratchet)) s->retrig = (uint8_t)(2u + below(r, 3));
        if (p->groove) s->micro = (int8_t)((int)below(r, 2u * p->groove + 1u) - (int)p->groove);
    }
}
int sg_generate(SgPhrase *ph, const SgParams *in, unsigned L, unsigned base_volume) {
    if (!ph || !in || !L || L > SG_STEPS || base_volume > 127) return 0;
    SgParams p = *in; sg_clamp(&p);
    Ctx c; context(&c, &p, base_volume);
    Rng r = {hash32(0x5e9e0000u ^ p.seed ^ (uint32_t)p.algo << 8)};
    clear(ph); ph->length = (uint8_t)L;
    switch (p.algo) {
    case SG_ALGO_ACID: gen_acid(ph, &c, L, p.density, &r); break;
    case SG_ALGO_BARL: gen_barl(ph, &c, L, p.density, &r, p.root, p.scale); break;
    case SG_ALGO_CELL: { static const uint8_t n[3] = {3, 5, 7};
        gen_cell(ph, &c, L, n[below(&r, 3)], p.density, 0, &r); break; }
    case SG_ALGO_OBLQ: gen_cell(ph, &c, L, 2u + below(&r, 6), p.density, 1, &r); break;
    case SG_ALGO_RAND: gen_rand(ph, &c, L, p.density, &r); break;
    case SG_ALGO_EUCL: gen_eucl(ph, &c, L, p.density, &r); break;
    case SG_ALGO_TEKN: gen_tekn(ph, &c, L, p.density, &r); break;
    case SG_ALGO_MIRR: gen_mirr(ph, &c, L, p.density, &r); break;
    default: gen_drum(ph, &c, L, p.density, &r); break;
    }
    if (c.hold >= 127)   /* GATE INF ties consecutive notes with slides */
        for (unsigned i = 1; i < L; ++i)
            if (ph->steps[i].on && ph->steps[i - 1].on) ph->steps[i].slide = 1;
    decorate(ph, &p, &r);
    sg_transpose(ph, &p, (int)p.transpose - 12);
    return 1;
}

/* ---- transforms ----------------------------------------------------------- */
static int pitched(const SgStep *s) { return s->on && s->pitch != SG_PITCH_NONE; }
void sg_transpose(SgPhrase *ph, const SgParams *p, int degrees) {
    int lad[25]; unsigned n = ladder(lad, -12, 12, p->root, p->scale);
    if (!ph || !n || !degrees) return;
    for (unsigned i = 0; i < ph->length; ++i) {
        SgStep *s = &ph->steps[i];
        if (!pitched(s)) continue;
        int at = (int)nearest_index(lad, n, s->pitch) + degrees;
        if (at < 0) at = 0;
        if (at >= (int)n) at = (int)n - 1;
        s->pitch = (int8_t)lad[at];
    }
}
void sg_invert(SgPhrase *ph, const SgParams *p) {
    int axis = root_pitch(p->root);
    for (unsigned i = 0; i < ph->length; ++i)
        if (pitched(&ph->steps[i]))
            ph->steps[i].pitch = (int8_t)sg_fit(2 * axis - ph->steps[i].pitch, p->root, p->scale);
}
void sg_double(SgPhrase *ph) {
    unsigned half = ph->length / 2u;
    if (!half) return;
    for (unsigned i = half; i < ph->length; ++i) ph->steps[i] = ph->steps[i - half];
}
void sg_fit_phrase(SgPhrase *ph, const SgParams *p) {
    for (unsigned i = 0; i < ph->length; ++i)
        if (pitched(&ph->steps[i]))
            ph->steps[i].pitch = (int8_t)sg_fit(ph->steps[i].pitch, p->root, p->scale);
}

/* ---- mutation ------------------------------------------------------------- */
static void shuffle_fields(SgPhrase *ph, unsigned amount, unsigned fields, Rng *r) {
    unsigned idx[SG_STEPS], n = 0;
    for (unsigned i = 0; i < ph->length; ++i)
        if (ph->steps[i].on && chance(r, amount)) idx[n++] = i;
    for (unsigned i = n; i > 1; --i) {           /* Fisher-Yates over the chosen steps */
        unsigned j = below(r, i);
        SgStep *a = &ph->steps[idx[i - 1]], *b = &ph->steps[idx[j]];
        if (fields & 1u) { int8_t t = a->pitch; a->pitch = b->pitch; b->pitch = t; }
        if (fields & 2u) { uint8_t t = a->hold; a->hold = b->hold; b->hold = t; }
        if (fields & 4u) { uint8_t t = a->volume; a->volume = b->volume; b->volume = t; }
    }
}
int sg_evolve(SgPhrase *ph, const SgParams *in, unsigned base_volume, uint32_t seed) {
    if (!ph || !in || !ph->length || ph->length > SG_STEPS || base_volume > 127) return 0;
    SgParams p = *in; sg_clamp(&p);
    Ctx c; context(&c, &p, base_volume);
    Rng r = {hash32(0xe7010000u ^ seed ^ (uint32_t)p.evo << 8)};
    unsigned amount = p.amount;
    switch (p.evo) {
    case SG_EVO_SWIZ: shuffle_fields(ph, amount, 7, &r); return 1;
    case SG_EVO_SWP:  shuffle_fields(ph, amount, 1, &r); return 1;
    case SG_EVO_SWG:  shuffle_fields(ph, amount, 2, &r); return 1;
    case SG_EVO_SWV:  shuffle_fields(ph, amount, 4, &r); return 1;
    default: break;
    }
    unsigned reach = p.evo == SG_EVO_LOW ? 1u : 2u;
    for (unsigned i = 0; i < ph->length; ++i) {
        SgStep *s = &ph->steps[i];
        if (!chance(&r, amount)) continue;
        if (p.evo != SG_EVO_LOW && below(&r, 2) == 0) {   /* MED/HIGH toggle notes */
            if (s->on) { s->on = 0; s->slide = 0; continue; }
            int pitch = ph->steps[i ? i - 1 : 0].pitch;
            note(s, pitch == SG_PITCH_NONE ? random_pitch(&c, &r) : pitch,
                 note_hold(&c, &r), c.soft);
            if (pitch == SG_PITCH_NONE) s->pitch = SG_PITCH_NONE;
            continue;
        }
        if (!pitched(s)) continue;
        if (p.evo == SG_EVO_HIGH) { s->pitch = (int8_t)random_pitch(&c, &r); s->hold = (uint8_t)note_hold(&c, &r); continue; }
        int at = (int)nearest_index(c.lad, c.n, s->pitch);
        int step = 1 + (int)below(&r, reach);
        at += below(&r, 2) ? step : -step;
        if (at < 0) at = 0;
        if (at >= (int)c.n) at = (int)c.n - 1;
        s->pitch = (int8_t)c.lad[at];
    }
    sg_fit_phrase(ph, &p);
    return 1;
}

/* ---- the native record ---------------------------------------------------- */
static unsigned bit(const uint8_t *rec, unsigned mask, unsigned step) {
    return (rec[mask * 8u + 7u - step / 8u] >> (step % 8u)) & 1u;
}
static void setbit(uint8_t *rec, unsigned mask, unsigned step, unsigned v) {
    uint8_t *b = rec + mask * 8u + 7u - step / 8u, m = (uint8_t)(1u << (step % 8u));
    *b = v ? (uint8_t)(*b | m) : (uint8_t)(*b & (uint8_t)~m);
}
static uint8_t ptch_lock(int semis) { return (uint8_t)(64 + 5 * semis); }
static int ptch_semis(uint8_t lock) {
    int d = (int)lock - 64;
    int s = d >= 0 ? (d + 2) / 5 : -((-d + 2) / 5);
    return s < -12 ? -12 : s > 12 ? 12 : s;
}
int sg_read_phrase(SgPhrase *ph, const uint8_t *rec, size_t size, unsigned L) {
    if (!ph || !rec || size < SG_TRACK_BYTES || !L || L > SG_STEPS) return 0;
    clear(ph); ph->length = (uint8_t)L;
    for (unsigned i = 0; i < L; ++i) {
        const uint8_t *lk = rec + SG_LOCKS + 32u * i;
        SgStep *s = &ph->steps[i];
        s->on = (uint8_t)bit(rec, SG_MASK_TRIG, i);
        s->slide = (uint8_t)bit(rec, SG_MASK_SLIDE, i);
        s->pitch = (int8_t)(lk[SG_SLOT_PTCH] == SG_NO_LOCK ? SG_PITCH_NONE : ptch_semis(lk[SG_SLOT_PTCH]));
        s->hold = lk[SG_SLOT_HOLD] > 127 ? SG_NO_LOCK : lk[SG_SLOT_HOLD];
        s->volume = lk[SG_SLOT_VOL] > 127 ? SG_NO_LOCK : lk[SG_SLOT_VOL];
    }
    return 1;
}
/* Owned per step: the trig and slide bits, PTCH/HOLD/VOL locks; RTRG/RTIM
 * and the trig word only where this phrase sets them. Steps past the track
 * length, swing, recorder masks and every other lock are preserved. */
int sg_write_phrase(uint8_t *rec, size_t size, const SgPhrase *ph) {
    if (!rec || size < SG_TRACK_BYTES || !ph || !ph->length || ph->length > SG_STEPS) return 0;
    for (unsigned i = 0; i < ph->length; ++i) {      /* validate before the first store */
        const SgStep *s = &ph->steps[i];
        if (s->on > 1 || s->slide > 1 || s->retrig > 4 || s->chance > 100) return 0;
        if (s->micro < -23 || s->micro > 23) return 0;
        if (s->pitch != SG_PITCH_NONE && (s->pitch < -12 || s->pitch > 12)) return 0;
        if ((s->hold > 127 && s->hold != SG_NO_LOCK) || (s->volume > 127 && s->volume != SG_NO_LOCK)) return 0;
    }
    for (unsigned i = 0; i < ph->length; ++i) {
        const SgStep *s = &ph->steps[i];
        uint8_t *lk = rec + SG_LOCKS + 32u * i;
        unsigned was = bit(rec, SG_MASK_TRIG, i);
        lk[SG_SLOT_PTCH] = s->on && s->pitch != SG_PITCH_NONE ? ptch_lock(s->pitch) : SG_NO_LOCK;
        lk[SG_SLOT_HOLD] = s->on ? s->hold : SG_NO_LOCK;
        lk[SG_SLOT_VOL] = s->on ? s->volume : SG_NO_LOCK;
        if (s->on && s->retrig) {
            /* RTRG byte n shows n+1 hits (EMU/READ, 1.40C). RTIM 79/72/67 =
             * 1/2, 1/3, 1/4 step, so every hit stays inside the step. The
             * audible hit count is unconfirmed on hardware (TESTING.md). */
            static const uint8_t rtim[5] = {0, 0, 79, 72, 67};
            lk[SG_SLOT_RTRG] = (uint8_t)(s->retrig - 1u); lk[SG_SLOT_RTIM] = rtim[s->retrig];
        }
        setbit(rec, SG_MASK_TRIG, i, s->on);
        setbit(rec, SG_MASK_SLIDE, i, s->on && s->slide);
        if (was != s->on) {
            /* A changed note starts clean: stale conditions, micro-timing,
             * trigless or one-shot state must not hide or move it. */
            rec[SG_TRIGWORD + 2u * i] = rec[SG_TRIGWORD + 2u * i + 1u] = 0;
            setbit(rec, SG_MASK_TRIGLESS, i, 0); setbit(rec, SG_MASK_ONESHOT, i, 0);
        }
        if (s->on && (s->chance || s->micro)) {
            /* Bits 13..15 are unexplained in 1.40C: keep whatever is there. */
            uint16_t keep = (uint16_t)((rec[SG_TRIGWORD + 2u * i] & 0xe0u) << 8);
            uint16_t w = (uint16_t)(sg_trig_word(s->chance, s->micro) | keep);
            rec[SG_TRIGWORD + 2u * i] = (uint8_t)(w >> 8);
            rec[SG_TRIGWORD + 2u * i + 1u] = (uint8_t)w;
        }
        unsigned locked = 0;
        for (unsigned k = 0; k < 32; ++k) locked |= lk[k] != SG_NO_LOCK;
        setbit(rec, SG_MASK_PLOCK, i, !s->on && locked);
    }
    return 1;
}
int sg_rotate_record(uint8_t *rec, size_t size, unsigned L, int dir) {
    if (!rec || size < SG_TRACK_BYTES || L < 2 || L > SG_STEPS || (dir != 1 && dir != -1)) return 0;
    uint8_t first[32 + 2], bits[10];
    unsigned from = dir > 0 ? L - 1u : 0u;   /* the step that wraps around */
    for (unsigned m = 0; m < 10; ++m) bits[m] = (uint8_t)bit(rec, m, from);
    for (unsigned k = 0; k < 32; ++k) first[k] = rec[SG_LOCKS + 32u * from + k];
    first[32] = rec[SG_TRIGWORD + 2u * from]; first[33] = rec[SG_TRIGWORD + 2u * from + 1u];
    for (unsigned n = 0; n + 1u < L; ++n) {
        unsigned to = dir > 0 ? L - 1u - n : n, src = dir > 0 ? to - 1u : to + 1u;
        for (unsigned m = 0; m < 10; ++m) if (m != SG_MASK_SWING) setbit(rec, m, to, bit(rec, m, src));
        for (unsigned k = 0; k < 32; ++k) rec[SG_LOCKS + 32u * to + k] = rec[SG_LOCKS + 32u * src + k];
        rec[SG_TRIGWORD + 2u * to] = rec[SG_TRIGWORD + 2u * src];
        rec[SG_TRIGWORD + 2u * to + 1u] = rec[SG_TRIGWORD + 2u * src + 1u];
    }
    unsigned to = dir > 0 ? 0u : L - 1u;
    for (unsigned m = 0; m < 10; ++m) if (m != SG_MASK_SWING) setbit(rec, m, to, bits[m]);
    for (unsigned k = 0; k < 32; ++k) rec[SG_LOCKS + 32u * to + k] = first[k];
    rec[SG_TRIGWORD + 2u * to] = first[32]; rec[SG_TRIGWORD + 2u * to + 1u] = first[33];
    return 1;
}
int sg_fit_record(uint8_t *rec, size_t size, const SgParams *p) {
    if (!rec || size < SG_TRACK_BYTES || !p) return 0;
    for (unsigned i = 0; i < SG_STEPS; ++i) {
        uint8_t *lk = rec + SG_LOCKS + 32u * i;
        if (lk[SG_SLOT_PTCH] == SG_NO_LOCK || lk[SG_SLOT_PTCH] > 127) continue;
        lk[SG_SLOT_PTCH] = ptch_lock(sg_fit(ptch_semis(lk[SG_SLOT_PTCH]), p->root, p->scale));
    }
    return 1;
}

/* ---- trig word (1.40C, confirmed in the emulator; TESTING.md) ------------- */
/* Codes: 0 none, 1-8 FILL/!FILL/PRE/!PRE/NEI/!NEI/1ST/!1ST, 9-29 the X% list
 * below, then A:B = 28 + B(B-1)/2 + A up to 64. Micro-timing: signed bits
 * 7..12 in 1/384 note (24 per 16th step), clamped to +/-23 by the UI. */
static const uint8_t stock_pct[21] = {1, 2, 4, 6, 9, 13, 19, 25, 33, 41, 50,
                                      59, 67, 75, 81, 87, 91, 94, 96, 98, 99};
int sg_chance_code(unsigned percent) {
    if (!percent || percent >= 100) return 0;
    unsigned best = 0, dist = 1000;
    for (unsigned i = 0; i < 21; ++i) {
        unsigned d = stock_pct[i] > percent ? stock_pct[i] - percent : percent - stock_pct[i];
        if (d < dist) { dist = d; best = i; }
    }
    return 9 + (int)best;
}
uint16_t sg_trig_word(unsigned chance_pct, int micro) {
    if (micro < -23) micro = -23;
    if (micro > 23) micro = 23;
    unsigned m = (unsigned)micro & 0x3fu;   /* six-bit two's complement */
    return (uint16_t)((m << 7) | (unsigned)sg_chance_code(chance_pct));
}
