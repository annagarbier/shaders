// Adds static to https://github.com/Nedelstein/dt-thesis-site-gradient/blob/master/blobs.glsl

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
// uniform vec2 u_mouse;
uniform float u_time;

#define CUTOFF 30.0003

float rand (in vec2 _st) {
    return fract(sin(dot(_st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

void main(){
    vec2 uv=gl_FragCoord.xy/u_resolution.xy;
    uv.x*=1000.;
    uv.y*=550.;
    
    // static randomness
    float r = rand(gl_FragCoord.xy * 0.001);
    
    // blob setup
    
    vec2 blob1pos=vec2(250.,180.);
    float blob1size=550.;
    vec2 blob2pos=vec2(450.,200.);
    float blob2size=400.;
    vec2 blob3pos=vec2(600.,260.);
    float blob3size=460.;
    vec2 blob4pos=vec2(600.,260.);
    float blob4size=370.;
    
    // movement
    
    blob1pos.x+=sin(u_time*.5)*70.;
    blob1pos.y+=sin(u_time*.2)*90.;
    blob2pos.x+=sin(u_time*.8)*150.;
    blob2pos.y+=sin(u_time*.3)*20.;
    blob3pos.y+=sin(u_time*.5)*100.;
    blob3pos.x+=sin(u_time*.7)*100.;
    
    blob4pos.y+=sin(u_time*1.8)*130.;
    blob4pos.x+=sin(u_time*1.3)*120.;
    
    // calc
    
    float blob1dist=clamp(distance(blob1pos,uv),0.,blob1size);
    float blob1influence=clamp(1.-blob1dist/blob1size,.11,1.);
    
    float blob2dist=clamp(distance(blob2pos,uv),0.,blob2size);
    float blob2influence=clamp(1.-blob2dist/blob2size,.01,1.);
    
    float blob3dist=clamp(distance(blob3pos,uv),0.,blob3size);
    float blob3influence=clamp(1.-blob3dist/blob3size,.09,1.);
    
    float blob4dist=clamp(distance(blob4pos,uv),0.,blob4size);
    float blob4influence=clamp(1.-blob4dist/blob4size,.02,1.);
    
    // finished
    
    float intensity=(pow(blob1influence,6.)+pow(blob2influence,6.)+pow(blob3influence,6.)+pow(blob4influence,6.));
    intensity=(clamp(intensity,CUTOFF,CUTOFF+.0125)-CUTOFF)/2.9;
    
    // combine finished look with some static
    vec4 finish_color = vec4(0.,0.,0.,1.)+vec4(intensity)+vec4(blob1influence,blob2influence,blob3influence,1.);
    vec4 finish_static = vec4(vec3(r), 1.000);
    
    // toggle min/max for different looks
    // gl_FragColor=min(finish_color, finish_static);
    gl_FragColor=max(finish_color, finish_static);
}
