extends Node2D

const bat_min_x = -100
const bat_max_x = 100
const bat_min_y = -100
const bat_max_y = 100

const bat_min_amount = 10
const bat_max_amount = 15

const bat_min_scale = 0.03
const bat_max_scale = 0.05

const bat_min_anim_speed = 0.9
const bat_max_anim_speed = 1.1

var swarmAmount : int
var batScene = preload("res://scenes/bat.tscn")

func _ready() -> void:
	swarmAmount = randi_range(bat_min_amount,bat_max_amount)
	
	for i in swarmAmount:
		var batInstance = batScene.instantiate()
		add_child(batInstance)
		batInstance.position = Vector2(randf_range(bat_min_x,bat_max_x),randf_range(bat_min_y,bat_max_y))
		batInstance.scale.x = randf_range(bat_min_scale,bat_max_scale)
		batInstance.scale.y = batInstance.scale.x
		batInstance.speed_scale = randf_range(bat_min_anim_speed,bat_max_anim_speed)
