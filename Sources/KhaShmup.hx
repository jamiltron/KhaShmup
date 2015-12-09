package;

import kha.Assets;
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
  private var initialized: Bool = false;
  private var ship: Ship;

  public function new() {
    Assets.loadEverything(loadingFinished);
  }

  private function loadingFinished(): Void {
    initialized = true;

    // create a buffer to draw to
    backbuffer = Image.createRenderTarget(width, height);

    // create our player
    ship = new Ship(Std.int(width / 2) - Std.int(Ship.width / 2), 
      Std.int(height / 2) - Std.int(Ship.height / 2), 
      Assets.images.playerShip);
  }

  public function render(framebuffer: Framebuffer): Void {
    if (!initialized) {
      return;
    }

    var g = backbuffer.g2;

    // clear and draw to our backbuffer
    g.begin(bgColor);
    ship.render(g);
    g.end();

    // draw our backbuffer onto the active framebuffer
    framebuffer.g2.begin();
    Scaler.scale(backbuffer, framebuffer, System.screenRotation);
    framebuffer.g2.end();
  }

}
