extends Node2D

signal alley_spawned

@onready var floor1: Sprite2D = $Floor1
@onready var floor2: Sprite2D = $Floor2
@onready var floor3: Sprite2D = $Floor3
@onready var floor4: Sprite2D = $Floor4
@onready var floor5: Sprite2D = $Floor5
@onready var building1: Node2D = $Building1
@onready var building2: Node2D = $Building2
@onready var building3: Node2D = $Building3
@onready var building4: Node2D = $Building4

var building_width = null
var floor_width = null
var building_left_edge_threshold = -350
var building_scene = preload("res://scenes/building.tscn")
var buildings_till_alley: int = 7
var alley_scene = preload("res://scenes/alley.tscn")
var alley_width = 250
var last_building: int = 1
var speed: int = 250
var building_in_pos: int = 2480


func _ready() -> void:
	building_width = building1.get_node("VicHouseBase01").texture.get_width() * building1.scale.x
	floor_width = floor1.texture.get_width() * floor1.scale.x

func _process(delta: float) -> void:
	_update_ground(delta)
	
	# Building Movement
	building1.position.x -= speed * delta
	building1.position.x = round(building1.position.x)
	building2.position.x -= speed * delta
	building2.position.x = round(building2.position.x)
	building3.position.x -= speed * delta
	building3.position.x = round(building3.position.x)
	building4.position.x -= speed * delta
	building4.position.x = round(building4.position.x)

	#if buildings_total_width <= 1920:
	
	if building1.position.x < building_left_edge_threshold:
		building1.position.x = building_in_pos
		buildings_till_alley -= 1
	if building2.position.x < building_left_edge_threshold:
		building2.position.x = building_in_pos
		buildings_till_alley -= 1

	if building3.position.x < building_left_edge_threshold:
		building3.position.x = building_in_pos
		buildings_till_alley -= 1
	
	if building4.position.x < building_left_edge_threshold:
		building4.position.x = building_in_pos
		buildings_till_alley -= 1

	 # Spawn Alley
	#print(alley_width)
	if buildings_till_alley == 0:
		#print (buildings_till_alley)
		var alley = alley_scene.instantiate()
		alley.position = Vector2(0, 644)
		alley.z_index = 1
		$Alley.add_child(alley)
		$Alley.position.x = 2719
		alley_spawned.emit($Alley.position)
		
		if building1.position.x >= $Alley.position.x:
			building1.position.x += alley_width
	
		if building2.position.x >= $Alley.position.x:
			building2.position.x += alley_width
	
		if building3.position.x >= $Alley.position.x:
			building3.position.x += alley_width
	
		if building4.position.x >= $Alley.position.x:
			building4.position.x += alley_width
		
		buildings_till_alley = randi_range(5, 7)

		

	# Alley Movement
	$Alley.position.x -= speed * delta
	$Alley.position.x = round($Alley.position.x)
	if $Alley.position.x <= -266:
		for child in $Alley.get_children():
			child.queue_free()
			
func _on_death() -> void:
	speed = 0
	
func _update_ground(delta: float) -> void:
	 # Floor Movement
	floor1.position.x -= speed * delta
	floor2.position.x -= speed * delta
	floor3.position.x -= speed * delta
	floor4.position.x -= speed * delta
	floor5.position.x -= speed * delta
	floor1.position.x = round(floor1.position.x)
	floor2.position.x = round(floor2.position.x)
	floor3.position.x = round(floor3.position.x)
	floor4.position.x = round(floor4.position.x)
	floor5.position.x = round(floor5.position.x)

	#if floor1.position.x <= -960:
	var left_screen_edge = -(get_viewport().get_visible_rect().size.x / 2)
	if floor1.position.x < left_screen_edge:
		floor1.position.x = 2880
	if floor2.position.x < left_screen_edge:
		floor2.position.x = 2880
	if floor3.position.x < left_screen_edge:
		floor3.position.x = 2880
	if floor4.position.x < left_screen_edge:
		floor4.position.x = 2880
	if floor5.position.x < left_screen_edge:
		floor5.position.x = 2880
