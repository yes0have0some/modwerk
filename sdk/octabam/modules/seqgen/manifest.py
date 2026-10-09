"""SEQGEN -- generate, evolve and scale-lock a phrase on the current audio
track, opened from PROJECT > CONTROL > SEQGEN. Writes real trigs and locks
into the current pattern; the stock sequencer plays them. No clock of its own.

One DRAM unit (control.s, compiled from engine.c + native.c by prepare.py,
plus hooks.s). What it changes in the stock firmware:

  0x400cbd54  CONTROL list row count 6 -> 7 (poke)
  0x400cbd6c  CONTROL rows pointer -> seqgen_control_rows (symbol ref): the six
              stock nodes copied from the user's own OS (StockCopy of
              0x400cc5a8, 144 bytes) plus the SEQGEN node, page id 0, so the
              stock menu calls seqgen_open on YES (READ 0x40065010..0x4006505c)
  0x40052232  the UI tick's `jsr 0x4003fed8` -> seqgen_tick_hook (detour):
              redraw on track change and AUTO evolve on loop wraps

The page is a stock window (0x4005829c, priority 2 over the menu's 1) with
SEQGEN's own input layer (push 0x40031494 / pop 0x4003146c). Settings are
runtime RAM only, defaults at boot. Measured under the ColdFire port; not yet
on hardware (TESTING.md).
"""
from remix.schema import Category, Detour, Gate, Kind, Linked, Module, Poke, Proof, StockCopy, SymbolRef
from remix.stock_guard import stock_guard

MODULE = Module(
    name="seqgen",
    key="SEQGEN",
    kind=Kind.CF_PATCH,
    doc="Generate, evolve and scale-lock audio-track phrases as real trigs and locks.",
    category=Category.MACHINES, author="yes0have0some", author_url="https://github.com/yes0have0some",
    proof=Proof.PORT, proof_note="Emulator (ColdFire port) walk recorded in TESTING.md; hardware untested.",
    linked=(Linked("seqgen", "modules/seqgen/control.s", cpu="5475", dram=True, stock_copies=(
        StockCopy("seqgen_control_rows", stock_guard(0x400cc5a8, 144, "57635ae6276786cdb31617d61e34b92c461da742b0452222ebca4fc03b7394e4")),
    )),),
    symbol_refs=(
        SymbolRef(0x400cbd6c, 0x400cc5a8, "seqgen", "seqgen_control_rows",
                  note="PROJECT > CONTROL rows: the six stock rows, then SEQGEN"),
    ),
    detours=(
        Detour(0x40052232, stock_guard(0x40052232, 6, "c3fac011822a446d035f0a884bf61c92652e2ff30dceccbaada98aa09726f156"),
               "seqgen", "seqgen_tick_hook", "UI tick: SEQGEN redraw and AUTO evolve (replays jsr 0x4003fed8)"),
    ),
    pokes=(
        Poke(0x400cbd54, stock_guard(0x400cbd54, 4, "b253668f6b59f1ff28522831931e4d3c5a3de533965af22e961735437c0172cb"),
             bytes.fromhex("00000007"), "PROJECT > CONTROL: 6 -> 7 rows (+ SEQGEN)"),
    ),
    gates=(Gate("modules/seqgen/verify.py", remix_arg=False),),
)
