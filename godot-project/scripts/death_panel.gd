extends CanvasLayer

@onready var retry_button: Button = %RetryButton
@onready var main_menu_button: Button = %MainMenuButton

func _ready() -> void:
	retry_button.pressed.connect(_on_retry_pressed)
	main_menu_button.pressed.connect(_on_menu_pressed)

func _on_retry_pressed()-> void:
	get_tree().reload_current_scene()

func _on_menu_pressed()-> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
