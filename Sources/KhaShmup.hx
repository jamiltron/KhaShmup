package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Image;
import kha.Scaler;
import kha.System;

class KhaShmup {

  private static var bgColor = Color.fromValue(0x26004d);

  public static inline var screenWidth = 800;
  public static inline var screenHeight = 600;

  private var backbuffer: Image;
  private var initialized = false;
  private var ship: Ship;

  public function new() {
    Assets.loadEverything(loadingFinished);
  }

  private function loadingFinished(): Void {
    initialized = true;

    // create a buffer to draw to
    backbuffer = Image.createRenderTarget(screenWidth, screenHeight);

    // create our player
    var shipImg = Assets.images.playerShip;
    ship = new Ship(Std.int(screenWidth / 2) - Std.int(shipImg.width / 2), 
      Std.int(screenHeight / 2) - Std.int(shipImg.height / 2), 
      shipImg);
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
