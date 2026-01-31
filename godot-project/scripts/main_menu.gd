extends Control

# Export variables for the menu buttons
@export var play_button: Button
@export var high_scores_button: Button
@export var credits_button: Button
@export var exit_button: Button

# Export variables for the credits panel
@export var credits: MarginContainer
@export var credits_back_button: Button

# Export variables for the High Scores Panel
@export var high_scores: MarginContainer
@export var high_scores_back_button: Button


func _ready() -> void:
	# Connect all the button pressed signals
	play_button.pressed.connect(_on_play_button_pressed)
	high_scores_button.pressed.connect(_on_high_scores_button_pressed)
	high_scores_back_button.pressed.connect(_on_high_scores_back_button_pressed)
	credits_button.pressed.connect(_on_credits_button_pressed)
	credits_back_button.pressed.connect(_on_credits_back_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)

# This function runs when play is pressed
# It loads the scene for Main
func _on_play_button_pressed()-> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

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
	high_scores.visible = true
	
func _on_high_scores_back_button_pressed()-> void:
	high_scores.visible = false
