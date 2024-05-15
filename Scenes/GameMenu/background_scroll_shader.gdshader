shader_type spatial;

uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo :
        source_color,
        filter_linear_mipmap,
        repeat_enable;

uniform vec2 tiling = vec2(1.0, 1.0);
uniform vec2 offset;


void vertex() {
    UV = UV * tiling + offset * TIME / 25.0;
}

void fragment() {
    vec4 texColor = texture(texture_albedo, UV);
    ALBEDO = albedo.rgb * texColor.rgb;
    ALPHA = albedo.a * texColor.a;
}

//void light() {
    // Called for every pixel for every light affecting the material.
    // Uncomment to replace the default light processing function with this one.
//}