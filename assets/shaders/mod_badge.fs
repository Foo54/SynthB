// also copied from more fluff

#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 mod_badge;
extern MY_HIGHP_OR_MEDIUMP vec4 uie_details;
extern MY_HIGHP_OR_MEDIUMP number uie_scale;
extern MY_HIGHP_OR_MEDIUMP number uie_rot;

extern MY_HIGHP_OR_MEDIUMP Image mask;

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = colour;

		//transform the coords or something I don't really know
    vec2 uv = (screen_coords - uie_details.xy) / max(uie_details.g, uie_details.a);
		uv.y *= 0.9; // slightly squish the y

		// I don't know what these do
    if (uie_scale < 0.00001) {
        uv.x = uv.x + 0.0001;
    }
    if (uie_rot < 0.00001) {
        uv.x = uv.x + 0.0001;
    }
    
		// movement
    uv.x = mod(uv.x * 5 - mod_badge.x * 3, 1);
    uv.y = mod(uv.y * 10 + 0.25 + 0.1 * sin(mod_badge.x * 22.5 * 1.5), 1);
		//idk what this does but it seems important
    if (uv.x > 1) {
        uv.x = 2 - uv.x;
    }
    if (uv.y > 1) {
        uv.y = 2 - uv.y;
    }

		//masking
		number maskColor = texture2D(mask, uv).a;
		
		vec4 outcolor = vec4(0.851, 0.255, 0.412, 1);
		outcolor += vec4(0.951, 0.355, 0.512, 1) * maskColor;

    return outcolor;
}