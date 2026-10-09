| SEQGEN hooks, data and the PROJECT > CONTROL row. GNU as, ColdFire.
| Copyright (c) 2026 yes0have0some. MIT. Original.
        .text
        .global seqgen_tick_hook
| 0x40052232, the UI tick's `jsr 0x4003fed8` (six bytes, replayed here),
| one call after the sites other modules use; returns to 0x40052238.
seqgen_tick_hook:
        jsr     0x4003fed8
        jsr     seqgen_tick
        jmp     0x40052238

        .data
        .balign 4
| The CONTROL rows: the six stock 24-byte nodes are copied here at build time
| from the user's own OS (StockCopy; zeros in source), then the SEQGEN node
| {label, window, action, 0, children, page id}. Page id 0 makes the stock
| menu call the action on YES instead of opening a settings page.
        .global seqgen_control_rows
seqgen_control_rows:
        .space  144
        .long   seqgen_label, 0, seqgen_open, 0, 0, 0
seqgen_label:
        .asciz  "SEQGEN"
        .balign 4
| Our input layer: {link, keys, encoders, 0, 0, -1, -1}. Each key record is
| {code, 0, press, release, repeat, held layer, 0, 0, 0}. The key cache takes
| a held-layer pointer from a lower layer when ours is zero (measured under
| the port: FUNC pushed the stock FUNC layer over this one), so FUNC names
| seqgen_func_layer, which the stock dispatcher pushes while FUNC is held and
| pops on release. It shares the key table; encoders fall through to ours.
        .global seqgen_layer
seqgen_layer:
        .long   0, seqgen_keys, seqgen_encs, 0, 0, -1, -1
seqgen_func_layer:
        .long   0, seqgen_keys, 0, 0, 0, -1, -1
seqgen_keys:
        .irp    k, 0x31, 0x32, 0x34, 0x21, 0x33, 0x20
        .byte   \k, 0
        .long   seqgen_key, seqgen_key, seqgen_key, 0, 0
        .word   0, 0
        .endr
        .byte   0x2d, 0
        .long   seqgen_key, seqgen_key, seqgen_key, seqgen_func_layer, 0
        .word   0, 0
        .byte   0xff, 0
        .long   0, 0, 0, 0, 0
        .word   0, 0
seqgen_encs:
        .irp    k, 0, 1, 2, 3, 4, 5, 6
        .byte   \k, 0
        .long   seqgen_knob, 0, 0, 0, 0
        .endr
        .byte   0xff, 0
        .long   0, 0, 0, 0, 0
