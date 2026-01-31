extends Node2D

@onready var floor1 = $Floor1
@onready var floor2 = $Floor2

func _process(delta: float) -> void:
	floor1.position.x -= 250 * delta
	floor2.position.x -= 250 * delta
	if floor1.position.x <= -1920:
		floor1.position.x = 1920
	if floor2.position.x <= -1920:
		floor2.position.x = 1920
