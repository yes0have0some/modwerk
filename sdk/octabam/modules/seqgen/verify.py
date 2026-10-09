#!/usr/bin/env python3
"""SEQGEN firmware-free engine gate; run in the isolated toolchain.

Covers the generator, EVO, scale, transform, settings-packing and native
track-record writer under ASan/UBSan. It reads no firmware and proves no
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
print('SEQGEN firmware-free engine and record writer passed; native glue and hardware are separate gates.')
