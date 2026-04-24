class_name HurtboxComponent extends Area2D

## Receives damage from HitboxComponents.
## Must have a reference to a HealthComponent to apply the damage.

@export var health_component: HealthComponent
@export var invincible: bool = false

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if invincible or not health_component:
		return
		
	if area is HitboxComponent:
		health_component.take_damage(area.damage)
