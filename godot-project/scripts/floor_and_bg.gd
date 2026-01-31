extends Node2D

@onready var floor1: Sprite2D = $Floor1 # change ColorRect to Sprite2D when we have floor sprites
@onready var floor2: Sprite2D = $Floor2
@onready var floor3: Sprite2D = $Floor3
@onready var floor4: Sprite2D = $Floor4
@onready var floor5: Sprite2D = $Floor5

var buildings_total_width: int = 0
var building_scene = preload("res://scenes/building.tscn")

func _ready() -> void:
	while buildings_total_width <= 1920:
		create_building(randi_range(1, 1))
	pass

func _process(delta: float) -> void:
	 # Floor Movement
	floor1.position.x -= 250 * delta
	floor2.position.x -= 250 * delta
	floor3.position.x -= 250 * delta
	floor4.position.x -= 250 * delta
	floor5.position.x -= 250 * delta
	if floor1.position.x <= -960:
		floor1.position.x = 2880
	if floor2.position.x <= -960:
		floor2.position.x = 2880
	if floor3.position.x <= -960:
		floor3.position.x = 2880
	if floor4.position.x <= -960:
		floor4.position.x = 2880
	if floor5.position.x <= -960:
		floor5.position.x = 2880
	
	 # Building Movement
	buildings_total_width -= 250 * delta
	if buildings_total_width <= 1920:
			create_building(randi_range(1, 1))
	for building in $Buildings.get_children():
		building.position.x -= 250 * delta
		if building.position.x <= -1050/2:
			building.queue_free()

func create_building(building_id):
	var building = building_scene.instantiate()
	building.scale = Vector2(0.5, 0.5)
	building.position = Vector2(buildings_total_width + 1050/2, 500)
	buildings_total_width += 1050
	$Buildings.add_child(building)
