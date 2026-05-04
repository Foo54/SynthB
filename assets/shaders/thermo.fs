// also copied from more fluff

#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 thermo;
extern MY_HIGHP_OR_MEDIUMP vec4 uie_details;
extern MY_HIGHP_OR_MEDIUMP number uie_scale;
extern MY_HIGHP_OR_MEDIUMP number uie_rot;

extern MY_HIGHP_OR_MEDIUMP number temp;

vec4 lerp(vec4 colour1, vec4 colour2, number val) {
	return vec4(
		colour1.r + (colour2.r - colour1.r) * val,
		colour1.g + (colour2.g - colour1.g) * val,
		colour1.b + (colour2.b - colour1.b) * val,
		colour1.a + (colour2.a - colour1.a) * val);
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords ) {

		//transform the coords or something I don't really know
    vec2 uv = (screen_coords - uie_details.xy) / max(uie_details.g - 2, uie_details.a - 2);

		// I don't know what these do
    if (uie_scale < 0.00001) {
        uv.x = uv.x + 0.0001;
    }
    if (uie_rot < 0.00001) {
        uv.x = uv.x + 0.0001;
    }

    vec4 tex = texture2D(texture, texture_coords);

    return lerp(tex, vec4(0.8, 0.5, 0.1, tex.a), temp * 0.2 + thermo.x * 0);
}