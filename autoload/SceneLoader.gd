extends Node

## Async Scene Loader for smooth transitions.
## Uses Godot 4 ResourceLoader for threaded loading, preventing lag spikes on mobile devices.

var _loading_screen_path: String = "res://ui/LoadingScreen.tscn"
var _loading_screen_instance: Node = null
var _target_scene_path: String = ""

# Track loading status
var _is_loading: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

## Initiates async loading of a scene and shows the loading screen.
func load_scene(path: String) -> void:
	if _is_loading:
		push_warning("Already loading a scene.")
		return
		
	_is_loading = true
	_target_scene_path = path
	
	# Instance the loading screen
	var loading_scene = load(_loading_screen_path)
	if loading_scene:
		_loading_screen_instance = loading_scene.instantiate()
		get_tree().root.add_child(_loading_screen_instance)
	
	# Start background thread loading
	ResourceLoader.load_threaded_request(_target_scene_path)
	
	# Wait one frame for the loading screen to render
	await get_tree().process_frame

func _process(_delta: float) -> void:
	if not _is_loading:
		return
		
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(_target_scene_path, progress)
	
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			# Update loading screen progress if it exists
			if _loading_screen_instance and _loading_screen_instance.has_method("update_progress"):
				_loading_screen_instance.update_progress(progress[0] * 100.0)
				
		ResourceLoader.THREAD_LOAD_LOADED:
			# Loading finished
			_is_loading = false
			var packed_scene = ResourceLoader.load_threaded_get(_target_scene_path)
			
			if packed_scene:
				get_tree().change_scene_to_packed(packed_scene)
			else:
				push_error("Failed to get packed scene.")
				
			# Remove loading screen
			if _loading_screen_instance:
				_loading_screen_instance.queue_free()
				_loading_screen_instance = null
				
		ResourceLoader.THREAD_LOAD_FAILED, ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			_is_loading = false
			push_error("Failed to load scene: " + _target_scene_path)
			if _loading_screen_instance:
				_loading_screen_instance.queue_free()
				_loading_screen_instance = null
