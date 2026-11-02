#version 330 core
// Minimal GL version support expected from the GPU


// Inputs from the vertex shader
in vec3 worldPosition;
in vec3 worldNormal;
in vec2 fTexCoord;

struct Material {
    sampler2D albedoTex;
};


// Camera and lighting
uniform Material material;
uniform vec3 lightPos;
uniform vec3 lightColor;
uniform bool isSun;

out vec4 fragColor;

void main() {
    // Sun: uniform yellow color, without texture
    if (isSun) {
        fragColor = vec4(1.0, 0.8, 0.1, 1.0);
        return;
    }

    // Earth and Moon: use their textures
    vec3 texColor = texture(
        material.albedoTex,
        fTexCoord
    ).rgb;

    vec3 N = normalize(worldNormal);
    vec3 L = normalize(lightPos - worldPosition);

    float ambientStrength = 0.15;
    vec3 ambient = ambientStrength * lightColor;

    float diff = max(dot(N, L), 0.0);
    vec3 diffuse = diff * lightColor;

    vec3 result = texColor * (ambient + diffuse);

    fragColor = vec4(result, 1.0);
}