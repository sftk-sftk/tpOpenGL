#version 330 core            // Minimal GL version support expected from the GPU
/*
layout(location=0) in vec3 vPosition;
layout(location=1) in vec3 vColor;
//debug:
layout(location=1) in vec3 vNormal;
out vec3 fColor;
out vec3 fPosition;
//debug:
out vec3 fNormal;


uniform mat4 viewMat, projMat;

void main() {
        fColor= vColor;
        
        //debug:
        fNormal=vNormal;

        gl_Position = projMat * viewMat * vec4(vPosition, 1.0); // mandatory to rasterize properly
}
*/

layout(location = 0) in vec3 position;
layout(location = 1) in vec3 normal;

// Matrices
uniform mat4 modelMat;
uniform mat4 viewMat;
uniform mat4 projMat;

// Data passed to the fragment shader
out vec3 worldPosition;
out vec3 worldNormal;

void main() {
    vec4 worldPos = modelMat * vec4(position, 1.0);

    worldPosition = worldPos.xyz;

    // Correct transformation of normals
    worldNormal = mat3(transpose(inverse(modelMat))) * normal;

    gl_Position = projMat * viewMat * worldPos;
}
