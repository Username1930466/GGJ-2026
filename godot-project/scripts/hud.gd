class_name HUD extends CanvasLayer

enum ABILITY{
	MASK1,
	MASK2,
	MASK3,
	CANDY_BAR,
	NO_MASK,
	NONE
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


var currently_active:ABILITY

func _ready() -> void:
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
		ABILITY.NO_MASK:
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
		ABILITY.NO_MASK:
			return ability_input_5
		_:
			return null

func update_score(value)-> void:
	score_value.text = str(value)

func _on_ability_button_pressed(ability:ABILITY)-> void:
	var ability_texture:TextureRect = get_ability_texture_rect(ability)
	var ability_input_texture:TextureRect = get_ability_input_texture(ability)
	ability_texture.modulate = Color.RED
	ability_input_texture.modulate = Color.BLUE
	if ability == ABILITY.CANDY_BAR:
		var tween:Tween = create_tween()
		tween.tween_interval(0.5)
		await tween.finished
		ability_texture.modulate = Color.WHITE
	else:
		swap_mask(ability)

func swap_mask(ability:ABILITY)-> void:
	if (currently_active != ABILITY.NONE):
		deactivate_ability(currently_active)
	
	currently_active = ability 

func deactivate_ability(ability:ABILITY)-> void:
	if ability != ABILITY.NONE:
		var ability_texture:TextureRect = get_ability_texture_rect(ability)
		ability_texture.modulate = Color.WHITE
		currently_active = ABILITY.NONE

func _on_ability_button_released(ability:ABILITY)-> void:
	var ability_input_texture:TextureRect = get_ability_input_texture(ability)
	ability_input_texture.modulate = Color.WHITE
