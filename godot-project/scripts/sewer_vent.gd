extends Node2D

@onready var player = get_parent().get_node("Player")
@export var speed = 1

@onready var belchScene = preload("res://scenes/belch.tscn")


func _ready() -> void:
	$ActivateAnim.play("activate")

func _process(delta: float) -> void:
	position.x -= 250 * delta * speed
	position.x = round(position.x)
	if position.x < -1000:
		queue_free()


func _on_kill_timer_timeout() -> void:
	var belchInstance = belchScene.instantiate()
	add_child(belchInstance)

func stop_movement()-> void:
	speed = 0
