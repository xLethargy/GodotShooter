shader_type spatial;

uniform sampler2D uv_offset_texture: hint_default_black;
uniform vec2 uv_offset_scale = vec2(-0.2, -0.1);
uniform vec2 time_scale = vec2(0.3, 0.0);
uniform float face_distortion = 0.25;

render_mode cull_disabled;

uniform sampler2D iChannel0;
//uniform vec4 tint_colour = vec4(0.0, 0.5,0.99, 1);

void vertex() {
	vec2 base_uv_offest = UV * uv_offset_scale;
	base_uv_offest += TIME * time_scale;
	
	float noise = texture(uv_offset_texture, base_uv_offest).r;
	float texture_based_offset = noise * 2.0 - 1.0;
	texture_based_offset *= UV.x;
	
	VERTEX.z += texture_based_offset;
	
	VERTEX.x += texture_based_offset * -face_distortion;
}

void fragment() {
	vec2 p = UV;
	vec4 a = texture(iChannel0, p); 
	//* tint_colour; ADD THIS IF WANT COLOUR
	
	ALBEDO = a.xyz;
}

void light() {
	// Called for every pixel for every light affecting the material.
}
