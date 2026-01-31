extends Node2D

func _ready() -> void:
	Global.main = self
	Global.game = $Game
