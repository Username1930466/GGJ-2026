extends AnimatedSprite2D

const sin_min_speed = 0.009
const sin_max_speed = 0.011

var sinAmp = 1.7
var cosAmp = 2

var sinSpeed
var cosSpeed

func _ready() -> void:
	sinSpeed = randf_range(sin_min_speed,sin_max_speed)
	cosSpeed = randf_range(sin_min_speed,sin_max_speed)

func _process(delta: float) -> void:
	position.x += sin(Time.get_ticks_msec() * sinSpeed) * sinAmp
	position.y += cos(Time.get_ticks_msec() * cosSpeed) * cosAmp
	
func Disperse():
	sinAmp = 20
	cosAmp = 20
