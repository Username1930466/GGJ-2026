extends Node

signal game_started
signal game_restarted
signal game_ended

enum WAYS_TO_DIE{
	BATS,
	JACK_THE_RIPPER,
	MIASMA,
	RACOON,
	CHECKPOINT
}

var main: Node2D
var game: Node2D

# Stores the high scores
var high_scores:Array[Dictionary] = [{"name":"Empty", "score":0},{"name":"Empty", "score":0},{"name":"Empty", "score":0}]

var ability_bar = null

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
