extends Node

## PoolManager Autoload
## A global manager for object pools. Essential for a 50+ scene game to avoid
## scattering ObjectPool nodes across levels and to manage multiple pool types (bullets, effects, etc).

var _pools: Dictionary = {}

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

## Registers a new pool for a specific PackedScene.
func create_pool(pool_id: String, scene: PackedScene, initial_size: int = 20) -> void:
	if _pools.has(pool_id):
		push_warning("Pool %s already exists." % pool_id)
		return
		
	var pool_node = Node.new()
	pool_node.name = pool_id + "_Pool"
	add_child(pool_node)
	
	var pool_data = {
		"scene": scene,
		"available": [],
		"active": [],
		"parent_node": pool_node
	}
	
	for i in range(initial_size):
		var instance = scene.instantiate()
		_disable_node(instance)
		pool_node.add_child(instance)
		pool_data.available.append(instance)
		
	_pools[pool_id] = pool_data

## Retrieves a node from the requested pool.
func get_node_from_pool(pool_id: String) -> Node:
	if not _pools.has(pool_id):
		push_error("Pool %s does not exist." % pool_id)
		return null
		
	var pool = _pools[pool_id]
	
	if pool.available.is_empty():
		push_warning("Pool %s is empty, instantiating new node (performance hit)." % pool_id)
		var new_instance = pool.scene.instantiate()
		pool.parent_node.add_child(new_instance)
		_enable_node(new_instance)
		pool.active.append(new_instance)
		return new_instance
		
	var node = pool.available.pop_back()
	_enable_node(node)
	pool.active.append(node)
	return node

## Returns a node to its pool.
func return_node(pool_id: String, node: Node) -> void:
	if not _pools.has(pool_id):
		return
		
	var pool = _pools[pool_id]
	if pool.active.has(node):
		pool.active.erase(node)
		_disable_node(node)
		pool.available.append(node)

func _disable_node(node: Node) -> void:
	node.process_mode = Node.PROCESS_MODE_DISABLED
	if node.has_method("hide"):
		node.hide()
	if node.has_method("reset"):
		node.reset()

func _enable_node(node: Node) -> void:
	node.process_mode = Node.PROCESS_MODE_INHERIT
	if node.has_method("show"):
		node.show()
