class_name HUD extends CanvasLayer

enum ABILITY{
	MASK1,
	MASK2,
	MASK3,
	CANDY_BAR,
	NONE,
	POWER
}

@export var score_value: RichTextLabel

@export var ability_1: TextureRect
@export var ability_input_1: TextureRect
@export var ability_2: TextureRect
@export var ability_input_2: TextureRect
@export var ability_3: TextureRect
@export var ability_input_3: TextureRect
@export var ability_4: TextureRect
@export var ability_input_4: TextureRect
@export var ability_5: TextureRect
@export var ability_input_5: TextureRect

@export var ability_1_mask_icon:Texture
@export var ability_1_ability_icon:Texture
@export var ability_2_mask_icon:Texture
@export var ability_2_ability_icon:Texture
@export var ability_3_mask_icon:Texture
@export var ability_3_ability_icon:Texture
@export var ability_4_mask_icon:Texture
@export var ability_4_ability_icon:Texture
@export var ability_5_mask_icon:Texture
@export var ability_5_ability_icon:Texture


var currently_active:ABILITY

func _ready() -> void:
	
	Global.ability_bar = get_node("HUD/AbilityBar")
	
	# Connect Signals
	pass
	
	#test
	#update_score(100)
	#currently_active = ABILITY.MASK1
	#
	#var tween:Tween = create_tween()
	#tween.tween_interval(1)
	#await  tween.finished
	#_on_ability_button_pressed(ABILITY.MASK2)
	
func get_ability_texture_rect(ability: ABILITY) -> TextureRect:
	match ability:
		ABILITY.MASK1:
			return ability_1
		ABILITY.MASK2:
			return ability_2
		ABILITY.MASK3:
			return ability_3
		ABILITY.CANDY_BAR:
			return ability_4
		ABILITY.POWER:
			return ability_5
		_:
			return null

func get_ability_input_texture(ability: ABILITY) -> TextureRect:
	match ability:
		ABILITY.MASK1:
			return ability_input_1
		ABILITY.MASK2:
			return ability_input_2
		ABILITY.MASK3:
			return ability_input_3
		ABILITY.CANDY_BAR:
			return ability_input_4
		ABILITY.POWER:
			return ability_input_5
		_:
			return null

func get_ability_texture_mask(ability:ABILITY)-> Texture:
	match ability:
		ABILITY.MASK1:
			return ability_1_mask_icon
		ABILITY.MASK2:
			return ability_2_mask_icon
		ABILITY.MASK3:
			return ability_3_mask_icon
		ABILITY.CANDY_BAR:
			return ability_4_mask_icon
		ABILITY.POWER:
			return ability_5_mask_icon
		_:
			return null

func get_ability_texture_ability(ability:ABILITY)-> Texture:
	match ability:
		ABILITY.MASK1:
			return ability_1_ability_icon
		ABILITY.MASK2:
			return ability_2_ability_icon
		ABILITY.MASK3:
			return ability_3_ability_icon
		ABILITY.CANDY_BAR:
			return ability_4_ability_icon
		ABILITY.POWER:
			return ability_5_ability_icon
		_:
			return null

func update_score(value)-> void:
	score_value.text = str(value)

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("Mask1")):
		_on_ability_button_pressed(ABILITY.MASK1)
	elif (event.is_action_pressed("Mask2")):
		_on_ability_button_pressed(ABILITY.MASK2)
	elif (event.is_action_pressed("Mask3")):
		_on_ability_button_pressed(ABILITY.MASK3)
	elif (event.is_action_pressed("CandyBar")):
		_on_ability_button_pressed(ABILITY.CANDY_BAR)
	elif (event.is_action_pressed("MaskAbility")):
		_on_ability_button_pressed(ABILITY.POWER)
	elif (event.is_action_released("Mask1")):
		_on_ability_button_released(ABILITY.MASK1)
	elif (event.is_action_released("Mask2")):
		_on_ability_button_released(ABILITY.MASK2)
	elif (event.is_action_released("Mask3")):
		_on_ability_button_released(ABILITY.MASK3)
	elif (event.is_action_released("CandyBar")):
		_on_ability_button_released(ABILITY.CANDY_BAR)
	elif (event.is_action_released("MaskAbility")):
		_on_ability_button_released(ABILITY.POWER)


func _on_mask_changed(mask:String)-> void:
	match mask:
		"bat":
			swap_mask(ABILITY.MASK1)
		"speed":
			swap_mask(ABILITY.MASK2)
		"reveal":
			swap_mask(ABILITY.MASK3)
		"none":
			swap_mask(ABILITY.NONE)


func swap_mask(ability:ABILITY)-> void:
	if (currently_active != ABILITY.NONE):
		deactivate_ability(currently_active)
	
	if (ability != ABILITY.NONE):
		var ability_texture:TextureRect = get_ability_texture_rect(ability)
		ability_texture.texture = get_ability_texture_ability(ability)
		currently_active = ability 


func deactivate_ability(ability:ABILITY)-> void:
	if ability != ABILITY.NONE:
		var ability_texture:TextureRect = get_ability_texture_rect(ability)
		ability_texture.texture = get_ability_texture_mask(ability)
		currently_active = ABILITY.NONE


func _on_ability_button_pressed(ability:ABILITY)-> void:
	var ability_input_texture:TextureRect = get_ability_input_texture(ability)
	ability_input_texture.pivot_offset_ratio = Vector2.ONE*0.5
	var tween:Tween = create_tween()
	tween.tween_property(ability_input_texture,"scale",Vector2.ONE*0.95,0.1)


func _on_ability_button_released(ability:ABILITY)-> void:
	var ability_input_texture:TextureRect = get_ability_input_texture(ability)
	ability_input_texture.pivot_offset_ratio = Vector2.ONE*0.5
	var tween:Tween = create_tween()
	tween.tween_property(ability_input_texture,"scale",Vector2.ONE,0.1)
