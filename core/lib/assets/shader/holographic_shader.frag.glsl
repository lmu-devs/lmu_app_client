#version 460 core
#include <flutter/runtime_effect.glsl>

// Input uniforms
uniform vec2 uResolution;  // Dimensions of the card in pixels
uniform vec2 uPointerPos;  // Mouse/tilt position normalized to 0-1 range
uniform vec2 uCenter;      // Dynamic center position for the circular mask
// Custom parameters
uniform float uWaveFrequency; // Frequency of the wave pattern
uniform float uPointerInfluence; // How much the pointer affects the pattern
uniform float uColorAmplitude; // Amplitude of the color variation
uniform float uBaseAlpha; // Base alpha value for the holographic effect

// Output color
out vec4 fragColor;

// Shader parameters - these are now configurable via uniforms
// const float DIAGONAL_FREQ = 5.0; // We'll derive this from wave frequency

// Constant rotation angle (in radians)
const float ROTATION_ANGLE = 0.785398; // ~45 degrees

// Rotation function
vec2 rotate(vec2 uv, float angle) {
    float s = sin(angle);
    float c = cos(angle);
    
    uv -= 0.5; // Move center
    vec2 rotated = vec2(
        uv.x * c - uv.y * s,
        uv.x * s + uv.y * c
    );
    rotated += 0.5; // Move back
    return rotated;
}

// Circular mask for alpha fading
float circularMask(vec2 uv) {
    // Use the dynamic center position
    vec2 center = uCenter;
    float dist = distance(uv, center);
    float falloff = smoothstep(0.75, 0, dist); // fades out past 0.3 radius
    return falloff;
}

void main() {
    vec2 uv = FlutterFragCoord().xy / uResolution;
    vec2 rotatedUV = rotate(uv, ROTATION_ANGLE);

    // Use custom frequency and pointer influence
    float R = sin(rotatedUV.x * uWaveFrequency + uPointerPos.x * uPointerInfluence)
             * uColorAmplitude + 0.3;

    float G = cos(rotatedUV.y * uWaveFrequency - uPointerPos.y * uPointerInfluence)
             * uColorAmplitude + 0.3;

    // Derive diagonal frequency from wave frequency
    float diagonalFreq = uWaveFrequency;
    float B = sin((rotatedUV.x + rotatedUV.y) * diagonalFreq)
             * uColorAmplitude + 0.3;

    float brightness = (R + G + B) / 5.0;

    // Apply circular falloff to alpha with custom base alpha
    float alpha = brightness * uBaseAlpha * circularMask(uv);

    fragColor = vec4(R, G, B, alpha);
}