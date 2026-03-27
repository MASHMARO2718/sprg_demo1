extends Node2D

## Campaign hex board root: UI hint + Esc to mode select only.
## Cursor movement = `MapCursor` (srpg_map_cursor.gd). Camera = `srpg_camera_dead_zone.gd` (dead zone + smooth scroll).

const GAME_MODE_SELECT_SCENE := "res://assets/scene/test1/game_mode_select.tscn"

var _hint_label: Label


func _enter_tree() -> void:
	set_process_input(true)


func _ready() -> void:
	_add_screen_hint()
	if _hint_label:
		_hint_label.text = "Arrows: move cursor — camera drifts smoothly when near screen edge. Esc: back."


func _add_screen_hint() -> void:
	var layer := CanvasLayer.new()
	layer.name = "UILayer"
	layer.layer = 128
	var lbl := Label.new()
	lbl.name = "HintLabel"
	lbl.text = "Arrows: move  |  Esc: back"
	lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	lbl.add_theme_font_size_override(&"font_size", 15)
	lbl.add_theme_color_override(&"font_color", Color(0.85, 0.9, 0.95, 0.95))
	lbl.add_theme_color_override(&"font_shadow_color", Color(0, 0, 0, 0.75))
	lbl.add_theme_constant_override(&"shadow_offset_x", 1)
	lbl.add_theme_constant_override(&"shadow_offset_y", 1)
	lbl.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	lbl.offset_top = -44.0
	lbl.offset_bottom = -8.0
	lbl.mouse_filter = Control.MOUSE_FILTER_IGNORE
	lbl.focus_mode = Control.FOCUS_NONE
	add_child(layer)
	layer.add_child(lbl)
	_hint_label = lbl


func _input(event: InputEvent) -> void:
	if not event is InputEventKey:
		return
	var e := event as InputEventKey
	if not e.pressed or e.echo:
		return
	if e.is_action_pressed(&"ui_cancel") or _key_match(e, KEY_ESCAPE):
		get_viewport().set_input_as_handled()
		get_tree().change_scene_to_file(GAME_MODE_SELECT_SCENE)


static func _key_match(e: InputEventKey, key: Key) -> bool:
	return e.keycode == key or e.physical_keycode == key
