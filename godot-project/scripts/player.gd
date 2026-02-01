class_name Player extends Node2D

signal player_died
signal mask_changed(mask:String)

@export var can_die:bool = false
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const startingX = 200
const speedX = 1500

var mask = "none"
var batMaskSonar = preload("res://scenes/bat_mask_sonar_area.tscn")
var speedMaskScene = preload("res://scenes/speed_mask_property.tscn")
var candy_bar_scene:PackedScene = preload("res://scenes/candy_bar.tscn")
var maskPropertyNode

var targetX : float = startingX
var alive:bool = true

@export var lantern: Sprite2D
@export var lantern_animator: AnimationPlayer
@export var lantern_idle_pos: Vector2
var lantern_used: bool = false

func _ready() -> void:
	$Sprite.play("no mask running")
	lantern.visible = false
	lantern.position = lantern_idle_pos
	position.x = 200
	position.y = 900

func _process(_delta: float) -> void:
	if alive:
		$Sprite.position.x += sin(Time.get_ticks_msec() * 0.01) * 0.8
		position.x = lerp(position.x,targetX,0.02)
	# use arrow keys to switch mask, use same arrow key to remove mask
	if Input.is_action_just_pressed("Mask1"):
		if mask == "bat":
			SwitchMask("none")
		else:
			SwitchMask("bat")
	if Input.is_action_just_pressed("Mask2"):
		if mask == "speed":
			SwitchMask("none")
		else:
			SwitchMask("speed")
	if Input.is_action_just_pressed("Mask3"):
		if mask == "reveal":
			SwitchMask("none")
		else:
			SwitchMask("reveal")
	if Input.is_action_just_pressed("CandyBar"):
		var candy_bar:CandyBar = candy_bar_scene.instantiate()
		candy_bar.position = position - Vector2(0,150)
		get_parent().add_child(candy_bar)
	
	if mask == "speed":
		if Input.is_action_just_pressed("MaskAbility"):
			$DashSound.playing = true
			$AnimationPlayer.play("dash")
	
	if mask == "reveal":
		if Input.is_action_just_pressed("MaskAbility"):
			if lantern_used == false:
				lantern_used = true
				lantern_animator.play("use_lantern")
			else:
				lantern_used = false
				lantern_animator.play("unuse_lantern")

func SwitchMask(targetMask):
	ResetMaskProperties(mask)
	mask = targetMask
	#$DebugLabel.text = mask
	mask_changed.emit(targetMask)
	match mask:
		
		"none":
			$Sprite.animation = "no mask running"
		
		"bat":
			$Sprite.animation = "owl mask running"
			var sonarInstance = batMaskSonar.instantiate()
			get_node("EyeHeight").add_child(sonarInstance)
			maskPropertyNode = sonarInstance
					
		"speed":
			$Sprite.animation = "fox mask running"
		
		"reveal":
			$Sprite.animation = "bat mask running"
			lantern.visible = true

func ResetMaskProperties(targetMask):
	match targetMask:
		
		"none":
			pass
		
		"bat":
			maskPropertyNode.queue_free()
		
		"speed":
			pass
		
		"reveal":
			lantern.visible = false
			lantern.position = lantern_idle_pos
			lantern_used = false
	maskPropertyNode = null

func kill_player(cause_of_death:Global.WAYS_TO_DIE)-> void:
	if !can_die:
		return
	alive = false
	sprite.stop()
	animation_player.stop()
	player_died.emit()

# Replaced by kill_player()
#func Die(killer):
	#if !can_die:
		#return
	#emit_signal("player_died")
