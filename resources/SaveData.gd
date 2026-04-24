class_name SaveData extends Resource

## Defines the structure of our save file.
## Using Resources for saving provides type safety and easy integration with Godot's inspector.

@export var high_score: int = 0
@export var unlocked_levels: Array[int] = [1]
@export var volume_music: float = 1.0
@export var volume_sfx: float = 1.0

# Add more game-specific data here
