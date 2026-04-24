extends CharacterBody2D
class_name Enemy

@export var speed: float = 100.0
@export var gravity: float = 980.0

@onready var state_machine: StateMachine = $StateMachine
@onready var health_component: HealthComponent = $HealthComponent

var direction: float = 1.0 # 1 for right, -1 for left
var target: Node2D = null

func _ready() -> void:
	health_component.died.connect(_on_died)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

func _on_died() -> void:
	# Add score, spawn particles, etc.
	GameManager.add_score(100)
	queue_free()
