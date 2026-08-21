#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 pjsk_mask_ui;
extern MY_HIGHP_OR_MEDIUMP vec4 uie_details;
extern MY_HIGHP_OR_MEDIUMP number uie_scale;
extern MY_HIGHP_OR_MEDIUMP number uie_rot;

extern MY_HIGHP_OR_MEDIUMP Image mask;


vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    // Transform coords to match atlas
    vec2 uv = (screen_coords - uie_details.xy) / uie_details.zw;
    
        // evil compiler code
    if (uie_scale < uie_details.x) {
        uv.x = uv.x + 0.0001;
    }
    if (uie_rot < 0.00001) {
        uv.x = uv.x + 0.0001;
    }
    if (pjsk_mask_ui.x < 0.00001) {
        uv.x = uv.x + 0.0001;
    }
    //masking
    vec4 maskColor = colour * Texel(mask, uv).a;
    return maskColor;
}