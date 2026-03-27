extends Node2D

## Discrete hex cursor: arrow keys only change logical cell; does not move the camera.
## Expects parent space == HexFieldGrid space (sibling of map, map at origin).

signal cell_changed(previous: Vector2i, current: Vector2i)

@export var hex_map: NodePath
## Starting cell in odd-q offset (col, row).
@export var start_cell: Vector2i = Vector2i(10, 5)

var _map: HexFieldGrid
var _cell: Vector2i


func _enter_tree() -> void:
	set_process_input(true)


func _ready() -> void:
	_map = get_node_or_null(hex_map) as HexFieldGrid
	_cell = start_cell
	if _map:
		_cell.x = clampi(_cell.x, 0, _map.grid_columns - 1)
		_cell.y = clampi(_cell.y, 0, _map.grid_rows - 1)
	_sync_from_cell()
	_fit_sprite()


func _fit_sprite() -> void:
	var spr := get_node_or_null("Sprite2D") as Sprite2D
	if spr == null or _map == null:
		return
	var s: float = clampf(_map.hex_outer_radius * 0.009, 0.08, 0.35)
	spr.scale = Vector2(s, s)


func _input(event: InputEvent) -> void:
	if _map == null or not event is InputEventKey:
		return
	var e := event as InputEventKey
	if not e.pressed or e.echo:
		return
	var dq := 0
	var dr := 0
	if e.is_action_pressed(&"ui_up") or _key_match(e, KEY_UP):
		dr = -1
	elif e.is_action_pressed(&"ui_down") or _key_match(e, KEY_DOWN):
		dr = 1
	elif e.is_action_pressed(&"ui_left") or _key_match(e, KEY_LEFT):
		dq = -1
	elif e.is_action_pressed(&"ui_right") or _key_match(e, KEY_RIGHT):
		dq = 1
	if dq == 0 and dr == 0:
		return
	get_viewport().set_input_as_handled()
	_try_step(dq, dr)


func _try_step(dq: int, dr: int) -> void:
	var prev := _cell
	var nxt: Vector2i = _map.step_cell_axial(prev.x, prev.y, dq, dr)
	if nxt == prev:
		return
	_cell = nxt
	_sync_from_cell()
	cell_changed.emit(prev, _cell)


static func _key_match(e: InputEventKey, key: Key) -> bool:
	return e.keycode == key or e.physical_keycode == key


func _sync_from_cell() -> void:
	if _map:
		position = _map.offset_to_pixel(_cell.x, _cell.y)
	queue_redraw()


func get_cell() -> Vector2i:
	return _cell


func get_axial() -> Vector2i:
	if _map == null:
		return Vector2i.ZERO
	return _map.offset_to_axial(_cell.x, _cell.y)


func _draw() -> void:
	var rr := 10.0
	if _map:
		rr = clampf(_map.hex_outer_radius * 0.28, 7.0, 22.0)
	draw_arc(Vector2.ZERO, rr, 0.0, TAU, 40, Color(1.0, 0.92, 0.35, 1.0), 3.0, true)
	draw_arc(Vector2.ZERO, rr + 2.0, 0.0, TAU, 40, Color(0.1, 0.08, 0.02, 0.85), 1.5, true)
