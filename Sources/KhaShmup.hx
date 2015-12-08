package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Image;
import kha.Scaler;
import kha.System;

class KhaShmup {

  private static var bgColor = Color.fromValue(0x26004d);
  private static inline var width = 800;
  private static inline var height = 600;

  private var backbuffer: Image;
  private var initialized: Bool = false;
  private var ship: Ship;

  public function new() {
    Assets.loadEverything(loadingFinished);
  }

  private function loadingFinished(): Void {
    initialized = true;
    backbuffer = Image.createRenderTarget(width, height);
    ship = new Ship(Math.round(width * 0.5 - Ship.width * 0.5), 
      Math.round(height * 0.5 - Ship.height * 0.5), 
      Assets.images.playerShip);
  }

  public function render(framebuffer: Framebuffer): Void {
    if (!initialized) {
      return;
    }

    var g = backbuffer.g2;
    
    g.begin(bgColor);
    ship.render(g);
    g.end();

    framebuffer.g2.begin();
    Scaler.scale(backbuffer, framebuffer, System.screenRotation);
    framebuffer.g2.end();
  }

}
