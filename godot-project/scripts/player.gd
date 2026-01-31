class_name Player extends Node2D

signal player_died

var mask = "none"
var batMaskSonar = preload("res://scenes/bat_mask_sonar_area.tscn")
var maskPropertyNode

func _ready() -> void:
	$Sprite.play("running")

func _process(_delta: float) -> void:
	$Sprite.position.x += sin(Time.get_ticks_msec() * 0.01) * 0.8
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


func SwitchMask(targetMask):
	ResetMaskProperties(mask)
	mask = targetMask
	$DebugLabel.text = mask
	
	# bring ability bar into context
	var ability1_node = null
	var ability2_node = null
	var ability3_node = null
	if Global.ability_bar:
		ability1_node = Global.ability_bar.get_node("HBoxContainer/Ability1")
		ability2_node = Global.ability_bar.get_node("HBoxContainer/Ability2")
		ability3_node = Global.ability_bar.get_node("HBoxContainer/Ability3")
	
	match mask:
		
		"none":
			ability1_node.texture = load("res://art/ui/Bat_Mask_Button.png")
			ability2_node.texture = load("res://art/ui/Speed_Mask_Button.png")
			ability3_node.texture = load("res://art/ui/Revealing_Mask_Button.png")
			pass
		
		"bat":
			var sonarInstance = batMaskSonar.instantiate()
			get_node("EyeHeight").add_child(sonarInstance)
			maskPropertyNode = sonarInstance
			ability1_node.texture = load("res://art/ui/Sonar_Blast_Button.png")
			ability2_node.texture = load("res://art/ui/Speed_Mask_Button.png")
			ability3_node.texture = load("res://art/ui/Revealing_Mask_Button.png")
			
		
		"speed":
			ability1_node.texture = load("res://art/ui/Bat_Mask_Button.png")
			ability2_node.texture = load("res://art/ui/Dash_Button.png")
			ability3_node.texture = load("res://art/ui/Revealing_Mask_Button.png")
			
			pass
		
		"reveal":
			ability1_node.texture = load("res://art/ui/Bat_Mask_Button.png")
			ability2_node.texture = load("res://art/ui/Speed_Mask_Button.png")
			
			ability3_node.texture = load("res://art/ui/Hand_Lantern_Button.png")
			pass

func ResetMaskProperties(targetMask):
	match targetMask:
		
		"none":
			pass
		
		"bat":
			maskPropertyNode.queue_free()
		
		"speed":
			pass
		
		"reveal":
			pass
	maskPropertyNode = null
