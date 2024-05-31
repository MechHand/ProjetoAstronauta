shader_type spatial;

uniform float speed : hint_range(0.0, 10.0) = 10.0;
uniform float min_opacity : hint_range(0.0, 4.0) = 1.0;
uniform float max_opacity : hint_range(0.0, 4.0) = 2.0;

void fragment() {
    vec3 albedo_color;
	albedo_color.r = 0.0;
	albedo_color.g = 1.0;
	albedo_color.b = 0.0;
	
    float opacity = mix(min_opacity, max_opacity, abs(sin(TIME * speed)));
    albedo_color.g *= opacity;
    ALBEDO = albedo_color.rgb;
    ALPHA = albedo_color.g;
}
