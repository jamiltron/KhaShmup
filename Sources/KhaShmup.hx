package ;

import kha.Color;
import kha.Configuration;
import kha.Framebuffer;
import kha.Game;
import kha.Image;
import kha.Loader;
import kha.LoadingScreen;
import kha.Scaler;
import kha.Sys;
import Ship;

class KhaShmup extends Game {

  private var backbuffer: Image;
  private var ship: Ship;

  public function new() {
    super("KhaShmup", false);
  }

  override public function init(): Void {
    Configuration.setScreen(new LoadingScreen());
    Loader.the.loadRoom("gameRoom", loadingFinished);
  }

  private function loadingFinished(): Void {
    backbuffer = Image.createRenderTarget(width, height);
    ship = new Ship(Std.int(width / 2) - Std.int(Ship.width / 2), 
      Std.int(height / 2) - Std.int(Ship.height / 2), 
      Loader.the.getImage("playerShip"));
    Configuration.setScreen(this);
  }

  override public function render(framebuffer: Framebuffer): Void {
    var g = backbuffer.g2;
    
    g.begin(Color.Black);
    ship.render(g);
    g.end();

    startRender(framebuffer);
    Scaler.scale(backbuffer, framebuffer, Sys.screenRotation);
    endRender(framebuffer);
  }


}