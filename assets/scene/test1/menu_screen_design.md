# Main menu screen — design notes (`test1`)

English UI copy lives in the scene; this document describes **node ownership**, **layers**, and **how to extend** without flattening the tree.

## Files in this folder

| File | Role |
|------|------|
| `main_menu.tscn` | Root menu layout, layers, buttons, placeholders |
| `main_menu.gd` | Signal wiring; **New Game** → `game_mode_select.tscn` |
| `menu_screen_design.md` | This blueprint |
| `game_mode_select.tscn` | New-game flow: pick game mode |
| `game_mode_select.gd` | Mode stubs; **Back** → `main_menu.tscn` |
| `game_mode_select_design.md` | Game mode screen blueprint |
| `hex_field_stage.tscn` | Campaign hex board: `World` + `HexGrid` + `MapCursor` + dead-zone `Camera2D` |
| `hex_field_design.md` | Hex grid / cursor / smooth camera blueprint |
| `srpg_hex_cursor_guide.md` | 非エンジニア向けの挙動説明（索引） |
| `../../script/test1/hex_field_stage.gd` | Root: hint + Esc |
| `../../script/test1/hex_grid.gd` | `HexFieldGrid` |
| `../../script/test1/srpg_map_cursor.gd` | Discrete cursor |
| `../../script/test1/srpg_camera_dead_zone.gd` | Dead-zone smooth camera |
| `smoke_test.tscn` | Minimal sanity-check scene (optional) |

## Navigation

- **New Game** → `game_mode_select.tscn` (`change_scene_to_file`). See `game_mode_select_design.md`.

## Goals

- **Readable hierarchy** — background, content, overlay are clearly separated.
- **Stable hooks** — scripts and future sub-scenes target `%UniqueName` nodes, not deep paths.
- **Room to grow** — full-screen swaps and modal dialogs have dedicated hosts.

## Scene graph (logical)

```
MainMenu (Control) + main_menu.gd
├── Layer_Background          # ColorRect — full viewport; swap for TextureRect / shader later
├── SafeArea                  # MarginContainer — consistent insets; tune per platform
│   └── MainColumn (VBoxContainer)
│       ├── Header            # Title + subtitle; add logo row as sibling inside Header if needed
│       ├── TopSpacer         # Expands — pushes block toward vertical balance
│       ├── ScreenHost        # %ScreenHost — **full-panel replacements** (e.g. settings page)
│       ├── PrimaryMenu       # %PrimaryMenu — **default vertical button list**
│       │   ├── BtnNewGame
│       │   ├── BtnContinue
│       │   ├── BtnSettings
│       │   └── BtnQuit
│       ├── MidSpacer         # Expands
│       └── Footer            # Version, links; add HSeparator above if desired
└── Layer_Overlay (CanvasLayer, layer 10)
    └── ModalHost             # %ModalHost — **dialogs, dimmer, popups**
```

## Layer rules

1. **`Layer_Background`** — Visual only; no interaction. Keep cheap (ColorRect) until art exists.
2. **`SafeArea` / `MainColumn`** — All in-world menu layout stays here unless it must sit above everything.
3. **`Layer_Overlay`** — Anything that must draw above the menu (modal, tooltip shell, blocking dimmer). Use `ModalHost` as the single parent for modal roots so show/hide and input routing stay predictable.

## Extension patterns

### A. Add a menu button

1. Instance or duplicate a `Button` under **`PrimaryMenu`** (order = display order).
2. In `main_menu.gd`, connect `pressed` in `_ready()` (or use a small child script on the button for self-contained features).
3. Prefer **`unique_name_in_owner`** on nodes that scripts address from the root.

### B. Replace the whole center with another panel (e.g. Settings)

1. Hide **`PrimaryMenu`** (and optionally Header/Footer) when entering sub-screen.
2. Instantiate your panel scene as a child of **`%ScreenHost`**, set `anchors_preset` full rect, `visible = true`.
3. On back: queue_free the panel, show **`PrimaryMenu`** again.

Alternatively, use `push` / stack logic in a dedicated `MenuNavigator` autoload later; **`ScreenHost`** remains the single mount point.

### C. Modal dialog (confirm quit, audio, etc.)

1. Parent dialog root under **`%ModalHost`**, set `ModalHost.mouse_filter` to **Stop** while open, back to **Ignore** when empty.
2. Add a full-rect `ColorRect` (semi-transparent) behind dialog content inside the dialog scene for dimming.

### D. Continue button state

In `main_menu.gd` (or a future `SaveService`), enable/disable **`BtnContinue`** based on save presence — no tree restructure required.

## Groups

- **`menu_screen_host`** on `ScreenHost` — optional discovery (`get_tree().get_nodes_in_group("menu_screen_host")`) if tools or tests need a stable anchor.

## Main scene entry

Project run scene should point at `res://assets/scene/test1/main_menu.tscn` when this menu is the default entry.

## Copy (English, in-scene)

- Title: `SPRG`
- Subtitle: `Strategic / tactical RPG — main menu`
- Buttons: New Game, Continue, Settings, Quit
- Footer: `v0.1 — demo` (replace from build or `ProjectSettings`)
