/* SEQGEN phrase engine: original generator, mutation and scale code.
 * Copyright (c) 2026 yes0have0some. MIT. Musical inspiration: the five12
 * Vector sequencer's user guide; no five12 code, firmware or assets used.
 * Firmware-free: no stock addresses, no DSP, no MIDI. The native adapter
 * owns all reads and writes of live RAM and calls these on the UI task. */
#ifndef SEQGEN_ENGINE_H
#define SEQGEN_ENGINE_H
#include <stdint.h>
#include <stddef.h>

#define SG_STEPS 64u
/* One native audio track record (OS 1.40C), as documented by octabam's
 * EUCLID/KYOTI notes, the VECTOR writer and the quantizer's measurements:
 * ten 8-byte big-endian step masks (byte 7 = steps 1-8), track length
 * +0x50, scale +0x51, 32 lock slots per step from +0x59, and one 16-bit
 * trig word per step from +0x89a (micro-timing in bits 7..12). */
#define SG_TRACK_BYTES 0x91au
#define SG_LOCKS 0x59u
#define SG_TRIGWORD 0x89au
#define SG_NO_LOCK 255u
enum { SG_MASK_TRIG = 0, SG_MASK_TRIGLESS = 1, SG_MASK_PLOCK = 2,
       SG_MASK_ONESHOT = 3, SG_MASK_SWING = 8, SG_MASK_SLIDE = 9 };
/* Lock slots by page: PLAYBACK 0-5, LFO 6-11, AMP 12-17, FX1 18-23, FX2 24-29. */
enum { SG_SLOT_PTCH = 0, SG_SLOT_RTRG = 4, SG_SLOT_RTIM = 5,
       SG_SLOT_HOLD = 13, SG_SLOT_VOL = 15 };

enum { SG_ALGO_ACID, SG_ALGO_BARL, SG_ALGO_CELL, SG_ALGO_OBLQ, SG_ALGO_RAND,
       SG_ALGO_EUCL, SG_ALGO_TEKN, SG_ALGO_MIRR, SG_ALGO_DRUM, SG_ALGO_COUNT };
enum { SG_EVO_LOW, SG_EVO_MED, SG_EVO_HIGH, SG_EVO_SWIZ, SG_EVO_SWP,
       SG_EVO_SWG, SG_EVO_SWV, SG_EVO_COUNT };
#define SG_SCALE_COUNT 18u
#define SG_PITCH_NONE (-128)

/* Every SEQGEN control, in page order: GEN A-F, EVO A-F, KEY A-D.
 * INV and DBL (KEY E-F) are actions and are not stored. */
typedef struct {
    uint8_t algo, density, span, gate, accent, seed;      /* GEN */
    uint8_t evo, amount, autoloops, prob, ratchet, groove; /* EVO */
    uint8_t root, scale, fit, transpose;                   /* KEY: transpose 0..24, 12 = 0 */
} SgParams;

/* One generated step. pitch is semitones from neutral PTCH (-12..+12) or
 * SG_PITCH_NONE for a trig without a pitch lock (DRUM). */
typedef struct {
    uint8_t on, slide, hold, volume;
    int8_t pitch;
    uint8_t chance;   /* 0 = none, otherwise percent (stock X% condition) */
    int8_t micro;     /* stock micro-timing units, -23..+23 */
    uint8_t retrig;   /* 0 = none, otherwise 2..4 retrigs */
} SgStep;
typedef struct { SgStep steps[SG_STEPS]; uint8_t length; } SgPhrase;

extern const SgParams sg_defaults;
extern const char *const sg_control_names[16];
extern const uint8_t sg_control_max[16];
extern const char *const sg_algo_names[SG_ALGO_COUNT];
extern const char *const sg_evo_names[SG_EVO_COUNT];
extern const char *const sg_scale_names[SG_SCALE_COUNT];
extern const uint16_t sg_scale_masks[SG_SCALE_COUNT];
extern const uint8_t sg_autoloop_values[6];

uint8_t sg_get(const SgParams *p, unsigned control);
void sg_set(SgParams *p, unsigned control, unsigned value);
void sg_clamp(SgParams *p);
/* Twelve bytes; never more. */
#define SG_PACKED_BYTES 12u
void sg_pack(uint8_t out[SG_PACKED_BYTES], const SgParams *p);
void sg_unpack(SgParams *p, const uint8_t in[SG_PACKED_BYTES]);

/* Pitch helpers. All results stay inside -12..+12 and the scale. */
int sg_in_scale(int pitch, unsigned root, unsigned scale);
int sg_fit(int pitch, unsigned root, unsigned scale);

/* Generate, mutate and transform a logical phrase of 1..64 steps.
 * base_volume is the Part's AMP VOL. Every function is deterministic for
 * a given seed and has a fixed worst-case bound (no recursion, no heap). */
int sg_generate(SgPhrase *out, const SgParams *p, unsigned length, unsigned base_volume);
int sg_evolve(SgPhrase *ph, const SgParams *p, unsigned base_volume, uint32_t seed);
void sg_transpose(SgPhrase *ph, const SgParams *p, int degrees);
void sg_invert(SgPhrase *ph, const SgParams *p);
void sg_double(SgPhrase *ph);
void sg_fit_phrase(SgPhrase *ph, const SgParams *p);
uint32_t sg_next_seed(uint32_t seed);

/* Native record access: one track record only. */
int sg_read_phrase(SgPhrase *out, const uint8_t *record, size_t size, unsigned length);
int sg_write_phrase(uint8_t *record, size_t size, const SgPhrase *ph);
/* Rotate every per-step field of the record (masks except swing, locks
 * and trig words) by +1 or -1 step within the track length. Swing stays
 * on the track grid, as sequencing.md requires. */
int sg_rotate_record(uint8_t *record, size_t size, unsigned length, int direction);
/* Re-fit only the PTCH locks of the record to the scale (FIT = ON). */
int sg_fit_record(uint8_t *record, size_t size, const SgParams *p);

/* Trig-word encoding, confirmed in the 1.40C emulator: condition code in
 * bits 0..6, signed micro-timing in bits 7..12; bits 13..15 preserved.
 * Generation writes neither unless PROB/GRV are above zero. */
uint16_t sg_trig_word(unsigned chance, int micro);
int sg_chance_code(unsigned percent);
#endif
