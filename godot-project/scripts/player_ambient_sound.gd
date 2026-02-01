extends Timer

@export var audio_stream_player: AudioStreamPlayer

func _ready() -> void:
	wait_time = randi_range(5,15)
	timeout.connect(_on_timer_timeout)
	start()
	
func _on_timer_timeout()-> void:
	wait_time = randi_range(5,15)
	audio_stream_player.play()
	start()
