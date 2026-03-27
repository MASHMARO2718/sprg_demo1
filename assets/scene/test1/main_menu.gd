extends Control

## Main menu controller. Wire new actions here or swap ScreenHost / ModalHost content from dedicated UI modules.

const GAME_MODE_SELECT_SCENE := "res://assets/scene/test1/game_mode_select.tscn"

@onready var _screen_host: Control = %ScreenHost
@onready var _modal_host: Control = %ModalHost


func _ready() -> void:
	%BtnNewGame.pressed.connect(_on_new_game_pressed)
	%BtnContinue.pressed.connect(_on_continue_pressed)
	%BtnSettings.pressed.connect(_on_settings_pressed)
	%BtnQuit.pressed.connect(_on_quit_pressed)
	# Reserved for save detection, locale, build label, etc.
	_screen_host.visible = false
	_modal_host.visible = false


func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file(GAME_MODE_SELECT_SCENE)


func _on_continue_pressed() -> void:
	# Extend: load save; change scene
	pass


func _on_settings_pressed() -> void:
	# Extend: instatiate settings UI under %ModalHost or push to ScreenHost
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()
