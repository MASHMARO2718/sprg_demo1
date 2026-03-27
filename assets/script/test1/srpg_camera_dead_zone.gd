extends Camera2D

## FE-like scroll: only pans when the cursor leaves an inner margin around screen center; smooth lerp each frame.
## Assumes this camera shares the same parent Node2D as the cursor and hex map (common world space).

@export var cursor_path: NodePath
@export var map_path: NodePath
## Pixels from viewport edge toward center; cursor outside this inner box pulls the camera.
@export var margin_pixels: Vector2 = Vector2(112, 112)
## Higher = snappier follow (exponential smoothing factor, ~8–18 typical).
@export var smoothing: float = 14.0
## Initial zoom relative to "fit entire map" from HexFieldGrid.
@export_range(0.15, 1.5, 0.01) var zoom_vs_fit_all: float = 0.48

var _cursor: Node2D
var _map: HexFieldGrid


func _enter_tree() -> void:
	set_physics_process(true)


func _ready() -> void:
	_cursor = get_node_or_null(cursor_path) as Node2D
	_map = get_node_or_null(map_path) as HexFieldGrid
	await get_tree().process_frame
	if _map:
		var z := _map.get_recommended_zoom(get_viewport_rect().size) * zoom_vs_fit_all
		zoom = Vector2(z, z)
	if _cursor:
		position = _cursor.position
	make_current()


func _physics_process(delta: float) -> void:
	if _cursor == null or _map == null:
		return
	var half_world: Vector2 = get_viewport_rect().size / (2.0 * zoom)
	var margin_world := Vector2(margin_pixels.x / zoom.x, margin_pixels.y / zoom.y)
	# Raw dead-zone half-extent in world units (screen margin inset).
	var inner: Vector2 = half_world - margin_world
	if inner.x < 1.0 or inner.y < 1.0:
		inner = half_world * 0.35
	# When zoomed out enough that the whole map fits on screen, `inner` can exceed
	# any possible cursor offset on the map, so the camera never pans. Cap by field
	# half-size so the cursor can still push the view at map edges.
	var fh: Vector2 = _map.get_field_bounds().size * 0.5
	var cap := Vector2(maxf(fh.x * 0.88, 16.0), maxf(fh.y * 0.88, 16.0))
	inner.x = minf(inner.x, cap.x)
	inner.y = minf(inner.y, cap.y)
	var cpos := position
	var ppos := _cursor.position
	var d := ppos - cpos
	var target := cpos
	if d.x > inner.x:
		target.x = ppos.x - inner.x
	elif d.x < -inner.x:
		target.x = ppos.x + inner.x
	if d.y > inner.y:
		target.y = ppos.y - inner.y
	elif d.y < -inner.y:
		target.y = ppos.y + inner.y
	target = _clamp_target_to_map(target, half_world)
	var alpha := 1.0 - exp(-smoothing * delta)
	position = position.lerp(target, alpha)


func _clamp_target_to_map(target: Vector2, half_world: Vector2) -> Vector2:
	var b := _map.get_field_bounds()
	# Two regimes per axis (W = visible half-extent in world units, L = map length):
	# - 2W < L: map wider than view — camera in [m0+W, m1-W] (edges of map at viewport edges).
	# - 2W >= L: whole map fits — camera in [m1-W, m0+W] so the map stays inside the view
	#   while still allowing pan until an edge touches the viewport (NOT frozen at center).
	# The old branch min_x > max_x → center was wrong for 2W >= L and blocked all scrolling.
	var tx := _clamp_camera_axis(target.x, b.position.x, b.end.x, half_world.x)
	var ty := _clamp_camera_axis(target.y, b.position.y, b.end.y, half_world.y)
	return Vector2(tx, ty)


static func _clamp_camera_axis(t: float, m0: float, m1: float, w: float) -> float:
	var span := m1 - m0
	if span <= 0.001:
		return (m0 + m1) * 0.5
	if 2.0 * w < span:
		return clampf(t, m0 + w, m1 - w)
	return clampf(t, m1 - w, m0 + w)
