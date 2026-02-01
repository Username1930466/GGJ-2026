extends Node2D

signal score_changed(value:int)
signal stop_movement

@export var hud: HUD
@export var player: Player
@export var input_controller: InputController
@onready var death_panel: CanvasLayer = $DeathPanel

@onready var floor_and_bg: Node2D = $"Floor & BG"
@onready var enemy_spawner: EnemySpawner = $EnemySpawner



var is_playing:bool = false
var current_score:int = 0:
	set(value):
		score_changed.emit(value)
		current_score = value



func _ready() -> void:
	# Connect Signals
	score_changed.connect(hud.update_score)
	player.player_died.connect(_on_player_died)
	player.mask_changed.connect(hud._on_mask_changed)
	enemy_spawner.enemy_spawned.connect(_on_encounter_spawned)
	player.player_died.connect(enemy_spawner.stop_all_timers)
	stop_movement.connect(floor_and_bg._on_death)
	
	is_playing = true


func _process(_delta: float) -> void:
	if is_playing:
		current_score += 1

func _on_player_died()-> void:
	is_playing = false
	
	#[TO-DO] call stop on the enemy spawners and the floor movement script
	#[TO-DO] display a death screen with the score and potential highscore?
	check_for_high_score()
	Global.game_ended.emit()
	stop_movement.emit()
	death_panel.visible = true
	#get_tree().change_scene_to_file.call_deferred("res://scenes/main_menu.tscn")

func check_for_high_score() -> void:
	# High scores are formatted as [{"name": "Alice", "score": 1000}, etc.]
	var high_scores: Array[Dictionary] = Global.high_scores
	
	# Check if the score beats any high scores and 
	for i in range(high_scores.size()):
		if current_score > high_scores[i]["score"]:
			
			# [TO-DO] add a way to get the player name
			var player_name: String = "Unkown"
			
			# Insert the new score
			high_scores.insert(i, {"name": player_name, "score": current_score})
			
			# Remove the last entry to keep the list size
			if high_scores.size() > 3:  #Set for 3 high scores at the moment
				high_scores.pop_back()
			
			# Update the global scores
			Global.high_scores = high_scores
			break

func _on_encounter_spawned(scene:Node)-> void:
	stop_movement.connect(scene.stop_movement)
