class_name HitboxComponent extends Area2D

## Deals damage to HurtboxComponents it intersects with.
## Should be placed on a layer that only masks the Hurtbox layer.

@export var damage: int = 10

func _ready() -> void:
	# Ensure Area2D configuration is correct
	monitoring = false
	monitorable = true
