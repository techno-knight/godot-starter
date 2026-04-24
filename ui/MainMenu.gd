extends Control

@onready var play_button: Button = $VBoxContainer/PlayButton
@onready var quit_button: Button = $VBoxContainer/QuitButton

const FIRST_LEVEL_PATH = "res://levels/Level_01.tscn"

func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	# Mobile platforms usually don't need a quit button
	if OS.get_name() in ["Android", "iOS"]:
		quit_button.hide()

func _on_play_pressed() -> void:
	GameManager.reset_game_state()
	SceneLoader.load_scene(FIRST_LEVEL_PATH)

func _on_quit_pressed() -> void:
	get_tree().quit()
