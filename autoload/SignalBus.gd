extends Node

## Centralized Event Bus.
## All global events should be routed through here to prevent tight coupling between scenes.
## For a 50+ scene game, maintaining a clean SignalBus is critical.

# Game State Signals
signal game_paused(is_paused: bool)
signal game_over
signal level_completed

# Player Signals
signal player_health_changed(current_health: int, max_health: int)
signal player_died
signal score_updated(new_score: int)

# Example: Audio Signals (if we wanted scenes to emit sound requests, though direct calls to AudioManager are also fine)
signal play_sfx_requested(sfx_name: String)

func _ready() -> void:
	# Setting process_mode to always ensures signals work even when the game is paused
	process_mode = Node.PROCESS_MODE_ALWAYS
