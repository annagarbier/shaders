// Adapted from @patriciogv, Simple Voronoi
// Added color control

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float random1 (in vec2 _st) {
    return fract(sin(dot(_st.xy,
                         vec2(-0.160,0.690)))*
        43758.5453123);
}

vec2 random2( vec2 p ) {
    return fract(sin(vec2(dot(p,vec2(127.1,311.7)),dot(p,vec2(269.5,183.3))))*43758.5453);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
    vec3 color = vec3(1.);

    // Scale
    st *= 2.;

    // Tile the space
    vec2 i_st = floor(st);
    vec2 f_st = fract(st);

    float m_dist = 20.;  // minimun distance
    vec2 m_point;        // minimum point

    for (int j=-1; j<=1; j++ ) {
        for (int i=-1; i<=1; i++ ) {
            vec2 neighbor = vec2(float(i),float(j));
            vec2 point = random2(i_st + neighbor);
            point = 0.5 + 0.5*sin(u_time * .5 + 6.2831*point);
            vec2 diff = neighbor + point - f_st;
            float dist = length(diff);

            if( dist < m_dist ) {
                m_dist = dist;
                m_point = point;
            }
        }
    }

    // Assign a color from the set
    if (distance(m_point, vec2(.0,.0)) < .33) {
        color = vec3(0.214,0.568,0.985);
    } else if (distance(m_point, vec2(.0,.0)) < .66) {
        color = vec3(0.985,0.526,0.063);
    } else if (distance(m_point, vec2(.0,.0)) < 1.) {
        color = vec3(0.985,0.206,0.924);
    }

    // Add distance field to closest point center
    color.g = m_dist;

    // Show isolines
    // color -= abs(sin(40.0*m_dist))*0.07;

    // Draw cell center
    // color += 1.-step(.05, m_dist);

    // Draw grid
    // color.r += step(.98, f_st.x) + step(.98, f_st.y);
    
    // vec3 r = vec3(random1(gl_FragCoord.xy * 0.0001));
    vec3 c = vec3(color);
    
    // gl_FragColor = vec4(max(r, c), 1.0);
     gl_FragColor = vec4(c, 1.);
}
