extends CharacterBody2D
class_name Player

@export var speed: float = 300.0
@export var jump_velocity: float = -400.0
@export var gravity: float = 980.0

@onready var state_machine: StateMachine = $StateMachine
@onready var health_component: HealthComponent = $HealthComponent
@onready var sprite: Sprite2D = $Sprite2D # Placeholder for visuals

var direction: float = 0.0

func _ready() -> void:
	# Connect local health changes to the global SignalBus
	health_component.health_changed.connect(
		func(current, max_val): SignalBus.player_health_changed.emit(current, max_val)
	)
	health_component.died.connect(
		func(): SignalBus.player_died.emit()
	)
	
	# Initial UI update
	SignalBus.player_health_changed.emit(health_component.current_health, health_component.max_health)

func _physics_process(delta: float) -> void:
	# Input is processed every frame regardless of state
	direction = Input.get_axis("move_left", "move_right")
	
	if direction != 0:
		sprite.flip_h = direction < 0
	
	move_and_slide()

# Public methods for states to use
func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_movement() -> void:
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
