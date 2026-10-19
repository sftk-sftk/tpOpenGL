#version 330 core	     // Minimal GL version support expected from the GPU
in vec3 fColor;

//debug:
in vec3 fNormal;

out vec4 color;	  // Shader output: the color response attached to this fragment


void main() {
	//turn this on after the debug
	//color = vec4(fColor, 1.0); // build an RGBA from an RGB
	//debug:
	color = vec4(normalize(fNormal), 1.0);
}
