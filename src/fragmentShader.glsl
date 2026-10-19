#version 330 core	     // Minimal GL version support expected from the GPU

uniform vec3 camPos;

in vec3 fPosition;
//debug:
in vec3 fNormal;
in vec3 fColor;

out vec4 color;	  // Shader output: the color response attached to this fragment


void main() {
	// Normal vector
    vec3 n = normalize(fNormal);

    // light direction vector (hard-coded just for now)
    vec3 l = normalize(vec3(1.0, 1.0, 0.0));
	// TODO: vec3 v = calculate view vector
	// TODO: vec3 r = calculate reflection vector
	// TODO: vec3 ambient = set an ambient color
	// TODO: vec3 diffuse = calculate the diffuse lighting
	// TODO: vec3 specular = calculate the specular lighting
	// color = vec4(ambient + diffuse + specular, 1.0); // Building RGBA from RGB.

	// Direction toward the camera
    vec3 v = normalize(camPos - fPosition);

    // Reflection of the light direction
    vec3 r = reflect(-l, n);

    // Light and material properties
    vec3 lightColor = vec3(1.0, 1.0, 1.0);
    vec3 materialColor = vec3(0.2, 0.5, 1.0);

    vec3 ambientColor = vec3(0.1, 0.1, 0.1);

    float ka = 0.2;       // Ambient coefficient
    float kd = 0.8;       // Diffuse coefficient
    float ks = 0.5;       // Specular coefficient
    float shininess = 32.0;

    // Ambient contribution
    vec3 ambient = ka * ambientColor * materialColor;

    // Diffuse contribution (Lambert)
    float diff = max(dot(n, l), 0.0);
    vec3 diffuse = kd * diff * lightColor * materialColor;

    // Specular contribution (Phong)
    float spec = 0.0;

    if (diff > 0.0) {
        spec = pow(max(dot(r, v), 0.0), shininess);
    }

    vec3 specular = ks * spec * lightColor;

    // Final color
    vec3 result = ambient + diffuse + specular;

    color = vec4(clamp(result, 0.0, 1.0), 1.0);
}
