extends Area2D
class_name Collectible

@export var score_value: int = 50

func _ready() -> void:
	# Ensure it only monitors the player's layer (assuming layer 2 is Player)
	collision_mask = 2
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GameManager.add_score(score_value)
		# Optional: Play SFX via SignalBus or AudioManager
		# AudioManager.play_sfx_by_name("coin_pickup")
		queue_free()
