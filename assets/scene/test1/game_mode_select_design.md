# Game mode selection — design notes (`test1`)

Opened from **Main menu → New Game**. English UI strings live in the scene; this file is the **structure contract** and extension guide.

## Files

| File | Role |
|------|------|
| `game_mode_select.tscn` | Layout: header, mode list, details strip, footer, overlay host |
| `game_mode_select.gd` | Navigation (Back → main menu), mode button stubs |
| `game_mode_select_design.md` | This document |

## Flow

```
main_menu.tscn  --[New Game]-->  game_mode_select.tscn  --[Back]-->  main_menu.tscn
game_mode_select.tscn  --[Campaign]-->  hex_field_stage.tscn  --[ui_cancel / Esc]-->  game_mode_select.tscn
```

`main_menu.gd` calls `get_tree().change_scene_to_file()` to load this scene. **Campaign** loads the hex field stage (`res://assets/scene/test1/hex_field_stage.tscn`); see `hex_field_design.md`. Skirmish / tutorial still use stubs until their flows exist.

## Scene graph (logical)

```
GameModeSelect (Control) + game_mode_select.gd
├── Layer_Background       # Full-screen ColorRect (slightly different tint from main menu)
├── SafeArea
│   └── MainColumn (VBoxContainer)
│       ├── Header         # Title + subtitle
│       ├── TopSpacer      # Expands
│       ├── ScreenHost     # %ScreenHost — **replace center** (e.g. skirmish options wizard)
│       ├── ModeBlock
│       │   ├── PrimaryModeList   # %PrimaryModeList — **add mode buttons here**
│       │   │   ├── BtnModeCampaign
│       │   │   ├── BtnModeSkirmish
│       │   │   └── BtnModeTutorial
│       │   └── ModeDetails       # %ModeDetails — short copy; swap for RichTextLabel later
│       ├── MidSpacer      # Expands
│       ├── Footer         # %BtnBack + spacer only (HBox)
│       └── FooterHint     # full-width hint below footer (not inside HBox — avoids layout bugs)
└── Layer_Overlay (CanvasLayer, layer 10)
    └── ModalHost          # %ModalHost — confirm dialogs, locks, DLC gates
```

## Naming & hooks

| Unique name | Purpose |
|-------------|---------|
| `%PrimaryModeList` | Parent of all primary mode `Button`s; keep ordering = display order |
| `%ScreenHost` | Full-area UI that **replaces** the default mode block flow (hide `ModeBlock` when pushing a wizard) |
| `%ModalHost` | Popups above everything; set `mouse_filter` to **Stop** while a modal is open |
| `%ModeDetails` | One-line / short description; script can set `text` on focus or selection |
| `%BtnBack` | Always returns to `main_menu.tscn` (adjust path constant if menu moves) |

**Group:** `mode_select_screen_host` on `ScreenHost` — optional discovery for tools/tests (same idea as `menu_screen_host` on the main menu).

## Extension patterns

### Add a new mode (simple)

1. Add a `Button` under **`%PrimaryModeList`** (below existing buttons or grouped with separators).
2. Enable **`unique_name_in_owner`** (e.g. `BtnModeArena`).
3. In `game_mode_select.gd`, connect `pressed` in `_ready()` and implement `_on_mode_arena_pressed()` (or a single router with `match` on `button.name` if you prefer).

### Drive modes from data (scalable)

1. Define a small `Resource` or dictionary list: `id`, `title`, `description`, `scene_path`, `locked`.
2. In `_ready()`, clear `PrimaryModeList` children (or a dedicated `ModesContainer`), instanciate a **packed scene** `mode_row.tscn` per entry, or spawn `Button`s from code.
3. Bind `pressed` with Callable that carries the mode id. Keeps the scene tree thin when you have many modes.

### Skirmish / multi-step setup

1. Hide **`ModeBlock`** (or only `PrimaryModeList`) when entering setup.
2. Instantiate the skirmish UI as a child of **`%ScreenHost`**, full rect anchors.
3. On cancel/finish: `queue_free` the child, show `ModeBlock` again.

### Locked modes (tutorial completed, DLC)

- Grey out buttons with `disabled = true` or show a **modal** under `%ModalHost` explaining the lock.
- Avoid scattering `if` checks across unrelated nodes; prefer one small `ModeAvailability` helper or autoload later.

## Copy (English, in-scene)

- Title: `Game mode`
- Subtitle: `Choose how you want to start a new game`
- Buttons: Campaign, Skirmish, Tutorial
- Details placeholder: see `ModeDetails` default text
- Footer: `Back` row + `FooterHint` (full width, autowrap) — keep long hints **out** of `HBoxContainer` to avoid broken layouts.

## Related

- `menu_screen_design.md` — main menu layers and the same `ScreenHost` / `ModalHost` philosophy
