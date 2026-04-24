extends State
class_name EnemyChase

@export var enemy: Enemy

func update(_delta: float) -> void:
	if not enemy.target:
		state_machine.transition_to("enemypatrol")
		return
		
	var to_target = enemy.target.global_position.x - enemy.global_position.x
	enemy.direction = sign(to_target)

func physics_update(_delta: float) -> void:
	enemy.velocity.x = enemy.direction * (enemy.speed * 1.5)
