// Ferris Sweep ZMK keymap reference sheet.
// Compile with: `typst compile keymap.typ`

#set page(paper: "us-letter", margin: (x: 0.4in, y: 0.5in))
#set text(font: ("Helvetica", "Arial", "Liberation Sans"), size: 10pt)
#show heading.where(level: 1): set text(size: 16pt)
#show heading.where(level: 2): set text(size: 12pt)
#show heading.where(level: 2): set block(below: 0.4em, above: 0.2em)

#let cellsz = 1.05cm
#let gap = 1pt

// Transparent (passes through to layer below)
#let tr = box(width: cellsz, height: cellsz, fill: rgb("#f0f0f0"), stroke: 0.3pt + rgb("#bbb"))

// None / no-op
#let nn = box(
  width: cellsz, height: cellsz,
  fill: rgb("#fafafa"), stroke: 0.3pt + rgb("#ddd"),
  align(center + horizon, text(size: 6pt, fill: rgb("#aaa"))[—])
)

// Normal key. `hold` adds a small grey label below the tap label.
#let k(tap, hold: none, fill: white) = box(
  width: cellsz, height: cellsz, fill: fill, stroke: 0.4pt,
  inset: 1.2pt,
  if hold != none {
    align(center + horizon)[
      #text(size: 7.5pt, weight: "bold")[#tap]
      #v(-4pt)
      #text(size: 5.5pt, fill: rgb("#777"))[#hold]
    ]
  } else {
    align(center + horizon, text(size: 7.5pt, weight: "bold")[#tap])
  }
)

// Render one layer: 30 alpha keys (3 rows × 10) plus 4 thumb keys.
#let layer(name, desc, keys) = [
  == #name
  #if desc != "" [
    #set text(size: 9pt, style: "italic", fill: rgb("#555"))
    #desc
  ]
  #v(2pt)
  #grid(
    columns: (cellsz,) * 5 + (0.5cm,) + (cellsz,) * 5,
    column-gutter: gap,
    row-gutter: gap,
    ..keys.slice(0, 5), [], ..keys.slice(5, 10),
    ..keys.slice(10, 15), [], ..keys.slice(15, 20),
    ..keys.slice(20, 25), [], ..keys.slice(25, 30),
    [], [], [], ..keys.slice(30, 32), [], ..keys.slice(32, 34), [], [], [],
  )
  #v(0.45cm)
]

= Ferris Sweep — ZMK Keymap

#set text(size: 9pt)
Dvorak base, with home-row mods on `A`/`S` and four layer-tap thumbs.
In each cell the *bold* label is what you get on tap; the small grey
label is what's held. Pale-grey cells are transparent (fall through
to a lower layer); cells marked "—" are no-ops.

#set text(size: 10pt)
#v(0.3cm)

#layer(
  "Layer 0 — Default (Dvorak)",
  "Base typing layer. Holding any home-row alpha gives a modifier or layer.",
  (
    k("'"), k(","), k("."), k("P"), k("Y"),
    k("F"), k("G"), k("C"), k("R"), k("L"),
    k("A", hold: "Shift"), k("O", hold: "L5 Fn"), k("E", hold: "L1 Mse"), k("U", hold: "L3 Sy1"), k("I"),
    k("D"), k("H", hold: "L4 Sy2"), k("T", hold: "L2 Nav"), k("N", hold: "L6 Num"), k("S", hold: "Shift"),
    k(";"), k("Q", hold: "Ctrl"), k("J", hold: "Alt"), k("K"), k("X"),
    k("B"), k("M"), k("W", hold: "L+RAlt"), k("V", hold: "L+RCtrl"), k("Z"),
    k("RCtrl"), k("Space"), k("Space", hold: "L7 Misc"), k("Bksp", hold: "Gui"),
  )
)

#layer(
  "Layer 1 — Mouse",
  "Pointing and scroll wheel. Held via E on home row.",
  (
    tr, tr, tr, tr, tr,
    tr, k("LClk"), k("Wh ↑"), k("RClk"), tr,
    tr, k("RClk"), nn, k("LClk"), tr,
    tr, k("←"), k("↓"), k("↑"), k("→"),
    tr, tr, tr, tr, tr,
    tr, k("Wh ←"), k("Wh ↓"), k("Wh →"), tr,
    tr, tr, tr, tr,
  )
)

