extends State
class_name PlayerIdle

@export var player: Player

func update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("playerjump")
		return
		
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("playerjump")
		return
		
	if player.direction != 0:
		state_machine.transition_to("playerrun")

func physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	player.handle_movement()
