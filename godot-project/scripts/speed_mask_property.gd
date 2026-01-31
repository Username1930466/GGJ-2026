extends Node2D

var speedTime = 1
var sprintable = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("MaskAbility"):
		if sprintable == true:
			sprintable = false
			$Cooldown.start(5)
			get_parent().targetX = get_parent().speedX
			await get_tree().create_timer(speedTime).timeout
			get_parent().targetX = get_parent().startingX


func _on_cooldown_timeout() -> void:
	sprintable = true
