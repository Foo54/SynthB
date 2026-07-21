#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
	#define PRECISION highp
#else
	#define PRECISION mediump
#endif

// Look ionized.fs for explanation
extern PRECISION vec2 miku;

extern PRECISION vec4 color_;
extern PRECISION Image mask;

extern PRECISION number dissolve;
extern PRECISION number time;
// (sprite_pos_x, sprite_pos_y, sprite_width, sprite_height) [not normalized]
extern PRECISION vec4 texture_details;
// (width, height) for atlas texture [not normalized]
extern PRECISION vec2 image_details;
extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, shadow ? tex.a*0.3: tex.a);
    }

    float adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01; //Adjusting 0.0-1.0 to fall to -0.1 - 1.1 scale so the mask does not pause at extreme values

	float t = time * 10.0 + 2003.;
	vec2 floored_uv = (floor((uv*texture_details.ba)))/max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);
	
	vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 143.6340), cos(-t / 99.4324));
	vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 53.1532),  cos( t / 61.4532));
	vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1.+ (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;
    vec2 borders = vec2(0.2, 0.8);

    float res = (.5 + .5* cos( (adjusted_dissolve) / 82.612 + ( field + -.5 ) *3.14))
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y)*(5. + 5.*dissolve) : 0.)*(dissolve);

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a*0.3: tex.a) : .0);
}

#define BLUE vec4(0.4254901960784314, 0.707843137254902, 0.696078431372549, tex.a)
#define ITERATIONS 3
#define LIMIT 0.1

// from AlexZGreat
vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.5453123);
}

// Gradient Noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/XdXGW8
float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( random2(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                     dot( random2(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( random2(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                     dot( random2(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

// This is what actually changes the look of card
vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = Texel( texture, texture_coords);
    vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba - texture_details.ba / 2)/min(texture_details.b, texture_details.a);

    number y = miku.y;
    number x = miku.x;

    vec2 uv2 = uv;
    uv2.x += y / 20 + x / 40;
    uv2.y += y / 20 + x / 40;

    number theta = sin(x * 2 + y) * 3.14 / 4 - (3.14 * 2);
    number mod_ = 0.3;
    
    uv2 = mod(uv2, mod_) * 10 / 3;
    number x_ = uv2.x;

    uv2.x = (uv2.x - 0.5) * cos(theta) - (uv2.y - 0.5) * sin(theta) + 0.5;
    uv2.y = (x_ - 0.5) * sin(theta) + (uv2.y - 0.5) * cos(theta) + 0.5;

    uv2 = mod(uv2, 1);
    number mask_color = Texel(mask, uv2).a;
    if (step(mask_color, 0.1) != 1) {
        if (x == x * 2) {
            tex.a = 0;
        }

        vec4 color = color_;
        color.a = tex.a;
        vec2 coords = vec2(uv.x + y / 40, uv.y+ y / 40 + x / 5) * 10;
        tex = mix(tex, color, (0.6 + noise(coords)) * 4 / 3 * distance(uv, vec2(0, 0)));
    }

    return dissolve_mask(tex, texture_coords, uv);

    
    // number offset = mod((miku.y / 5), 2);
    // number dist = mod(abs(distance(vec2(0, 0), uv) - offset), 1.414 / 8);
    // tex = mix(tex, BLUE, 20 * (0.05 - abs(0.05 - dist)) * (step(dist, 1.414)));

    // this is completely unrelated to the shader I was screwing around
    // number _time = miku.y;
    // number time_mods[ITERATIONS] = number[ITERATIONS](1, -3, 4);
    // number amplitudes[ITERATIONS] = number[ITERATIONS](0.2, 0.15, 0.1);
    // for (int i = 0; i < ITERATIONS; i = i + 1) {
    //     vec2 offset = vec2(
    //         amplitudes[i] * 0.05 * cos(_time * time_mods[i]),
    //         amplitudes[i] * 0.05 * sin(_time * time_mods[i])
    //     );
    //     vec2 coords = texture_coords + offset;
    //     if (coords.x >= 0 && coords.x <= 0.1 && coords.y >= 0 && coords.y <= 0.063) {
    //         vec4 tex2 = Texel(texture, coords);
    //         tex2.a = tex2.a * 0.5;
    //         number a = tex2.a;
    //         tex2 = tex2 * tex2.a;
    //         tex2.a = a;
    //         number epsilon = 0.99 * tex2.a;
    //         if (tex2.r < epsilon || tex2.g < epsilon || tex2.b < epsilon) {
    //             number _a = tex.a;
    //             tex = tex * 0.5 + tex2;
    //             tex.a = _a + tex2.a;
    //         }
    //     }
    // }

    // number offsets[5] = number[5](0.5, 1, 1.5, 2, 2.5);
    // for (int i = 0; i < 1; i += 1) {
    //     number offset = max(0, abs(-miku.x + 0.5));//-pow(0.9, mod((offsets[i] + miku.y / 2), 1.414/2) * 100) / 10;
    //     number dist = (distance(vec2(0, 0), uv) - offset * 2);
    //     tex = mix(tex, BLUE, max(0, 10 * (dist + 0.3)));
    // }
}

// for transforming the card while your mouse is on it
extern PRECISION vec2 mouse_screen_pos;
extern PRECISION float hovering;
extern PRECISION float screen_scale;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2. -mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif