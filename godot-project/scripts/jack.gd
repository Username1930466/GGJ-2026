extends Node2D

@export var area_2d: Area2D
@export var speed:int = 1
@onready var player = Global.game.get_node("Player")

func _ready() -> void:
	area_2d.area_entered.connect(_on_area_entered)
	area_2d.area_exited.connect(_on_area_exited)

func _on_area_entered(other_area: Area2D) -> void:
	var collider:Node = other_area.get_parent()
	if collider is Player:
		visible = true
		var player:Player = collider as Player
		print("jack collids with player")
		if player.lantern_used:
			print("player killed jack")
			$Visuals/Sprite2D/AnimationPlayer.play("die")
			await get_tree().create_timer(0.7).timeout
		else:
			$AudioStreamPlayer2D.playing = true
			print("jack killed player")
			$Visuals/Sprite2D/AnimationPlayer.play("kill")
			await get_tree().create_timer(0.7).timeout
			player.kill_player(Global.WAYS_TO_DIE.JACK_THE_RIPPER)

func _on_area_exited(other_area: Area2D) -> void:
	print("Stopped colliding with: ", other_area.name)

func _process(delta: float) -> void:
	if !visible:
		if player.lantern_used == true:
			visible = true
			$AudioStreamPlayer2D.playing = true
	position.x -= 250 * delta * speed
	position.x = round(position.x)

func stop_movement()-> void:
	speed = 0
