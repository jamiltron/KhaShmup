package;

import kha.Color;
import kha.Framebuffer;
import kha.Image;
import kha.Scaler;
import kha.System;

class KhaShmup {

  private static var bgColor = Color.fromValue(0x26004d);
  public static inline var width = 800;
  public static inline var height = 600;

  private var backbuffer: Image;

  public function new() {
    // create a buffer to draw to
    backbuffer = Image.createRenderTarget(width, height);
  }

  public function render(framebuffer: Framebuffer): Void {
    var g = backbuffer.g2;

    // clear our backbuffer using graphics2
    g.begin(bgColor);
    g.end();

    // draw our backbuffer onto the active framebuffer
    framebuffer.g2.begin();
    Scaler.scale(backbuffer, framebuffer, System.screenRotation);
    framebuffer.g2.end();
  }
}