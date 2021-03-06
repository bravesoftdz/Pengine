#version 420

uniform sampler2D tex;

in vec2 ftexcoord;
in vec4 fcolor;
flat in vec2 fborderlow;
flat in vec2 fborderhigh;

out vec4 outcolor;

void main()
{
  vec2 ctexcoord = clamp(ftexcoord, fborderlow, fborderhigh);
  outcolor = texture(tex, ctexcoord) * fcolor; 
  if (outcolor.a == 0)
    gl_FragDepth = 1;
  else
    gl_FragDepth = gl_FragCoord.z;
}