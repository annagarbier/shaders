// Static gradient

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float rand (in vec2 _st) {
    return fract(sin(dot(_st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}
void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    float r = rand(gl_FragCoord.xy * 0.001);
    st.x *= u_resolution.x/u_resolution.y;
    vec3 color = vec3(0.);
    color = vec3(st.x, st.y, abs(sin(u_time)));
    
    // Toggle min/max for slightly different looks
    // gl_FragColor = vec4(min(vec3(r) ,color), 1.0); // black static
    gl_FragColor = vec4(max(vec3(r) ,color), 1.0); // white static
}
