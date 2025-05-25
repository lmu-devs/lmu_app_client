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
		clamp((iResolution.x - length(sourceToCoord)) / iResolution.x, 0.12, 1.0);
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
	
	// Attenuate brightness towards the bottom, simulating light-loss due to depth.
	// Give the whole thing a blue-green tinge as well.
	float brightness = 1.0 - (coord.y / iResolution.y); // coord.y is 0 at top, iResolution.y at bottom
	fragColor.rgb *= (brightness * 5.8); // Modulates existing color
    // fragColor.r *= (0.0 + brightness * 0.8); // Example: if you want to tint blue-green
	// fragColor.g *= (0.2 + brightness * 0.8); // Apply more green
	// fragColor.b *= (0.4 + brightness * 0.8); // Apply more blue

    // Let's apply the blue-green tinge more directly based on your original code:
    // fragColor.x *= 0.0 + (brightness * 0.8); // This would make red component 0 if brightness is 0
	// fragColor.y *= 0.0 + (brightness * 0.8);
	// fragColor.z *= 0.0 + (brightness * 0.8);
    // This is more of a tint:
    vec3 tint = vec3(0.25, 0.28, 0.30); // A blue-greenish tint
    fragColor.rgb *= mix(tint * 0.0, tint, brightness); // Darker tint at the bottom, brighter at top
    fragColor.a = clamp(fragColor.a, 0.0, 1.0); // Ensure alpha is valid
}