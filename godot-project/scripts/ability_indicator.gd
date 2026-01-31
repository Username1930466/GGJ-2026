class_name AbilityIndicator extends TextureRect
@export var selected_shader: ShaderMaterial

var is_selected: bool = false

func _ready() -> void:
	if not selected_shader:
		selected_shader = ShaderMaterial.new()
		selected_shader.shader = preload("res://shaders/ability_highlight.gdshader")
	
	# Calculate aspect from the TextureRect size
	selected_shader.set_shader_parameter("aspect_ratio", size.y / size.x)
	
	selected_shader.set_shader_parameter("speed", 2.0)
	selected_shader.set_shader_parameter("glow_size", 8.0)
	selected_shader.set_shader_parameter("brightness", 2.0)
	selected_shader.set_shader_parameter("glow_color", Color(1.0, 0.9, 0.5, 1.0))
	selected_shader.set_shader_parameter("sparkle_count", 4)

func set_selected(selected: bool) -> void:
	is_selected = selected
	if is_selected:
		material = selected_shader
	else:
		material = null
