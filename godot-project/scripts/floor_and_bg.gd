extends Node2D

@onready var floor1: Sprite2D = $Floor1
@onready var floor2: Sprite2D = $Floor2
@onready var floor3: Sprite2D = $Floor3
@onready var floor4: Sprite2D = $Floor4
@onready var floor5: Sprite2D = $Floor5
@onready var building1: Node2D = $Building1
@onready var building2: Node2D = $Building2
@onready var building3: Node2D = $Building3
@onready var building4: Node2D = $Building4

var buildings_total_width: int = 2471
var building_scene = preload("res://scenes/building.tscn")
var buildings_till_alley: int = 1
var alley_scene = preload("res://scenes/alley.tscn")
var last_building: int = 1

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
	buildings_total_width = round(buildings_total_width)
	building1.position.x -= 250 * delta
	building1.position.x = round(building1.position.x)
	building2.position.x -= 250 * delta
	building2.position.x = round(building2.position.x)
	building3.position.x -= 250 * delta
	building3.position.x = round(building3.position.x)
	building4.position.x -= 250 * delta
	building4.position.x = round(building4.position.x)
	if buildings_total_width <= 1920:
		match last_building:
			1:
				building1.position = Vector2(2273, 505)
				last_building = 2
			2:
				building2.position = Vector2(2273, 505)
				last_building = 3
			3:
				building3.position = Vector2(2273, 505)
				last_building = 4
			4:
				building4.position = Vector2(2273, 505)
				last_building = 1
		buildings_total_width = 2626
		buildings_till_alley -= 1
		 # Spawn Alley
		if buildings_till_alley == 0:
			var alley = alley_scene.instantiate()
			alley.position = Vector2(0, 644)
			buildings_total_width += 140
			alley.z_index = 1
			$Alley.add_child(alley)
			$Alley.position.x = 2719
			buildings_till_alley = randi_range(5, 7)
	 # Alley Movement
	$Alley.position.x -= 250 * delta
	$Alley.position.x = round($Alley.position.x)
	if $Alley.position.x <= -266:
		for child in $Alley.get_children():
			child.queue_free()
