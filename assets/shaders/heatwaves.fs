#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
	#define PRECISION highp
#else
	#define PRECISION mediump
#endif

extern PRECISION vec2 heatwaves;

extern PRECISION number time;
extern PRECISION number temp;

#define PI 3.14159

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
		number y_change = 0.01 * sin(100 / temp * (texture_coords.y) + heatwaves.y * 0 + time) * temp;

    vec4 pixel_color = Texel(texture, vec2(texture_coords.x, texture_coords.y + y_change));

    return pixel_color;
}

#ifdef VERTEX
vec4 position(mat4 transform_projection,vec4 vertex_position)
{
    return transform_projection*vertex_position;
}
#endif