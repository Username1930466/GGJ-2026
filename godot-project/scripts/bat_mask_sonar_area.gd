extends Area2D

var batIn = null

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("MaskAbility"):
		if batIn != null:
			batIn.queue_free()
			batIn = null



func _on_area_entered(area: Area2D) -> void:
	if area.name == "BatSwarmArea":
		batIn = area.get_parent()


func _on_area_exited(area: Area2D) -> void:
	if area.name == "BatSwarmArea":
		batIn = null
