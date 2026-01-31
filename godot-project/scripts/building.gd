extends Node2D

var top1: bool = true
var top2: bool = true

func _ready() -> void:
	for part in get_children():
		if part.name == "VicHouseBase01":
			continue
		if randi_range(0, 1) == 0:
			if part.name == "TopWindow01":
				top1 = false
			if part.name == "TopWindow02":
				top2 = false
			part.queue_free()
	if top1:
		for part in $TopWindow01.get_children():
			if randi_range(0, 1) == 0:
				part.queue_free()
	if top2:
		for part in $TopWindow02.get_children():
			if randi_range(0, 1) == 0:
				part.queue_free()
