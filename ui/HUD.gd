extends Control

@onready var score_label: Label = $MarginContainer/HBoxContainer/ScoreLabel
@onready var health_bar: ProgressBar = $MarginContainer/HBoxContainer/HealthBar

func _ready() -> void:
	SignalBus.score_updated.connect(_on_score_updated)
	SignalBus.player_health_changed.connect(_on_health_changed)

func _on_score_updated(new_score: int) -> void:
	score_label.text = "Score: " + str(new_score)

func _on_health_changed(current_health: int, max_health: int) -> void:
	health_bar.max_value = max_health
	health_bar.value = current_health
