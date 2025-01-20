shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 a = vec3(0.5, 0.5, 0.5);
	vec3 b = vec3(0.5, 0.5, 0.5);
	vec3 c = vec3(2.0, 1.0, 0.0);
	vec3 d = vec3(0.50, 0.20, 0.25);

	vec4 color = texture(TEXTURE, UV);

	if (color.r > 0.9 && color.g > 0.9 && color.b > 0.9) {
		color.rgb = a + b*cos( 6.283185*(c*TIME+d) );
	}

	COLOR = color;
}
