extends Node

## Manages high-level game state.
## Keeps track of current score, active level, and global game logic.

var current_score: int = 0
var is_game_over: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	SignalBus.player_died.connect(_on_player_died)
	SignalBus.level_completed.connect(_on_level_completed)

func reset_game_state() -> void:
	current_score = 0
	is_game_over = false
	SignalBus.score_updated.emit(current_score)
	# Unpause if we reset while paused
	get_tree().paused = false
	SignalBus.game_paused.emit(false)

func add_score(amount: int) -> void:
	if is_game_over: return
	current_score += amount
	SignalBus.score_updated.emit(current_score)

func toggle_pause() -> void:
	if is_game_over: return
	get_tree().paused = !get_tree().paused
	SignalBus.game_paused.emit(get_tree().paused)

func _on_player_died() -> void:
	is_game_over = true
	SignalBus.game_over.emit()

func _on_level_completed() -> void:
	# Logic to load next level or show victory screen
	pass
