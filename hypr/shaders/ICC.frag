#version 300 es

precision mediump float;
in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;

void main() {
    vec4 pix = texture(tex, v_texcoord);

    pix.r *= 0.95;
    pix.g *= 0.95;
    pix.b *= 1.0;

    fragColor = pix;
}
