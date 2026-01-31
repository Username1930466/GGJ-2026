extends Node2D

@onready var floor1: ColorRect = $Floor1 # change ColorRect to Sprite2D when we have floor sprites
@onready var floor2: ColorRect = $Floor2

func _process(delta: float) -> void:
	 # Floor Movement
	floor1.position.x -= 250 * delta
	floor2.position.x -= 250 * delta
	if floor1.position.x <= -1920:
		floor1.position.x = 1920
	if floor2.position.x <= -1920:
		floor2.position.x = 1920
