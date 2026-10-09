# SEQGEN testing

## Commands and exact revision

Firmware-free engine gate, run in the cloud workspace (Linux, cc, ASan/UBSan) on 9 October 2026:

```sh
python3 sdk/octabam/modules/seqgen/verify.py
```

Result: passed. 116,640 generation cases (9 algorithms × 18 scales × 3 roots × 8 lengths × 5 densities × 6 seeds, with PROB/RTCH/GRV/GATE/TRNS varied) are deterministic, stay in −12..+12 and in the scale, write nothing at DENS 0 and no conditions/micro-timing at PROB/GRV 0. Also covered: all seven evolve styles, transforms, settings packing for every control value, the record writer (preserves swing, recorder masks, unrelated locks and steps past the length; refuses invalid input without writing), reversible rotation and PTCH re-fit.

This proves the engine logic only. It runs no firmware, native glue, emulator or hardware.

## Unverified encodings

To check under the port before any PROB, GRV or RTCH value is used on a unit:

- trig word at record `+0x89a + 2·step`: condition code in bits 0..6 (X% codes assumed to start at 9), micro-timing as six-bit two's complement in bits 7..12;
- RTRG/RTIM lock values for 2–4 retrigs.

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
