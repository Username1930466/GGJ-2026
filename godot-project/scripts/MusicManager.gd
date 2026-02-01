class_name MusicManager extends Node

@export var game_track:AudioStream
@export var menu_track:AudioStream

@export var audio_stream_player: AudioStreamPlayer

var fade_tween:Tween

func _ready() -> void:
	Global.game_started.connect(_on_game_started)
	Global.game_ended.connect(_on_game_ended)


# Connects to Global.game_started signal
func _on_game_started()-> void:
	audio_fade_out(1)
	await fade_tween.finished
	audio_stream_player.stream = game_track
	audio_stream_player.play()
	audio_fade_in()

# Connects to Global.game_ended signal
func _on_game_ended()-> void:
	audio_fade_out(1)
	await fade_tween.finished
	audio_stream_player.stream = menu_track

	audio_stream_player.play()
	audio_fade_in()

func audio_fade_out(duration: float = 0.5) -> void:
	fade_tween = create_tween()
	fade_tween.tween_property(audio_stream_player, "volume_db", -20.0, duration)

func audio_fade_in(duration: float = 0.5) -> void:
	fade_tween = create_tween()
	fade_tween.tween_property(audio_stream_player, "volume_db", 0.0, duration)
