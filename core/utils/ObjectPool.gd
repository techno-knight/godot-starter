class_name ObjectPool extends Node

## A generalized Object Pool to prevent stuttering from instantiating nodes during gameplay.
## Useful for bullets, particles, etc.

@export var pool_scene: PackedScene
@export var pool_size: int = 20

var _available_nodes: Array[Node] = []
var _active_nodes: Array[Node] = []

func _ready() -> void:
	if not pool_scene:
		push_error("ObjectPool: pool_scene is not assigned.")
		return
		
	for i in range(pool_size):
		var node = pool_scene.instantiate()
		_disable_node(node)
		add_child(node)
		_available_nodes.append(node)

## Requests a node from the pool. Returns null if empty.
func get_node_from_pool() -> Node:
	if _available_nodes.is_empty():
		push_warning("ObjectPool is empty. Consider increasing size.")
		return null
		
	var node = _available_nodes.pop_back()
	_enable_node(node)
	_active_nodes.append(node)
	return node

## Returns a node to the pool.
func return_node(node: Node) -> void:
	if _active_nodes.has(node):
		_active_nodes.erase(node)
		_disable_node(node)
		_available_nodes.append(node)

func _disable_node(node: Node) -> void:
	node.process_mode = Node.PROCESS_MODE_DISABLED
	# Hide rendering. Supports CanvasItem (2D) and Node3D (3D).
	if node.has_method("hide"):
		node.hide()
	
	# Attempt to call a custom reset method if it exists
	if node.has_method("reset"):
		node.reset()

func _enable_node(node: Node) -> void:
	node.process_mode = Node.PROCESS_MODE_INHERIT
	if node.has_method("show"):
		node.show()
