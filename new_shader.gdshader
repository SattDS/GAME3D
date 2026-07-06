shader_type spatial;

uniform sampler2D mask : source_color;
uniform vec3 glow_color : source_color; // The color that will glow
uniform vec3 glow_emission : source_color; // Color of the emission
uniform float glow_strength = 1.0; // Emission strength multiplier

// Scroll direction and speed (now supports X, Y, and Z)
uniform vec3 scroll_direction = vec3(0.0, 1.0, 0.0); // Default to upward scroll
uniform float scroll_speed = 1.0; // Speed of scrolling
uniform float z_scroll_intensity = 0.1; // How much Z scrolling affects UV offset

void fragment() {
    // Calculate the scrolled UVs based on X and Y direction
    vec2 scrolled_uv = UV + scroll_direction.xy * scroll_speed * TIME;

    // Apply Z scrolling effect by creating additional UV offset
    // Z scrolling can simulate depth by shifting UVs based on a sine wave or linear offset
    float z_offset = scroll_direction.z * scroll_speed * TIME * z_scroll_intensity;

    // Apply Z offset - this creates a scaling/zooming effect that simulates depth
    // You can choose different interpretations:

    // Option 1: Simple UV offset in both directions (parallax-like effect)
    // scrolled_uv += z_offset;

    // Option 2: Scale UVs from center (zoom effect for Z movement)
    vec2 centered_uv = scrolled_uv - 0.5;
    float scale_factor = 1.0 + z_offset;
    scrolled_uv = centered_uv * scale_factor + 0.5;

    vec4 albedo = texture(mask, scrolled_uv);

    // Compare the color to the glow color (tweak the threshold for precision)
    float tolerance = 0.1;
    float color_match = step(tolerance, 1.0 - distance(albedo.rgb, glow_color));

    vec3 emission = mix(vec3(0.0), glow_emission * glow_strength, color_match);

    ALBEDO = albedo.rgb;
    EMISSION = emission;
}