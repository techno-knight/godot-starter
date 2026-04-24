extends Control

@onready var resume_button: Button = $VBoxContainer/ResumeButton
@onready var main_menu_button: Button = $VBoxContainer/MainMenuButton

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	
	resume_button.pressed.connect(_on_resume_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	
	SignalBus.game_paused.connect(_on_game_paused)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_pause"):
		GameManager.toggle_pause()

func _on_game_paused(is_paused: bool) -> void:
	visible = is_paused

func _on_resume_pressed() -> void:
	GameManager.toggle_pause()

func _on_main_menu_pressed() -> void:
	GameManager.toggle_pause() # Unpause before leaving
	SceneLoader.load_scene("res://ui/MainMenu.tscn")
