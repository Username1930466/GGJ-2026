shader_type canvas_item;

uniform float speed = 2.0;
uniform float glow_size = 8.0;
uniform float brightness = 2.0;
uniform vec4 glow_color: source_color = vec4(1.0, 0.9, 0.5, 1.0);
uniform int sparkle_count = 4;
uniform float aspect_ratio = 1.0;

// Takes a value 0.0-1.0 and returns a position along the rectangle edges
vec2 rect_perimeter(float t) {
	float w = 1.0;
	float h = aspect_ratio;
	float perimeter = 2.0 * w + 2.0 * h;
	float dist = t * perimeter;
	
	// Half sizes match the scaled UV space
	float half_w = 0.5;
	float half_h = 0.5 * aspect_ratio;
	
	vec2 pos;
	
	// Top edge (left to right)
	if (dist < w) {
		pos = vec2(-half_w + dist, half_h);
	}
	// Right edge (top to bottom)
	else if (dist < w + h) {
		pos = vec2(half_w, half_h - (dist - w));
	}
	// Bottom edge (right to left)
	else if (dist < 2.0 * w + h) {
		pos = vec2(half_w - (dist - w - h), -half_h);
	}
	// Left edge (bottom to top)
	else {
		pos = vec2(-half_w, -half_h + (dist - 2.0 * w - h));
	}
	
	return pos;
}

void fragment() {
	vec4 base_color = texture(TEXTURE, UV);
	vec2 uv = UV * 2.0 - 1.0;
	// Scale UV by aspect so the rectangle matches properly
	uv.y *= aspect_ratio;
	
	float glow = 0.0;
	
	for (int i = 0; i < sparkle_count; i++) {
		// Spread sparkles evenly around the perimeter
		float offset = float(i) / float(sparkle_count);
		// t wraps 0.0-1.0 around the full perimeter
		float t = fract(TIME * speed * 0.1 + offset);
		
		// Get position along rectangle edge
		vec2 sparkle_pos = rect_perimeter(t);
		
		// Distance from pixel to the sparkle
		float dist = length(uv - sparkle_pos);
		
		// Glow falloff
		float sparkle_glow = smoothstep(glow_size * 0.02, 0.0, dist);
		glow += sparkle_glow;
	}
	
	// Apply glow color and brightness
	vec4 glow_effect = glow_color * glow * brightness;
	if (glow <= 0.0) {
		discard;
	}
	
	// Combine base texture with glow
	COLOR = base_color + glow_effect * (1.0 - base_color.a * 0.5);
	COLOR.a = max(base_color.a, glow * glow_color.a);
}