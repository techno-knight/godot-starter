extends Control

@onready var progress_bar: ProgressBar = $VBoxContainer/ProgressBar

func _ready() -> void:
	# Ensure the loading screen covers everything and ignores pausing
	process_mode = Node.PROCESS_MODE_ALWAYS
	z_index = 100

func update_progress(value: float) -> void:
	if progress_bar:
		progress_bar.value = value
