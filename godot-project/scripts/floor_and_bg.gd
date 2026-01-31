extends Node2D

@onready var floor1: Sprite2D = $Floor1
@onready var floor2: Sprite2D = $Floor2
@onready var floor3: Sprite2D = $Floor3
@onready var floor4: Sprite2D = $Floor4
@onready var floor5: Sprite2D = $Floor5

var buildings_total_width: int = 0
var building_scene = preload("res://scenes/building.tscn")
var buildings_till_alley: int = 1
var alley_scene = preload("res://scenes/alley.tscn")

func _ready() -> void:
	while buildings_total_width <= 1920:
		create_building()

func _process(delta: float) -> void:
	 # Floor Movement
	floor1.position.x -= 250 * delta
	floor2.position.x -= 250 * delta
	floor3.position.x -= 250 * delta
	floor4.position.x -= 250 * delta
	floor5.position.x -= 250 * delta
	floor1.position.x = round(floor1.position.x)
	floor2.position.x = round(floor2.position.x)
	floor3.position.x = round(floor3.position.x)
	floor4.position.x = round(floor4.position.x)
	floor5.position.x = round(floor5.position.x)
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
			create_building()
			buildings_till_alley -= 1
			print(buildings_till_alley)
			if buildings_till_alley == 0:
				var alley = alley_scene.instantiate()
				alley.position = Vector2(3000, 567)
				buildings_total_width += 210
				alley.z_index = 1
				$Buildings.add_child(alley)
				buildings_till_alley = randi_range(5, 7)
	for building in $Buildings.get_children():
		building.position.x -= 250 * delta
		building.position.x = round(building.position.x)
		if building.position.x <= -1100/2:
			building.queue_free()

func create_building():
	var building = building_scene.instantiate()
	building.scale = Vector2(0.5, 0.5)
	building.position = Vector2(buildings_total_width + 1100/2, 500)
	buildings_total_width += 1100
	$Buildings.add_child(building)
