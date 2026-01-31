extends Node2D

const bats_timer_avg: int = 10 # Swarm of Bats average time between spawns
const raccoon_timer_avg: int = 20 # Raccoon average time between spawns
const army_timer_avg: int = 60 # Army Inspection average time between spawns
const t_variation: int = 5 # maximum variation in seconds of the timers

func _ready() -> void:
	reset_timer($BatsTimer)
	reset_timer($RaccoonTimer)
	reset_timer($ArmyTimer)
	$BatsTimer.start()
	$RaccoonTimer.start()
	$ArmyTimer.start()

func reset_timer(timer):
	match timer.name:
		"BatsTimer": timer.wait_time = bats_timer_avg + randf_range(-t_variation, t_variation)
		"RaccoonTimer": timer.wait_time = raccoon_timer_avg + randf_range(-t_variation, t_variation)
		"ArmyTimer": timer.wait_time = army_timer_avg + randf_range(-t_variation, t_variation)
	
	# theres probably a better way to do this but all i can think of is using arrays/dictionarys and i feel like that would be overcomplicating things

func _on_bats_timer_timeout() -> void:
	print("bat spawn")
	reset_timer($BatsTimer)

func _on_raccoon_timer_timeout() -> void:
	print("raccoon spawn")
	reset_timer($RaccoonTimer)

func _on_army_timer_timeout() -> void:
	print("army spawn")
	reset_timer($ArmyTimer)
