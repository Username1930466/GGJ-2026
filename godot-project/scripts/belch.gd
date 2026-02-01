extends Node2D

func _ready() -> void:
	$FizzleAnim.play("Fizzle")

func _on_belch_area_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitboxArea":
		area.get_parent().kill_player(Global.WAYS_TO_DIE.MIASMA)


func _on_fizzle_timer_timeout() -> void:
	queue_free()
