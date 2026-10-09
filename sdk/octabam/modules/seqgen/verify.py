#!/usr/bin/env python3
"""SEQGEN firmware-free engine gate; run in the isolated toolchain.

Covers the generator, EVO, scale, transform, settings-packing and native
track-record writer under ASan/UBSan, and that control.s is exactly what
prepare.py compiles from engine.c, native.c and hooks.s (needs m68k-elf-gcc). It reads no firmware and proves no
emulator, timing or hardware behaviour; those are separate TESTING.md records.
"""
from pathlib import Path
import subprocess
import tempfile

here = Path(__file__).resolve().parent
flags = ['-std=c11', '-Wall', '-Wextra', '-Werror', '-fsanitize=address,undefined']
with tempfile.TemporaryDirectory(prefix='seqgen-gate.') as directory:
    binary = Path(directory) / 'engine'
    subprocess.run(['cc', *flags, str(here / 'engine.c'), str(here / 'test_engine.c'), '-o', str(binary)], check=True)
    subprocess.run([str(binary)], check=True)
    subprocess.run(['python3', '-B', str(here / 'prepare.py'), '--output', str(Path(directory) / 'control.s')], check=True)
    if (Path(directory) / 'control.s').read_bytes() != (here / 'control.s').read_bytes():
        raise SystemExit('SEQGEN control.s differs from the current engine.c/native.c/hooks.s and pinned compiler')
print('SEQGEN firmware-free engine, record writer and assembly reproducibility passed; emulator and hardware are separate records.')
