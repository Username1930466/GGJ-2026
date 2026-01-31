extends Node

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
