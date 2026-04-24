extends Node

## Manages Audio playback with a simple internal Object Pool for SFX.

const MAX_SFX_PLAYERS = 8

var _sfx_players: Array[AudioStreamPlayer] = []
var _bgm_player: AudioStreamPlayer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Setup BGM Player
	_bgm_player = AudioStreamPlayer.new()
	_bgm_player.bus = "Music"
	add_child(_bgm_player)
	
	# Setup SFX Pool
	for i in range(MAX_SFX_PLAYERS):
		var p = AudioStreamPlayer.new()
		p.bus = "SFX"
		add_child(p)
		_sfx_players.append(p)
		
	# Connect to SignalBus if using signal-driven audio
	SignalBus.play_sfx_requested.connect(play_sfx_by_name)

func play_bgm(stream: AudioStream) -> void:
	if _bgm_player.stream == stream and _bgm_player.playing:
		return
	_bgm_player.stream = stream
	_bgm_player.play()

func stop_bgm() -> void:
	_bgm_player.stop()

func play_sfx(stream: AudioStream, pitch_variance: float = 0.0) -> void:
	if not stream: return
	
	for p in _sfx_players:
		if not p.playing:
			p.stream = stream
			if pitch_variance > 0.0:
				p.pitch_scale = randf_range(1.0 - pitch_variance, 1.0 + pitch_variance)
			else:
				p.pitch_scale = 1.0
			p.play()
			return
			
	push_warning("AudioManager: All SFX players are busy!")

# Example lookup dictionary for names to streams
var sfx_dictionary: Dictionary = {}

func play_sfx_by_name(sfx_name: String) -> void:
	if sfx_dictionary.has(sfx_name):
		play_sfx(sfx_dictionary[sfx_name])
