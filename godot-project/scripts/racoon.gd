extends Node2D

@export var area_2d: Area2D


func _ready() -> void:
	area_2d.area_entered.connect(_on_area_entered)
	area_2d.area_exited.connect(_on_area_exited)

func _on_area_entered(other_area: Area2D) -> void:
	print("Colliding with: ", other_area.name)
	var collider:Node = other_area.get_parent()
	if collider is Player:
		var player:Player = collider as Player
		
		# 50% chance to die to racoon
		if randf() > 0.5:
			player.kill_player(Global.WAYS_TO_DIE.CHECKPOINT)
			
	elif collider is CandyBar:
		queue_free()

func _on_area_exited(other_area: Area2D) -> void:
	print("Stopped colliding with: ", other_area.name)

func _process(delta: float) -> void:
	position.x -= 250 * delta
	position.x = round(position.x)
