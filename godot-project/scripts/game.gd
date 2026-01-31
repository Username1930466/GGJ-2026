extends Node2D

signal score_changed(value:int)

@export var hud: HUD
@export var player: Player


var is_playing:bool = false
var current_score:int = 0:
	set(value):
		score_changed.emit(value)
		current_score = value



func _ready() -> void:
	# Connect Signals
	score_changed.connect(hud.update_score)
	player.player_died.connect(_on_player_died)
	
	
	is_playing = true
	

func _process(delta: float) -> void:
	if is_playing:
		current_score += 1

func _on_player_died()-> void:
	is_playing = false
	
	#[TO-DO] call stop on the enemy spawners and the floor movement script
	#[TO-DO] display a death screen with the score and potential highscore?
