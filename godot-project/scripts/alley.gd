extends Node2D
@export var audio_stream_player: AudioStreamPlayer
var wail_played:bool = false
# Plays a wail sfx if alley hits mid screen and a 50/50 chance passes
func _process(delta: float) -> void:
	if global_position.x < 1200 && !wail_played && randf() > 0.5:
		wail_played = true
		audio_stream_player.play()
