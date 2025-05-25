// shaders/god_rays.frag
#version 460 core
#include <flutter/runtime_effect.glsl>

// Uniforms to be passed from Flutter
uniform float iTime;
uniform vec2 iResolution;

uniform vec2 uRayPos1;
uniform vec2 uRayRefDir1; // Should be pre-normalized
uniform float uRaySeedA1;
uniform float uRaySeedB1;
uniform float uRaySpeed1;

uniform vec2 uRayPos2;
uniform vec2 uRayRefDir2; // Should be pre-normalized
uniform float uRaySeedA2;
uniform float uRaySeedB2;
uniform float uRaySpeed2;

uniform vec3 uRayColor;

out vec4 fragColor;

float rayStrength(vec2 raySource, vec2 rayRefDirection, vec2 coord, float seedA, float seedB, float speed)
{
	vec2 sourceToCoord = coord - raySource;
	float cosAngle = dot(normalize(sourceToCoord), rayRefDirection); // rayRefDirection is already normalized
	
	return clamp(
		(0.45 + 0.15 * sin(cosAngle * seedA + iTime * speed)) +
		(0.3 + 0.2 * cos(-cosAngle * seedB + iTime * speed)),
		0.0, 1.0) *
		// Attenuate by distance from source, but ensure it's at least 0.5 strength
		// This makes rays stronger near their source and fade out.
		// The iResolution.x here might be better as a dedicated falloff distance uniform.
		// For now, keeping it similar to original.
		clamp((iResolution.y - length(sourceToCoord)) / iResolution.y, 0.50, .8);
}

void main()
{
	vec2 coord = FlutterFragCoord().xy; // Local coordinates, (0,0) is top-left
	
	// Calculate the colour of the sun rays on the current fragment
	vec4 rays1 =
		vec4(1.0, 1.0, 1.0, 1.0) * // Base white color for rays
		rayStrength(uRayPos1, uRayRefDir1, coord, uRaySeedA1, uRaySeedB1, uRaySpeed1);
	 
	vec4 rays2 =
		vec4(1.0, 1.0, 1.0, 1.0) * // Base white color for rays
		rayStrength(uRayPos2, uRayRefDir2, coord, uRaySeedA2, uRaySeedB2, uRaySpeed2);
	
	// Combine rays
	fragColor = rays1 * 0.5 + rays2 * 0.4;
	
	// Create a stronger vertical falloff effect
	
	// Handle both light and dark rays differently
	vec3 finalColor;
	if (uRayColor.g > 0.3) { 
		// For light rays (dark mode)
		float verticalFalloff = pow(1.0 - (coord.y / iResolution.y), 7.5);
		finalColor = fragColor.rgb * (verticalFalloff * 2.0);
	} else { 
		// For dark rays (light mode)
		float verticalFalloff = pow(1.0 - (coord.y / iResolution.y), 1.5);
		// Invert the process - start with dark color and fade to transparent/white
		vec3 darkRayColor = vec3(0.1, 0.1, 0.1); // Very dark gray/black color
		finalColor = mix(
			darkRayColor * fragColor.rgb, // Dark base color
			vec3(0.8, 0.8, 0.8), // Fade to white/transparent
			pow(1.0 - verticalFalloff, 0.3) // Control the fade
		) * 0.5; // Overall intensity control
	}
	
	// Apply the color tint
	fragColor.rgb = finalColor;
	fragColor.a = clamp(fragColor.a, 0.0, 1.0);
}