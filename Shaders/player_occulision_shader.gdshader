shader_type spatial;

uniform sampler2D screen_depth_texture : hint_screen_texture;
uniform vec3 visible_color = vec3(0.0, 1.0, 0.0);
uniform vec3 occluded_color = vec3(1.0, 0.0, 0.0);

varying float clip_space_depth;

void vertex() {
    vec4 clip_pos = PROJECTION_MATRIX * VIEW_MATRIX * vec4(VERTEX, 1.0);
    clip_space_depth = clip_pos.z / clip_pos.w;
}

void fragment() {
    float scene_depth = texture(screen_depth_texture, SCREEN_UV).r;
    float ndc_depth = scene_depth * 2.0 - 1.0;

    if (clip_space_depth < ndc_depth) {
        ALBEDO = occluded_color;
        EMISSION = occluded_color * 2.0;
        ALPHA = 0.8;
    } else {
        ALBEDO = visible_color;
        EMISSION = vec3(0.0);
        ALPHA = 1.0;
    }
}