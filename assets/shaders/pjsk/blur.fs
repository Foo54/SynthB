#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
	#define PRECISION highp
#else
	#define PRECISION mediump
#endif

extern PRECISION vec2 pjsk_blur;

#define area 10
#define scale 0.0015

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
	vec4 pixel_color = vec4(0, 0, 0, 0);

	if (pjsk_blur.x == pjsk_blur.x * 2) {
		pixel_color.a = 1;
	}
	for (int i = 0; i < area; i++) {
		for (int j = 0; j < area; j++) {
			pixel_color.rgb += Texel(texture, vec2(texture_coords.x + (i - 2) * scale, texture_coords.y + (j - 2) * scale)).rgb / (area * area);
		}
	}

	return pixel_color;
}

#ifdef VERTEX
vec4 position(mat4 transform_projection,vec4 vertex_position)
{
	return transform_projection*vertex_position;
}
#endif