# Hex field stage — design notes (`test1`)

Default **tactical board**: many hex cells in a rectangle, drawn in one pass for the prototype. English UI elsewhere; this doc is the **layout / math / extension** contract.

All **menu → mode → hex field** flow assets for this slice live under **`assets/scene/test1`** with scripts in **`assets/script/test1`**.

## Files

| File | Role |
|------|------|
| `hex_field_stage.tscn` | `HexFieldStage` → `World` → `HexGrid` + `MapCursor` + `Camera2D` |
| `../../script/test1/hex_field_stage.gd` | UI hint + **Esc** → `game_mode_select.tscn` only (no cursor/camera logic) |
| `../../script/test1/hex_grid.gd` | `HexFieldGrid` — draw grid, bounds, axial step, pick helper |
| `../../script/test1/srpg_map_cursor.gd` | **Cursor**: discrete cell moves (arrows); **does not** drive camera |
| `../../script/test1/srpg_camera_dead_zone.gd` | **Camera**: dead-zone margin + **smooth lerp** toward target; clamped to map |
| `hex_field_design.md` | This document |

## Entry flow

- **Game mode → Campaign** loads `res://assets/scene/test1/hex_field_stage.tscn` (see `game_mode_select.gd`).
- From the field, **Escape** returns to the game mode screen.

## Camera & cursor (FE-like)

- **Cursor (`MapCursor`)**: arrow keys move **one hex per press** (axial 4-way via `step_cell_axial`). Position = `HexFieldGrid.offset_to_pixel(cell)`. Optional `Sprite2D` child; ring drawn in `_draw`.
- **Camera (`srpg_camera_dead_zone.gd`)**: **not** snapped to cursor each step. A **margin** (pixels → world) defines an inner box around the view center; when the cursor leaves that box, the camera **target** shifts so the cursor stays inside; `position` **lerps** toward target each physics frame (`1 - exp(-smoothing * delta)`). Then **clamped** to `get_field_bounds()` so the map edge behaves correctly.
- **Zoom**: `Camera2D.zoom_vs_fit_all` × `HexFieldGrid.get_recommended_zoom` (default **0.38** in scene).
- **Separation**: cursor logic and camera logic are **independent scripts**; future units/pathfinding hook `MapCursor.cell_changed` or shared `Vector2i` cell state.

## Coordinate system

- **Layout**: **odd-q vertical** offset coordinates `(col, row)` with **pointy-top** hexes (vertex at top).
- **Conversion** `offset_to_pixel` follows [Red Blob Games — hex grids](https://www.redblobgames.com/grids/hexagons/) (odd-q ↔ axial, then axial → pixel with `size = hex_outer_radius` as center-to-vertex distance).
- **Stagger**: even/odd columns use the standard odd-q vertical stagger so the map is a **filled rectangle** in screen space.

## Scene graph

```
HexFieldStage (Node2D) + hex_field_stage.gd   # hint + Esc only
└── World (Node2D)                             # shared map space
    ├── HexGrid (Node2D) + hex_grid.gd        # class_name HexFieldGrid
    ├── MapCursor (Node2D) + srpg_map_cursor.gd
    │   └── Sprite2D (optional icon)
    └── Camera2D + srpg_camera_dead_zone.gd
```

- **HUD**: `CanvasLayer` on `HexFieldStage` (code-spawned hint). Do not parent UI under `World` if you need screen-space anchoring without moving with the map.
- **Extra pawns / units**: add under `World` (or `World/Units`) and snap with `HexGrid.offset_to_pixel`; keep **cursor** as the selection affordance unless you split selection vs unit display.

## `HexFieldGrid` responsibilities

| Piece | Purpose |
|-------|---------|
| Exports `grid_columns`, `grid_rows`, `hex_outer_radius` | Board size; tweak in inspector or from a future `StageDefinition` resource |
| `_draw()` | Fills + outlines for every cell; cheap for hundreds of tiles |
| `pick_cell(local_point)` | **Hit test** for UI / cursor (polygon test after nearest-center pre-pass) |
| `get_field_bounds()` / `get_field_center()` / `get_recommended_zoom()` | Camera clamp and zoom |
| `offset_to_axial` / `axial_to_offset` / `step_cell_axial` / `is_cell_in_bounds` | SRPG steps and bounds |

## Extension patterns

### Terrain / ownership per cell

1. Add `PackedInt32Array` or `Dictionary` keyed by `Vector2i(col, row)` on `HexFieldGrid` or a sibling **`HexCellData`** autoload.
2. In `_draw()`, choose `fill_color_*` (or draw an icon layer) from that data.
3. Long-term: migrate to **TileMapLayer** (hex tileset) if you need autotiling and editor painting; keep the same odd-q addressing doc in sync.

### Units and pathfinding

- Use **`MapCursor.get_cell()`** (or `cell_changed`) as the **selection** cell; place units with the same `(col, row)` convention.
- For movement range / pathfinding, reuse **`step_cell_axial`** or build BFS in axial/cube space, then convert with `axial_to_offset`.

### Larger maps / scrolling

- Increase `grid_*` exports or load from resource.
- Camera already scrolls with dead zone; for huge maps consider chunked `_draw` for `HexFieldGrid`.

### Input

- **Arrows**: handled on `MapCursor` (`set_process_input(true)` + `_input`).
- **Esc**: handled on `HexFieldStage` root.
- `pick_cell` expects **coordinates in `HexGrid` local space**; use `HexGrid.to_local(global_point)` from viewport clicks.

## Visual defaults

- Two alternating fill colors for readability.
- Outline color separate from fills; `outline_width` small for dense grids.

## Related

- `srpg_hex_cursor_guide.md` — beginner-friendly explanation of dead-zone smooth scroll (same behavior as Campaign board).
- `game_mode_select_design.md` — mode screen and navigation
- `menu_screen_design.md` — main menu
