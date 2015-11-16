package ;

import kha.Button;
import kha.Color;
import kha.Configuration;
import kha.Framebuffer;
import kha.Game;
import kha.Image;
import kha.Loader;
import kha.LoadingScreen;
import kha.Scaler;
import kha.Sys;

class KhaShmup extends Game {

  private var backbuffer: Image;
  private var ship: Ship;
  private var controls: Controls;
  private var timer: Timer;
  private var initialized: Bool;

  public function new() {
    super("KhaShmup", false);
    initialized = false;
  }

  override public function init(): Void {
    Configuration.setScreen(new LoadingScreen());
    Loader.the.loadRoom("gameRoom", loadingFinished);
  }

  private function loadingFinished(): Void {
    backbuffer = Image.createRenderTarget(width, height);
    ship = new Ship(width * 0.5 - Ship.width * 0.5, 
      height * 0.5 - Ship.height * 0.5, 
      Loader.the.getImage("playerShip"));
    controls = new Controls();
    timer = new Timer();
    Configuration.setScreen(this);
    initialized = true;
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

  override public function update() {
    if (!initialized) return;

    timer.update();
    ship.update(controls, timer.deltaTime);
  }

  override public function buttonDown(button: Button): Void {
    controls.buttonDown(button);
  }

  override public function buttonUp(button: Button): Void {
    controls.buttonUp(button);
  }


}
