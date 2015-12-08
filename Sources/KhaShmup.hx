package;

import kha.Color;
import kha.Framebuffer;
import kha.Image;
import kha.Scaler;
import kha.System;

class KhaShmup {

  private static var bgColor = Color.fromValue(0x26004d);

  private var backbuffer: Image;

  public function new() {
    backbuffer = Image.createRenderTarget(800, 600);
  }

  public function render(framebuffer: Framebuffer): Void {
    var g = backbuffer.g2;

    g.begin(bgColor);
    g.end();

    framebuffer.g2.begin();
    Scaler.scale(backbuffer, framebuffer, System.screenRotation);
    framebuffer.g2.end();
  }
}