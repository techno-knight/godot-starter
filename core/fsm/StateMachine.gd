class_name StateMachine extends Node

## A robust Finite State Machine base class.
## Children of this node should be of type 'State'.

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_machine = self
	
	# Wait for parent to finish _ready
	await owner.ready
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func transition_to(state_name: String) -> void:
	if not has_node(state_name):
		push_error("State machine does not contain state: " + state_name)
		return
		
	var target_state = get_node(state_name) as State
	
	if current_state:
		current_state.exit()
		
	current_state = target_state
	current_state.enter()
