extends Node2D

var mask = "none"
var batMaskSonar = preload("res://scenes/bat_mask_sonar_area.tscn")

func _ready() -> void:
	SwitchMask("bat")

func SwitchMask(targetMask):
	mask = targetMask
	match mask:
		
		"none":
			pass
		
		"bat":
			var sonarInstance = batMaskSonar.instantiate()
			get_node("EyeHeight").add_child(sonarInstance)
		
		"speed":
			pass
		
		"reveal":
			pass
