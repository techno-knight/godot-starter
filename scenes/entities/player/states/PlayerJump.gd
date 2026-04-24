extends State
class_name PlayerJump

@export var player: Player

func enter() -> void:
	if player.is_on_floor():
		player.velocity.y = player.jump_velocity

func update(_delta: float) -> void:
	if player.is_on_floor():
		if player.direction == 0:
			state_machine.transition_to("playeridle")
		else:
			state_machine.transition_to("playerrun")

func physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	player.handle_movement()
