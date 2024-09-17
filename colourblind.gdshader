
shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec4 tex = texture(SCREEN_TEXTURE, SCREEN_UV);  // Fetch the pixel color from the screen
    float gray = (tex.r * 0.299) + (tex.g * 0.587) + (tex.b * 0.114);  // Weighted grayscale calculation
    COLOR = vec4(gray, gray, gray, tex.a);  // Apply grayscale and keep the original alpha
}
