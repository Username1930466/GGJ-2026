extends Node2D

signal score_changed(value:int)

@export var hud: HUD
@export var player: Player
@export var input_controller: InputController


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
	
	is_playing = true
	
	#Connect signals for Input Controller / Hud
	
	#Might not need this code if we connect directly to player! Or could just be used for the control indicator
	
	#input_controller.mask1_pressed.connect(hud._on_ability_button_pressed.bind(HUD.ABILITY.MASK1))
	#input_controller.mask2_pressed.connect(hud._on_ability_button_pressed.bind(HUD.ABILITY.MASK2))
	#input_controller.mask3_pressed.connect(hud._on_ability_button_pressed.bind(HUD.ABILITY.MASK3))
	#input_controller.candy_bar_pressed.connect(hud._on_ability_button_pressed.bind(HUD.ABILITY.CANDY_BAR))
	#input_controller.no_mask_pressed.connect(hud._on_ability_button_pressed.bind(HUD.ABILITY.NO_MASK))
	#
	#input_controller.mask1_released.connect(hud._on_ability_button_released.bind(HUD.ABILITY.MASK1))
	#input_controller.mask2_released.connect(hud._on_ability_button_released.bind(HUD.ABILITY.MASK2))
	#input_controller.mask3_released.connect(hud._on_ability_button_released.bind(HUD.ABILITY.MASK3))
	#input_controller.candy_bar_released.connect(hud._on_ability_button_released.bind(HUD.ABILITY.CANDY_BAR))
	#input_controller.no_mask_released.connect(hud._on_ability_button_released.bind(HUD.ABILITY.NO_MASK))
	
	
	

func _process(_delta: float) -> void:
	if is_playing:
		current_score += 1

func _on_player_died()-> void:
	is_playing = false
	
	#[TO-DO] call stop on the enemy spawners and the floor movement script
	#[TO-DO] display a death screen with the score and potential highscore?
	check_for_high_score()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

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
