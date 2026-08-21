#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 pjsk_phone_inside;
extern MY_HIGHP_OR_MEDIUMP vec4 uie_details;
extern MY_HIGHP_OR_MEDIUMP number uie_scale;
extern MY_HIGHP_OR_MEDIUMP number uie_rot;

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{

    vec2 uv = (screen_coords - uie_details.xy) / uie_details.ga;
    if (uie_scale < 0.00001) {
        uv.x = uv.x + 0.0001;
    }
    if (uie_rot < 0.00001) {
        uv.x = uv.x + 0.0001;
    }
    if (pjsk_phone_inside.x == pjsk_phone_inside.x * 2) {
        uv.x = uv.x + 0.0001;
    }
    
    vec4 o = mix(vec4(0.48, 0.48, 0.60, 1), vec4(0.36, 0.36, 0.48, 1), max(0, min(1, (uv.x / 2 + uv.y) / 1.5)));

    return o;
}