# SEQGEN testing

## Commands and exact revision

Firmware-free engine gate, run in the cloud workspace (Linux, cc, ASan/UBSan) on 9 October 2026:

```sh
python3 sdk/octabam/modules/seqgen/verify.py
```

Result: passed. 116,640 generation cases (9 algorithms × 18 scales × 3 roots × 8 lengths × 5 densities × 6 seeds, with PROB/RTCH/GRV/GATE/TRNS varied) are deterministic, stay in −12..+12 and in the scale, write nothing at DENS 0 and no conditions/micro-timing at PROB/GRV 0. Also covered: all seven evolve styles, transforms, settings packing for every control value, the record writer (preserves swing, recorder masks, unrelated locks and steps past the length; refuses invalid input without writing), reversible rotation and PTCH re-fit.

This proves the engine logic only. It runs no firmware, native glue, emulator or hardware.

## Encodings (OS 1.40C, emulator and disassembly, 9 October 2026)

Read on the author's computer from his own 1.40C image (MAIN OS SHA-256 prefix `164f3122`), with `ot_emu` in MKI mode on a blank scratch card. No firmware, listing or dump is committed. No hardware was used.

- Trig word at record `+0x89a + 2·step`, big-endian. EMU readbacks of stock panel edits: new trig `0x0000`, micro +1 `0x0080`, FILL `0x0081`, 1% `0x0089`, micro −3 `0x1e80`, −23 `0x1480`, +23 `0x0b80`; condition codes 19, 30 and 64 read back as expected. READ: the condition tester takes `word & 0x7f`; micro-timing is signed bits 7..12 in 1/384 note. Codes: 0 none, 1–8 FILL/!FILL/PRE/!PRE/NEI/!NEI/1ST/!1ST, 9–29 the X% list (50 % = 19, 87 % = 24), A:B = 28 + B(B−1)/2 + A. Bits 13..15 never appeared and are preserved. `test_engine.c` asserts these readbacks.
- RTRG lock byte n is displayed as n+1 (EMU and READ); RTIM 79/72/67 display 1/2, 1/3 and 1/4 step. SEQGEN writes RTRG 1–3 with those RTIM values for 2–4 hits. **Not confirmed:** that the unit plays that many audible hits; this needs a hardware or audio-capture check.

## Stock flows

Not tested.

## Performance

Not run. `evidence/performance.json` (ColdFire template) comes after the native build.

## Resources

Unmeasured.

## Hardware

Untested. Hardware results are recorded only as reported by the tester.

## OT UI capture evidence

Pending.
