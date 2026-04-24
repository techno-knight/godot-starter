extends Node

## Handles saving and loading the game state securely to the user:// directory.

const SAVE_PATH := "user://savegame.tres"

var current_save: SaveData

func _ready() -> void:
	load_game()

func load_game() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		# We use load() for typed resources. It's safe as long as we only load our own local files.
		current_save = ResourceLoader.load(SAVE_PATH) as SaveData
	
	if current_save == null:
		# Create default save if it doesn't exist or is corrupt
		current_save = SaveData.new()
		save_game()

func save_game() -> void:
	var error = ResourceSaver.save(current_save, SAVE_PATH)
	if error != OK:
		push_error("Failed to save game. Error code: %d" % error)
	else:
		print("Game saved successfully.")

# Helper functions to modify save data easily
func update_high_score(score: int) -> void:
	if score > current_save.high_score:
		current_save.high_score = score
		save_game()

func unlock_level(level_id: int) -> void:
	if not current_save.unlocked_levels.has(level_id):
		current_save.unlocked_levels.append(level_id)
		save_game()
