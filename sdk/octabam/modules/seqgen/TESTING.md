# SEQGEN testing

## Commands and exact revision

Firmware-free engine gate, run in the cloud workspace (Linux, cc, ASan/UBSan) on 9 October 2026:

```sh
python3 sdk/octabam/modules/seqgen/verify.py
```

Result: passed. 116,640 generation cases (9 algorithms × 18 scales × 3 roots × 8 lengths × 5 densities × 6 seeds, with PROB/RTCH/GRV/GATE/TRNS varied) are deterministic, stay in −12..+12 and in the scale, write nothing at DENS 0 and no conditions/micro-timing at PROB/GRV 0. Also covered: all seven evolve styles, transforms, settings packing for every control value, the record writer (preserves swing, recorder masks, unrelated locks and steps past the length; refuses invalid input without writing), reversible rotation and PTCH re-fit.

This proves the engine logic only. It runs no firmware, native glue, emulator or hardware.

Since the native glue landed, `verify.py` also rebuilds `control.s` with `prepare.py` and requires it to be byte-identical. It needs `m68k-elf-gcc`, so run it in the toolchain image:

```sh
docker run --rm --network none -v "$PWD/sdk/octabam/modules/seqgen":/m -w /m modwerk-source-tools python3 -B verify.py
```

Result on the author's Mac (9 October 2026, image `modwerk-source-tools` built from `sdk/build/Dockerfile`, GCC 16.2.0): passed.

`prepare.py` refuses any compiled instruction that reuses an auto-incremented address register in its other operand, and compiles with `-fno-ivopts`. Under the emulator, GCC's `move.b (%a0)+,(%a0,%d1.l)` in the undo copy wrote every byte one place late (the destination sees the incremented `a0`); the refusal and the flag remove that shape. VECTOR's unit has none.

## Emulator walk (9 October 2026)

Image: original 1.40C plus SEQGEN only (static stock DSP), built on the author's Mac from this branch with octabam's `build_bus.py` in the toolchain image. MAIN OS SHA-256 `95f9b81aab82749e550f83d3ae67ba77e11a1a7d51c930fbf6685a15baf1b076`. `ot_emu` built from this branch (SHA-256 `1955bc62…`), no DSP, blank scratch card, the stock first-boot DATE/TIME prompt confirmed with YES. MKI panel unless noted. Driven by key and encoder commands over `--interactive`, reading RAM with `peek`. The private driver and image stay on the author's computer.

Measured:

- **Menu.** FUNC + MIXER > CONTROL shows seven rows ending in SEQGEN; YES on it opens the SEQGEN window over the menu and pushes one layer above the menu's (`0x400cbf2c`). The same with the MKII panel (MENU key).
- **Stock CONTROL rows unchanged.** Each of AUDIO, INPUT, SEQUENCER, MIDI SEQUENCER, MEMORY and METRONOME opens a page whose screen hash equals the unmodified 1.40C's, with the same page id (2-7). NO from CONTROL and from the top-level menu gives the same screens and layer list as stock. MKI and MKII.
- **Edits reach the track record.** On T1 (Static, 16 steps): DENS +2 wrote trigs on 12 steps with PTCH locks; ALGO +1 rewrote it; YES generated a new variation; FUNC + RIGHT rotated every trig and lock one step right and FUNC + LEFT restored the exact record; FUNC + NO restored the record before the last change and a second FUNC + NO restored the one after it (full 2,330-byte record compared); EVO YES changed the phrase in 5 of 6 presses (LOW, AMNT 25; the sixth touched only rests); KEY E (INV) mirrored the PTCH locks; SCAL +3 regenerated.
- **Close.** NO closes SEQGEN on its release and pops only SEQGEN's layer: the list is back to root + menu, the CONTROL list redraws with SEQGEN selected.
- **FUNC combinations.** The key cache takes a held-layer pointer from a lower layer when SEQGEN's FUNC record has none, so the stock FUNC layer first took FUNC + RIGHT. SEQGEN's FUNC record now names its own FUNC layer; FUNC + LEFT/RIGHT/NO reach SEQGEN, and after FUNC is released the layer list is back to root + menu + SEQGEN.
- **Track and MIDI.** Pressing T2 while open retitles the window to T2. In MIDI mode the row shows the stock toast and pushes no layer.
- **Playback.** With the transport running, the stock trigger routine `0x4000f450` fired 48-49 times in 8 s at 120 BPM for a 12-trig, 16-step phrase (four loops).
- **AUTO = 1 follows the instrument's timing.** 120 BPM, 8 s: 4 evolves. Tempo turned to 60 BPM in the stock TEMPO window while playing (tempo word `0x80001814` 2880 to 1440), 16 s: 4 evolves and 48 trigger hits. Pattern scale byte (`+0x8e54`) written while playing (a RAM write, not a panel edit): 2X, 8 s: 8 evolves and 96 hits; 1/2X: 2 evolves and 24 hits. Stopped: no evolves in 4 s.

