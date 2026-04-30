# zmk-config — Bluetooth Ferris Sweep

ZMK firmware config for a Bluetooth Ferris Sweep (34-key low-profile split,
nRF52840 Pro Micro clone running `nice_nano_v2` board target with the `cradio`
shield).

## Build & flash

Every push to `main` triggers GitHub Actions, which builds three `.uf2`
firmwares and uploads them as a single `firmware` artifact:

| File | What it's for |
|---|---|
| `cradio_left-nice_nano_v2-zmk.uf2` | Left half (the central; this one talks to the host) |
| `cradio_right-nice_nano_v2-zmk.uf2` | Right half (peripheral; talks to the left half) |
| `settings_reset-nice_nano_v2-zmk.uf2` | One-shot firmware that wipes all stored Bluetooth bonds. Flash it, let it run once, then reflash the real firmware. Only needed when BT pairing gets really wedged. |

To flash a half:

1. Power switch ON.
2. Plug the daughterboard into your computer via USB-C.
3. Double-tap the reset button on the daughterboard. A USB drive named
   `NICENANO` mounts.
4. Drag the matching `.uf2` onto the drive. The drive disappears, the board
   reboots running the new firmware.

The left half also enables ZMK Studio over USB — plug it in and open
<https://zmk.studio/> in Chrome/Edge to edit the keymap live without
rebuilding.

## The keymap — eight-layer Dvorak monstrosity

Base layer is Dvorak. Home-row mods on the outer pinkies (`A`/`S` = Shift),
layer-tap on home-row index/middle and on three of the four thumbs. There
are eight layers because past-me decided that was a good idea, and present-me
hasn't been able to argue convincingly otherwise.

For the pretty version see [`keymap.pdf`](keymap.pdf) (built from
[`keymap.typ`](keymap.typ) with `typst compile keymap.typ`). Quick text
summary of the base layer:

```
 '    ,    .    P    Y          F    G    C    R    L
 A⇧   O🅵   E🅼   U🆂   I          D    H🆂   T🅽   N🅽   S⇧
 ;    Q⌃   J⌥   K    X          B    M    W*   V*   Z
                ⌃    Spc        Spc🅼  ⌫⌘
```

Subscripts mark layer-taps:
- 🅵 = L5 (F-keys)
- 🅼 = L1 (mouse) on `E`, L7 (misc) on right thumb
- 🆂 = L3 (sym1) on `U`, L4 (sym2) on `H`
- 🅽 = L2 (nav) on `T`, L6 (numpad) on `N`

`*` on `W`/`V` = both left+right Alt / both left+right Ctrl held.

Layers, in order:

| # | Name | Reached via | What it has |
|---|---|---|---|
| 0 | Default | — | Dvorak base |
| 1 | Mouse | hold `E` | Mouse buttons, movement, scroll wheel |
| 2 | Navigation | hold `T` | Arrows, PgUp/Dn, Home/End, modifier combos |
| 3 | Symbols 1 | hold `U` | `^*&` `#~/"$` `-\`` and friends |
| 4 | Symbols 2 | hold `H` | `:<>;` `{}()@` `![]` `=+%`, volume on thumbs |
| 5 | F-keys | hold `O` | F1–F12 across the right hand |
| 6 | Numpad | hold `N` | Digits + arithmetic on the left hand |
| 7 | Misc / System | hold right inner thumb | BT pairing, layer locks, bootloader |

## Bluetooth pairing

Five profile slots, four of them bound to keys on layer 7.

- **Pair a new host:** hold right inner thumb (enters layer 7), tap `BT 0`
  (or `BT 1`/`BT 2`/`BT 3`). The keyboard advertises for ~60s — pair from
  the host's Bluetooth settings.
- **Switch hosts:** same — tap `BT N` for an already-paired slot to
  reconnect.
- **Re-pair an in-use slot:** tap `BT N` to make it active, tap `BTclr` to
  drop the old bond, tap `BT N` again to advertise fresh, pair from the
  new host.
- **Nuclear reset:** flash `settings_reset.uf2` to both halves, then reflash
  the normal firmware.

Inter-half pairing happens automatically the first time both halves boot on
fresh firmware in range of each other. No human action needed for that.

## Hold-tap tuning for home-row mods

Home-row mods use ["timeless" configuration](https://zmk.dev/docs/keymaps/behaviors/hold-tap#home-row-mods) to minimize chording issues when typing quickly:

| Property | Value | Purpose |
|---|---|---|
| `flavor` | `balanced` | Hold only if another key is pressed AND released within tapping term |
| `require-prior-idle-ms` | 125ms | Immediately tap when typing fast — the key to avoiding swallowed keys |
| `tapping-term-ms` | 280ms | Generous window for intentional holds |
| `quick-tap-ms` | 175ms | Rapid re-taps always register as taps |

See [ZMK hold-tap docs](https://zmk.dev/docs/keymaps/behaviors/hold-tap) for full details.

## Files

- `config/cradio.keymap` — keymap source
- `config/cradio.conf` — enables ZMK pointing (mouse layer) and ZMK Studio
- `build.yaml` — Actions build matrix
- `keymap.typ` / `keymap.pdf` — printable reference sheet
- `ferris_sweep.layout.json` — original Vial layout (source of the
  translation)
