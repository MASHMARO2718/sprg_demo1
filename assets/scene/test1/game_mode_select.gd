extends Control

## Game mode picker after "New Game". Add modes under %PrimaryModeList or drive from data; use %ScreenHost / %ModalHost like the main menu.

const MAIN_MENU_SCENE := "res://assets/scene/test1/main_menu.tscn"
const HEX_FIELD_STAGE_SCENE := "res://assets/scene/test1/hex_field_stage.tscn"

@onready var _screen_host: Control = %ScreenHost
@onready var _modal_host: Control = %ModalHost


func _ready() -> void:
	%BtnBack.pressed.connect(_on_back_pressed)
	%BtnModeCampaign.pressed.connect(_on_mode_campaign_pressed)
	%BtnModeSkirmish.pressed.connect(_on_mode_skirmish_pressed)
	%BtnModeTutorial.pressed.connect(_on_mode_tutorial_pressed)
	_screen_host.visible = false
	_modal_host.visible = false


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_MENU_SCENE)


func _on_mode_campaign_pressed() -> void:
	get_tree().change_scene_to_file(HEX_FIELD_STAGE_SCENE)


func _on_mode_skirmish_pressed() -> void:
	# Extend: skirmish setup flow or sub-panel under %ScreenHost
	pass


func _on_mode_tutorial_pressed() -> void:
	# Extend: tutorial chapter select or locked state from save flags
	pass