Not measured: audio output (no DSP in these runs), per-track scale mode, a pattern change at the loop point, PROJECT > CHANGE or SAVE while SEQGEN is open, and the MIDI-track case beyond the toast.

## Encodings (OS 1.40C, emulator and disassembly, 9 October 2026)

Read on the author's computer from the author's own 1.40C image (MAIN OS SHA-256 prefix `164f3122`), with `ot_emu` in MKI mode on a blank scratch card. No firmware, listing or dump is committed. No hardware was used.

- Trig word at record `+0x89a + 2·step`, big-endian. EMU readbacks of stock panel edits: new trig `0x0000`, micro +1 `0x0080`, FILL `0x0081`, 1% `0x0089`, micro −3 `0x1e80`, −23 `0x1480`, +23 `0x0b80`; condition codes 19, 30 and 64 read back as expected. READ: the condition tester takes `word & 0x7f`; micro-timing is signed bits 7..12 in 1/384 note. Codes: 0 none, 1–8 FILL/!FILL/PRE/!PRE/NEI/!NEI/1ST/!1ST, 9–29 the X% list (50 % = 19, 87 % = 24), A:B = 28 + B(B−1)/2 + A. Bits 13..15 never appeared and are preserved. `test_engine.c` asserts these readbacks.
- RTRG lock byte n is displayed as n+1 (EMU and READ); RTIM 79/72/67 display 1/2, 1/3 and 1/4 step. SEQGEN writes RTRG 1–3 with those RTIM values for 2–4 hits. **Not confirmed:** that the unit plays that many audible hits; this needs a hardware or audio-capture check.

## Stock flows

Compared under the emulator, stock image against SEQGEN image, MKI and MKII: PROJECT > CONTROL's six stock pages, NO out of CONTROL and out of the PROJECT menu (see the walk above). The one change is the added SEQGEN row (README, Compatibility and limitations). Not tested: every other PROJECT, SYSTEM and MIDI page, and save/load while SEQGEN is open.

## Performance

Not run. `evidence/performance.json` (ColdFire template, `cfmeter.py`) is still to do. SEQGEN does its work on the UI task: per UI tick it reads eight step counters and, at most once per tick and only with AUTO on, commits one track (copy, generate or evolve, write, compare 2,330 bytes, stock lock-index rebuild). Its cost has not been measured.

## Resources

DRAM unit, from `m68k-elf-size` of `control.s`: 19,735 bytes of code and 6,100 bytes of data (two 2,330-byte record buffers, the phrase and eight settings sets). Placed by the build in the platform DRAM reserve. One UI-tick detour, one symbol ref, one 4-byte poke. Measured cost per tick: not yet.

## Hardware

Untested. Hardware results are recorded only as reported by the tester.

## OT UI capture evidence

`media/capture.json`: five emulator LCD captures from `scripts/capture-module-ui.py --mki` on the image above, with the panel plan, input hashes and screenshot hashes. Reviewed by eye.

## module:verify

Not run. `npm run module:verify` needs SEQGEN in `sdk/catalog.json`, and `npm run modules:generate` refuses the listing until `tests.qualification` carries worst-case cycles, exact memory and hardware evidence.