#pagebreak()

#layer(
  "Layer 2 — Navigation",
  "Arrow cluster + page/home/end. Held via T on home row.",
  (
    tr, tr, k("PgUp"), tr, tr,
    tr, tr, tr, tr, tr,
    k("←"), k("↑"), k("↓"), k("→"), tr,
    tr, k("Gui"), nn, k("Alt", hold: "Ctrl"), k("⌃⌥⇧"),
    tr, k("Home"), k("PgDn"), k("End"), tr,
    tr, tr, tr, tr, tr,
    tr, tr, tr, tr,
  )
)

#layer(
  "Layer 3 — Symbols 1",
  "Math/text symbols. Held via U on home row.",
  (
    tr, tr, k("?"), tr, tr,
    tr, k("_"), k("|"), k("'"), tr,
    k("^"), k("*"), k("&"), nn, tr,
    k("#"), k("~"), k("/"), k("\""), k("$"),
    tr, tr, tr, tr, tr,
    tr, k("-"), k("\\"), k("`"), tr,
    tr, tr, tr, tr,
  )
)

#pagebreak()

#layer(
  "Layer 4 — Symbols 2",
  "Brackets, parens, comparison. Volume on thumbs. Held via H on home row.",
  (
    tr, k(":"), k("<"), k(">"), k(";"),
    tr, tr, k("?"), tr, tr,
    k("{"), k("}"), k("("), k(")"), k("@"),
    tr, nn, k("="), k("+"), k("%"),
    tr, k("!"), k("["), k("]"), tr,
    tr, tr, tr, tr, tr,
    k("Vol−"), tr, tr, k("Vol+"),
  )
)

#layer(
  "Layer 5 — Function Keys",
  "F1–F12 across the right hand. Held via O on home row.",
  (
    tr, tr, tr, tr, tr,
    tr, k("F7"), k("F8"), k("F9"), k("F10"),
    tr, nn, k("Ctrl+Alt"), tr, tr,
    tr, k("F4"), k("F5"), k("F6"), k("F11"),
    tr, tr, tr, tr, tr,
    tr, k("F1"), k("F2"), k("F3"), k("F12"),
    tr, tr, tr, tr,
  )
)

#pagebreak()

#layer(
  "Layer 6 — Numpad",
  "Numeric pad with digits and arithmetic on the left hand. Held via N on home row.",
  (
    k("/"), k("7"), k("8"), k("9"), k("+"),
    tr, tr, tr, tr, tr,
    k("0"), k("1"), k("2"), k("3"), k("−"),
    tr, tr, tr, nn, tr,
    k("*"), k("4"), k("5"), k("6"), k("="),
    tr, tr, tr, tr, tr,
    tr, tr, tr, tr,
  )
)

#layer(
  "Layer 7 — Misc / System",
  "Bluetooth pairing, layer switching, system reset. Held via right inner thumb.",
  (
    tr, tr, k(":"), k("Esc"), tr,
    k("BT 0", fill: rgb("#dde9ff")), k("BT 1", fill: rgb("#dde9ff")),
    k("BT 2", fill: rgb("#dde9ff")), k("BT 3", fill: rgb("#dde9ff")), k("Del"),
    tr, k("%"), k("/"), k("Ent"), tr,
    k("→Mse", fill: rgb("#fff5dd")), k("Gui"),
    k("BTclr", fill: rgb("#dde9ff")), tr, tr,
    tr, tr, tr, k("!"), tr,
    k("→Def", fill: rgb("#fff5dd")), tr,
    k(",", hold: "L+RAlt"), k(".", hold: "L+RCtrl"),
    k("Boot", fill: rgb("#ffdddd")),
    tr, k("Tab"), nn, tr,
  )
)

#v(0.4cm)
#set text(size: 8.5pt, fill: rgb("#444"))
*Bluetooth pairing:* hold right-inner-thumb (the L7 key) and tap *BT 0–3*
to switch profiles or pair a new host. *BTclr* clears the active profile.
*→Def* / *→Mse* lock the base or mouse layer; *Boot* enters the bootloader
(double-tap reset is easier).
