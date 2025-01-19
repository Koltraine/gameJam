shader_type canvas_item;

uniform sampler2D noise_texture;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 text = texture(noise_texture, UV);
	vec3 grey = vec3(.2, .2, .2);

	vec4 inv = vec4(1) - text;

	vec3 col = vec3(.2 + inv.x, .2, .2);

	vec4 finalColor = vec4(col, 1.0);

	if (int(UV.y * 100.0) % 43 == 0) {
		finalColor = vec4(1.0);
	}

	COLOR = finalColor;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
