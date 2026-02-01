class_name InputController extends Node

signal mask1_pressed
signal mask2_pressed
signal mask3_pressed
signal candy_bar_pressed
signal no_mask_pressed

signal mask1_released
signal mask2_released
signal mask3_released
signal candy_bar_released
signal no_mask_released

signal mask_ability_pressed
signal mask_ability_released

var active:bool = true


func _unhandled_input(event: InputEvent) -> void:
	if !active:
		return
	
	if (event.is_action_pressed("Mask1")):
		mask1_pressed.emit()
	elif (event.is_action_pressed("Mask2")):
		mask2_pressed.emit()
	elif (event.is_action_pressed("Mask3")):
		mask3_pressed.emit()
	elif (event.is_action_pressed("CandyBar")):
		candy_bar_pressed.emit()
	elif (event.is_action_pressed("NoMask")):
		no_mask_pressed.emit()
	elif (event.is_action_pressed("MaskAbility")):
		mask_ability_pressed.emit()
	elif (event.is_action_released("Mask1")):
		mask1_released.emit()
	elif (event.is_action_released("Mask2")):
		mask2_released.emit()
	elif (event.is_action_released("Mask3")):
		mask3_released.emit()
	elif (event.is_action_released("CandyBar")):
		candy_bar_released.emit()
	elif (event.is_action_released("NoMask")):
		no_mask_released.emit()
	elif (event.is_action_released("MaskAbility")):
		mask_ability_released.emit()
