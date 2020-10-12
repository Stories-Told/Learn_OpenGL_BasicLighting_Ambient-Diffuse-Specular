#version 330 core

out vec4 fragColor;

in vec3 FragPos;
in vec3 Normal;

uniform vec3 lightPos;
uniform vec3 viewPos;
uniform vec3 objectColor;
uniform vec3 lightColor;

void main()
{
	
	// Ambient
	float ambientStrength = 0.1;
	vec3 ambient = ambientStrength * lightColor;

	// Diffuse
	// We normalize to make sure the relevant vectors end up as unit vectors
	vec3 norm = normalize(Normal);
	// Calculates the direction vector for the light
	vec3 lightDir = normalize(lightPos - FragPos);
	// find the diffuse value by using the dot product (the greater the angle
	// between the normals and the light direction the darker the diffuse value)
	// use of 'max' makes sure we don't get a negative diffuse value
	float diff = max(dot(norm, lightDir), 0.0);
	vec3 diffuse = diff * lightColor;

	// Specular
	float specularStrength = 0.5;
	vec3 viewDir = normalize(viewPos - FragPos);
	vec3 reflectDir = reflect(-lightDir, norm);
	// Calculates the specular component
	float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32); // '32' = the shininess
	vec3 specular = specularStrength * spec * lightColor;

	vec3 result = (ambient + diffuse + specular) * objectColor;
	fragColor = vec4(result, 1.0);
}