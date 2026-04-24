class_name State extends Node

## Base class for FSM states.
## Extend this to create specific logic per state.

var state_machine: StateMachine

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
