extends Control

# Export variables for the menu buttons
@export var play_button: TextureButton
@export var high_scores_button: TextureButton
@export var credits_button: TextureButton
@export var exit_button: TextureButton

# Export variables for the credits panel
@export var credits: MarginContainer
@export var credits_back_button: Button

# Export variables for the High Scores Panel
@export var high_scores_panel: MarginContainer
@export var high_scores_back_button: Button
@export var center_container: CenterContainer
@export var name_label_1: RichTextLabel
@export var name_label_2: RichTextLabel
@export var name_label_3: RichTextLabel
@export var score_label_1: RichTextLabel
@export var score_label_2: RichTextLabel
@export var score_label_3: RichTextLabel

var name_labels:Array[RichTextLabel] = []
var score_labels:Array[RichTextLabel] = []


var button_scale_twen:Tween

func _ready() -> void:
	# Connect all the button pressed signals
	play_button.pressed.connect(_on_play_button_pressed)
	high_scores_button.pressed.connect(_on_high_scores_button_pressed)
	high_scores_back_button.pressed.connect(_on_high_scores_back_button_pressed)
	credits_button.pressed.connect(_on_credits_button_pressed)
	credits_back_button.pressed.connect(_on_credits_back_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)
	
	# Connect Button Mouse Entered
	play_button.mouse_entered.connect(_on_button_mouse_entered.bind(play_button))
	high_scores_button.mouse_entered.connect(_on_button_mouse_entered.bind(high_scores_button))
	credits_button.mouse_entered.connect(_on_button_mouse_entered.bind(credits_button))
	exit_button.mouse_entered.connect(_on_button_mouse_entered.bind(exit_button))

	# Connect Button Mouse Exited
	play_button.mouse_exited.connect(_on_button_mouse_exited.bind(play_button))
	high_scores_button.mouse_exited.connect(_on_button_mouse_exited.bind(high_scores_button))
	credits_button.mouse_exited.connect(_on_button_mouse_exited.bind(credits_button))
	exit_button.mouse_exited.connect(_on_button_mouse_exited.bind(exit_button))
	
	# Set highscore labels
	name_labels = [name_label_1,name_label_2, name_label_3]
	score_labels = [score_label_1,score_label_2,score_label_3]
	set_highscore_labels()

# This function runs when play is pressed
# It loads the scene for Main
func _on_play_button_pressed()-> void:
	start_new_game()

# This function runs when the credits button is pressed
# It shows the credits pannel
func _on_credits_button_pressed()-> void:
	credits.visible = true

#This function runs when the back button on the credits panel is pressed
# It hides the credits panel
func _on_credits_back_button_pressed()-> void:
	credits.visible = false

# This functions runs when the Exit button is pressed
# It closes the game
func _on_exit_button_pressed()-> void:
	get_tree().quit()

#[TO-DO] Create functionality for highscores
func _on_high_scores_button_pressed()-> void:
	high_scores_panel.visible = true
	
func _on_high_scores_back_button_pressed()-> void:
	high_scores_panel.visible = false

func start_new_game()-> void:
	#var tween:Tween = create_tween();
	#tween.tween_property(play_button,"scale",Vector2.ONE*0.8,0.4)\
	#.set_ease(Tween.EASE_OUT)\
	#.set_trans(Tween.TRANS_SPRING)
	
	#tween.tween_property(play_button,"scale",Vector2.ONE,0.2)\
	#.set_ease(Tween.EASE_OUT)\
	#.set_trans(Tween.TRANS_EXPO)
	#await tween.finished
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func set_highscore_labels()-> void:
	var high_scores:Array[Dictionary] = Global.high_scores
	for i in range(high_scores.size()):
		name_labels[i].text = high_scores[i]["name"]
		score_labels[i].text = str(high_scores[i]["score"])

func _on_button_mouse_entered(button:TextureButton)-> void:
	button_scale_twen = create_tween()
	button_scale_twen.tween_property(button,"scale",Vector2.ONE*1.1,0.4)\
	.set_ease(Tween.EASE_OUT)\
	.set_trans(Tween.TRANS_SPRING)
	

func _on_button_mouse_exited(button:TextureButton)-> void:
	button_scale_twen = create_tween()
	button_scale_twen.tween_property(button,"scale",Vector2.ONE*1,0.4)\
	.set_ease(Tween.EASE_OUT)\
	.set_trans(Tween.TRANS_SPRING)
