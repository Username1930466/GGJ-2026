extends Node2D

@onready var player = get_parent().get_node("Player")
@export var speed = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ActivateAnim.play("activate")
	await get_tree().create_timer(10).timeout
	queue_free()

func _process(delta: float) -> void:
	position.x -= 250 * delta * speed
	position.x = round(position.x)


func _on_kill_timer_timeout() -> void:
	if abs(player.position.x - position.x) < 20:
		player.Die("Sewer")

func stop_movement()-> void:
	speed = 0
