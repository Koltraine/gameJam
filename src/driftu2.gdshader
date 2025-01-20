shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;


float random( vec2 p )
{
    vec2 K1 = vec2(
        23.14069263277926, // e^pi (Gelfond's constant)
         2.665144142690225 // 2^sqrt(2) (Gelfondâ€“Schneider constant)
    );
    return fract( cos( dot(p,K1) ) * 12345.6789 );
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 finalColor = texture(SCREEN_TEXTURE, SCREEN_UV);

	vec2 centered = SCREEN_UV - vec2(.5);


	vec2 scaled = centered * vec2(150);
	vec2 grouped = floor(scaled);

	vec2 local = (scaled - grouped) * PI * 2.;

	vec2 tpm = vec2(grouped	.x, TIME);

	float height = clamp(cos(scaled.x + TIME) + sin(2.*scaled.x + TIME) + cos(3.*scaled.x + TIME) + sin(4.*scaled.x + TIME) + cos(5.*scaled.x + TIME) + sin(6.*scaled.x + TIME) + cos(7.*scaled.x + TIME) + sin(8.*scaled.x + TIME), 0.0, 1.0);

	if (centered.y - height < -0.40) {
		finalColor.rgb += vec3(0,0,1);
	}

	COLOR = finalColor;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
