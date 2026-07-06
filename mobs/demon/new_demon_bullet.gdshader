shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform vec4 ColorParameter : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float Falloff : hint_range(0, 20) = 5;
uniform sampler2D Noise_Texsture;
uniform float Midtones = 0.4;
uniform float Highlights : hint_range(0, 0.3) = 0.05;
uniform float Multiplier : hint_range(0, 20) = 1;
uniform float Aplha : hint_range(0, 1) = 1;
uniform float Roughness : hint_range(0, 1) = 0.1;
uniform float Emmision_Strength : hint_range(0, 20) = 1;
uniform float Bump_Strength : hint_range(0, 1) = 0.1;

// Новые параметры для движения текстуры
uniform float Scroll_Speed : hint_range(0.0, 5.0) = 0.2;
uniform float Scroll_Direction : hint_range(0.0, 6.28319) = 0.0; // Угол в радианах

void fragment() {
    // --- Расчет направления и смещения UV-координат ---
    // Преобразуем угол в вектор направления
    vec2 direction = vec2(cos(Scroll_Direction), sin(Scroll_Direction));
    // Смещение на основе времени и скорости
    vec2 scroll_offset = direction * TIME * Scroll_Speed;
    // ------------------------------------------------

    vec4 n_out17p0 = ColorParameter;
    float n_out28p0 = Falloff;

    float n_in95p1 = 0.001;
    float n_out95p0 = max(n_out28p0, n_in95p1);

    float n_in10p0 = 0.93;
    float n_out10p0 = pow(n_in10p0, n_out95p0);

    float n_in11p1 = -1.0;
    float n_in11p2 = 1.0;
    float n_out11p0 = fma(n_out10p0, n_in11p1, n_in11p2);

    float n_out21p0 = log(n_out11p0);

    float n_in5p3 = 1.0;
    float n_out5p0 = pow(1.0 - clamp(dot(NORMAL, VIEW), 0.0, 1.0), n_in5p3);

    // К БАЗОВЫМ UV ДОБАВЛЯЕМ СМЕЩЕНИЕ
    vec2 n_out31p0 = UV + scroll_offset;

    float n_out49p0 = 0.5;
    float n_in48p1 = 0.0;
    vec2 n_out48p0 = vec2(n_out49p0, n_in48p1);

    vec2 n_out38p0 = n_out31p0 + n_out48p0;

    float n_out41p0 = 2048.0;
    float n_in40p0 = 1.0;
    float n_out40p0 = n_in40p0 / n_out41p0;

    float n_in54p1 = 0.0;
    vec2 n_out54p0 = vec2(n_out40p0, n_in54p1);

    vec2 n_out51p0 = n_out38p0 + n_out54p0;

    vec4 n_out34p0 = texture(Noise_Texsture, n_out51p0);

    vec2 n_in46p1 = vec2(0.0, 0.0);
    vec2 n_out46p0 = n_out31p0 + n_in46p1;

    vec2 n_out52p0 = n_out46p0 + n_out54p0;

    vec4 n_out35p0 = texture(Noise_Texsture, n_out52p0);

    float n_in50p0 = 0.0;
    vec2 n_out50p0 = vec2(n_in50p0, n_out49p0);

    vec2 n_out39p0 = n_out31p0 + n_out50p0;

    vec2 n_out53p0 = n_out39p0 + n_out54p0;

    vec4 n_out36p0 = texture(Noise_Texsture, n_out53p0);

    vec3 n_out9p0 = vec3(n_out34p0.x, n_out35p0.x, n_out36p0.x);

    vec3 n_out3p0;
    {
        vec3 c = n_out9p0;
        vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
        vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
        vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
        float d = q.x - min(q.w, q.y);
        float e = 1.0e-10;
        n_out3p0 = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
    }
    float n_out3p2 = n_out3p0.g;

    float n_in4p2 = 0.5;
    float n_out4p0 = mix(n_out5p0, n_out3p2, n_in4p2);

    float n_out26p0 = Midtones;
    float n_out27p0 = Highlights;

    float n_out6p0;
    {
        float n_in6p3 = 0.0;
        float n_in6p4 = 1.0;
        float __input_range = n_out27p0 - n_out26p0;
        float __output_range = n_in6p4 - n_in6p3;
        n_out6p0 = n_in6p3 + __output_range * ((n_out4p0 - n_out26p0) / __input_range);
    }

    float n_in13p0 = 1.0;
    float n_out13p0 = min(n_in13p0, n_out6p0);

    float n_out12p0 = log(n_out13p0);

    float n_out22p0 = n_out21p0 / n_out12p0;

    float n_out15p0 = n_out22p0 * n_out6p0;

    float n_in23p1 = 0.0;
    bool n_out23p0 = n_out15p0 < n_in23p1;

    float n_in25p1 = 0.04;
    float n_out25p0 = (n_out23p0 ? 1.0 : 0.0) / n_in25p1;

    float n_out24p0 = max(n_out15p0, n_out25p0);

    float n_out30p0 = Multiplier;

    float n_out29p0 = n_out24p0 * n_out30p0;

    vec3 n_out18p0 = vec3(n_out17p0.xyz) * vec3(n_out29p0);

    float n_out92p0;
    {
        float n_in92p1 = 0.0;
        float n_in92p2 = 5.165;
        float n_in92p3 = 0.0;
        float n_in92p4 = 1.0;
        float __input_range = n_in92p2 - n_in92p1;
        float __output_range = n_in92p4 - n_in92p3;
        n_out92p0 = n_in92p3 + __output_range * ((n_out29p0 - n_in92p1) / __input_range);
    }

    float n_out94p0 = Aplha;
    float n_out93p0 = max(n_out92p0, n_out94p0);

    float n_out91p0 = Roughness;
    float n_out97p0 = Emmision_Strength;
    vec3 n_out96p0 = n_out18p0 * vec3(n_out97p0);

    // Важно: для карт нормалей используем те же смещенные UV, что и для основного цвета
    vec4 n_out55p0 = texture(Noise_Texsture, n_out38p0);
    vec4 n_out56p0 = texture(Noise_Texsture, n_out46p0);
    vec4 n_out57p0 = texture(Noise_Texsture, n_out39p0);

    vec3 n_out58p0 = vec3(n_out55p0.x, n_out56p0.x, n_out57p0.x);

    float n_in60p1 = 0.0;
    float n_out60p0 = n_out58p0.x + n_in60p1;

    float n_in44p1 = 0.0;
    float n_out44p0 = n_out9p0.x + n_in44p1;

    float n_out62p0 = min(n_out60p0, n_out44p0);
    float n_out61p0 = n_out44p0 - n_out60p0;
    float n_out63p0 = min(n_out62p0, n_out61p0);
    float n_in64p1 = 0.5;
    float n_out64p0 = n_out63p0 + n_in64p1;

    float n_out66p0 = 0.5;
    float n_out87p0 = Bump_Strength;
    float n_in89p1 = 0.001;
    float n_out89p0 = max(n_out87p0, n_in89p1);
    float n_in88p0 = 1.0;
    float n_out88p0 = n_in88p0 / n_out89p0;
    float n_in70p1 = 100.0;
    float n_out70p0 = n_out88p0 / n_in70p1;
    float n_out69p0 = n_out66p0 - n_out70p0;
    float n_out68p0 = n_out66p0 + n_out70p0;

    float n_out65p0;
    {
        float n_in65p3 = 0.0;
        float n_in65p4 = 1.0;
        float __input_range = n_out68p0 - n_out69p0;
        float __output_range = n_in65p4 - n_in65p3;
        n_out65p0 = n_in65p3 + __output_range * ((n_out64p0 - n_out69p0) / __input_range);
    }

    float n_in78p0 = 0.0;
    vec2 n_out78p0 = vec2(n_in78p0, n_out40p0);

    vec2 n_out76p0 = n_out38p0 - n_out78p0;
    vec4 n_out75p0 = texture(Noise_Texsture, n_out76p0);

    vec2 n_out73p0 = n_out46p0 - n_out78p0;
    vec4 n_out71p0 = texture(Noise_Texsture, n_out73p0);

    vec2 n_out74p0 = n_out39p0 - n_out78p0;
    vec4 n_out72p0 = texture(Noise_Texsture, n_out74p0);

    vec3 n_out77p0 = vec3(n_out75p0.x, n_out71p0.x, n_out72p0.x);

    float n_in79p1 = 0.0;
    float n_out79p0 = n_out77p0.x + n_in79p1;

    float n_out81p0 = min(n_out60p0, n_out79p0);
    float n_out80p0 = n_out79p0 - n_out60p0;
    float n_out82p0 = min(n_out81p0, n_out80p0);
    float n_in83p1 = 0.5;
    float n_out83p0 = n_out82p0 + n_in83p1;

    float n_out85p0;
    {
        float n_in85p3 = 0.0;
        float n_in85p4 = 1.0;
        float __input_range = n_out68p0 - n_out69p0;
        float __output_range = n_in85p4 - n_in85p3;
        n_out85p0 = n_in85p3 + __output_range * ((n_out83p0 - n_out69p0) / __input_range);
    }

    float n_in86p2 = 1.0;
    vec3 n_out86p0 = vec3(n_out65p0, n_out85p0, n_in86p2);

    ALBEDO = n_out18p0;
    ALPHA = n_out93p0;
    ROUGHNESS = n_out91p0;
    EMISSION = n_out96p0;
    NORMAL_MAP = n_out86p0;
}