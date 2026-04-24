extends State
class_name EnemyPatrol

@export var enemy: Enemy

var patrol_timer: float = 0.0
var patrol_duration: float = 2.0

func enter() -> void:
	patrol_timer = patrol_duration

func update(delta: float) -> void:
	patrol_timer -= delta
	if patrol_timer <= 0:
		enemy.direction *= -1
		patrol_timer = patrol_duration
		
	# Placeholder for vision check
	# if enemy.can_see_player(): state_machine.transition_to("enemychase")

func physics_update(_delta: float) -> void:
	enemy.velocity.x = enemy.direction * enemy.speed
