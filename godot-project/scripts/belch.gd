extends Node2D

@export var sound1: AudioStreamWAV
@export var sound2: AudioStreamWAV

func _ready() -> void:
	if randi_range(1, 2):
		$AudioStreamPlayer2D.stream = sound1
	else:
		$AudioStreamPlayer2D.stream = sound2
	$AudioStreamPlayer2D.playing = true
	$FizzleAnim.play("Fizzle")

func _on_belch_area_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitboxArea":
		area.get_parent().kill_player(Global.WAYS_TO_DIE.MIASMA)


func _on_fizzle_timer_timeout() -> void:
	queue_free()
