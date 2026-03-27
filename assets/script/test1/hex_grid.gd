class_name HexFieldGrid
extends Node2D

## Rectangular map in odd-q offset coordinates, pointy-top hexes. See hex_field_design.md.

const _SQRT3: float = 1.7320508075688772

@export_group("Grid")
@export var grid_columns: int = 28: set = set_grid_columns
@export var grid_rows: int = 16: set = set_grid_rows
@export var hex_outer_radius: float = 14.0: set = set_hex_outer_radius

@export_group("Look")
@export var fill_color_a: Color = Color(0.22, 0.32, 0.24, 1.0)
@export var fill_color_b: Color = Color(0.18, 0.27, 0.2, 1.0)
@export var outline_color: Color = Color(0.08, 0.1, 0.09, 1.0)
@export var outline_width: float = 1.0


func set_grid_columns(v: int) -> void:
	grid_columns = maxi(1, v)
	queue_redraw()


func set_grid_rows(v: int) -> void:
	grid_rows = maxi(1, v)
	queue_redraw()


func set_hex_outer_radius(v: float) -> void:
	hex_outer_radius = maxf(4.0, v)
	queue_redraw()


func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	for c in grid_columns:
		for r in grid_rows:
			var center := offset_to_pixel(c, r)
			var fill := fill_color_a if (c + r) & 1 == 0 else fill_color_b
			var corners := _hex_corner_points(center, hex_outer_radius)
			draw_colored_polygon(corners, fill)
			corners.append(corners[0])
			draw_polyline(corners, outline_color, outline_width, true)


## Odd-q offset (col, row) → pixel position (local space, pointy-top).
func offset_to_pixel(col: int, row: int) -> Vector2:
	var q := col
	var r := row - (col - (col & 1)) / 2
	var x := hex_outer_radius * _SQRT3 * (float(q) + float(r) * 0.5)
	var y := hex_outer_radius * 1.5 * float(r)
	return Vector2(x, y)


func offset_to_axial(col: int, row: int) -> Vector2i:
	var q := col
	var r := row - (col - (col & 1)) / 2
	return Vector2i(q, r)


func axial_to_offset(q: int, r: int) -> Vector2i:
	var col := q
	var row := r + (q - (q & 1)) / 2
	return Vector2i(col, row)


func is_cell_in_bounds(col: int, row: int) -> bool:
	return col >= 0 and col < grid_columns and row >= 0 and row < grid_rows


## One axial step (pointy-top / odd-q); invalid targets return the starting cell.
func step_cell_axial(from_col: int, from_row: int, dq: int, dr: int) -> Vector2i:
	var a := offset_to_axial(from_col, from_row)
	var next := axial_to_offset(a.x + dq, a.y + dr)
	if not is_cell_in_bounds(next.x, next.y):
		return Vector2i(from_col, from_row)
	return next


## Nearest cell for hit-testing; returns Vector2i(-1, -1) if outside [0, columns) × [0, rows).
func pick_cell(local_point: Vector2) -> Vector2i:
	var best: Vector2i = Vector2i(-1, -1)
	var best_d2 := INF
	for c in grid_columns:
		for r in grid_rows:
			var center := offset_to_pixel(c, r)
			var d2 := center.distance_squared_to(local_point)
			if d2 < best_d2:
				best_d2 = d2
				best = Vector2i(c, r)
	if best.x < 0:
		return Vector2i(-1, -1)
	var center_best := offset_to_pixel(best.x, best.y)
	if not Geometry2D.is_point_in_polygon(local_point, _hex_corner_points(center_best, hex_outer_radius)):
		return Vector2i(-1, -1)
	return best


func get_field_bounds() -> Rect2:
	if grid_columns < 1 or grid_rows < 1:
		return Rect2()
	var margin := hex_outer_radius * 1.02
	var inf_rect := Rect2(offset_to_pixel(0, 0), Vector2.ZERO).grow(margin)
	var rect := inf_rect
	for c in grid_columns:
		for r in grid_rows:
			var p := offset_to_pixel(c, r)
			rect = rect.merge(Rect2(p, Vector2.ZERO).grow(margin))
	return rect


func get_field_center() -> Vector2:
	return get_field_bounds().get_center()


## Fit grid into viewport pixels (approximate orthographic zoom for Camera2D).
func get_recommended_zoom(viewport_size: Vector2, margin: float = 0.92) -> float:
	var b := get_field_bounds()
	if b.size == Vector2.ZERO:
		return 1.0
	var fit := viewport_size / b.size
	return margin * minf(fit.x, fit.y)


func _hex_corner_points(center: Vector2, outer_r: float) -> PackedVector2Array:
	var pts: PackedVector2Array = PackedVector2Array()
	pts.resize(6)
	for i in 6:
		var ang := -PI * 0.5 + float(i) * TAU / 6.0
		pts[i] = center + Vector2(outer_r * cos(ang), outer_r * sin(ang))
	return pts
