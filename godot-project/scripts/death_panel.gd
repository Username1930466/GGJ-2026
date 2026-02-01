class_name DeathPanel extends CanvasLayer

@export var score_value_label: Label
@export var death_panel: Panel
@export var retry_button: Button
@export var main_menu_button: Button

@export var name_label_1: Label
@export var name_label_2: Label
@export var name_label_3: Label
@export var score_label_1: Label
@export var score_label_2: Label
@export var score_label_3: Label

var name_labels:Array[Label]
var score_labels:Array[Label]

func _ready() -> void:
	retry_button.pressed.connect(_on_retry_pressed)
	main_menu_button.pressed.connect(_on_menu_pressed)
	name_labels = [name_label_1,name_label_2, name_label_3]
	score_labels = [score_label_1,score_label_2,score_label_3]

func show_pannel()-> void:
	set_high_scores()
	var start_pos = death_panel.position.y
	death_panel.position.y = -800
	var tween:Tween = create_tween()
	tween.tween_property(death_panel,"position:y",start_pos,0.6)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_SPRING)
	visible = true

func set_high_scores()-> void:
	var high_scores:Array[Dictionary] = Global.high_scores
	for i in range(high_scores.size()):
		name_labels[i].text = high_scores[i]["name"]
		score_labels[i].text = str(high_scores[i]["score"])

func set_score(value:int)-> void:
	score_value_label.text = str(value)

func _on_retry_pressed()-> void:
	get_tree().reload_current_scene()

func _on_menu_pressed()-> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
