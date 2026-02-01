extends Area2D

var batIn = null

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("MaskAbility"):
		$Sprite2.modulate = Color(1.0, 1.0, 1.0, 1.0)
		$Sprite3.modulate = Color(1.0, 1.0, 1.0, 1.0)
		$Sprite4.modulate = Color(1.0, 1.0, 1.0, 1.0)
		$Sprite5.modulate = Color(1.0, 1.0, 1.0, 1.0)
		if batIn != null:
			batIn.Disperse()
			batIn = null
	else:
		$Sprite2.modulate = Color(1.0, 1.0, 1.0, 0.196)
		$Sprite3.modulate = Color(1.0, 1.0, 1.0, 0.196)
		$Sprite4.modulate = Color(1.0, 1.0, 1.0, 0.196)
		$Sprite5.modulate = Color(1.0, 1.0, 1.0, 0.196)



func _on_area_entered(area: Area2D) -> void:
	if area.name == "SwarmArea":
		batIn = area.get_parent()


func _on_area_exited(area: Area2D) -> void:
	if area.name == "SwarmArea":
		batIn = null
