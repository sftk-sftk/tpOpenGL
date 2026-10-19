#version 330 core            // Minimal GL version support expected from the GPU

layout(location=0) in vec3 vPosition;
layout(location=1) in vec3 vColor;
//debug:
layout(location=1) in vec3 vNormal;
out vec3 fColor;
//debug:
out vec3 fNormal;


uniform mat4 viewMat, projMat;

void main() {
        fColor= vColor;
        
        //debug:
        fNormal=vNormal;

        gl_Position = projMat * viewMat * vec4(vPosition, 1.0); // mandatory to rasterize properly
}
