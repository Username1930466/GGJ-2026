class_name Racoon extends Node2D

@export var area_2d: Area2D
@export var speed:int = 1
@export var racoon_pile_sprite:Texture 

@onready var sprite_2d: Sprite2D = $Visuals/Sprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	area_2d.area_entered.connect(_on_area_entered)
	area_2d.area_exited.connect(_on_area_exited)

func _on_area_entered(other_area: Area2D) -> void:
	print("Colliding with: ", other_area.name)
	var collider:Node = other_area.get_parent()
	if collider is Player:
		var player:Player = collider as Player
		
		# 50% chance to die to racoon
		if randf() > 0: #[TO-DO] set to 50/50?
			player.kill_player(Global.WAYS_TO_DIE.CHECKPOINT)
			sprite_2d.texture = racoon_pile_sprite
			scale = Vector2.ONE * 2
			position.x -= 200
			position.y += 100
			audio_stream_player.play()
			
	elif collider is CandyBar:
		queue_free()



func _on_area_exited(other_area: Area2D) -> void:
	print("Stopped colliding with: ", other_area.name)

func _process(delta: float) -> void:
	position.x -= 250 * delta * speed
	position.x = round(position.x)

func stop_movement()-> void:
	speed = 0
