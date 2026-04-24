extends SceneTree

## A lightweight test runner that can be executed from the command line:
## godot --no-window -s res://tests/SimpleTestRunner.gd

func _init() -> void:
	print("--- Running Unit Tests ---")
	
	test_health_component()
	test_object_pool()
	
	print("--- All Tests Passed ---")
	quit(0)

func assert_eq(actual, expected, message: String = "") -> void:
	if actual != expected:
		push_error("Assertion failed: Expected %s but got %s. %s" % [expected, actual, message])
		quit(1)

func test_health_component() -> void:
	print("Testing HealthComponent...")
	var hc = load("res://core/components/HealthComponent.gd").new()
	hc.max_health = 100
	hc._ready()
	
	hc.take_damage(20)
	assert_eq(hc.current_health, 80, "Health should decrease.")
	
	hc.heal(50)
	assert_eq(hc.current_health, 100, "Health should not exceed max.")
	
	hc.free()

func test_object_pool() -> void:
	print("Testing ObjectPool...")
	var pool = load("res://core/utils/ObjectPool.gd").new()
	
	# Normally we'd assign a PackedScene here, but since it's just a raw node:
	# Note: In a real test, load a dummy scene. We will just verify it initializes without crashing.
	assert_eq(pool.pool_size, 20, "Default pool size should be 20.")
	
	pool.free()
