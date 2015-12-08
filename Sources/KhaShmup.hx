package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Image;
import kha.Key;
import kha.Scaler;
import kha.System;
import kha.input.Keyboard;

class KhaShmup {

  private static var bgColor = Color.fromValue(0x26004d);
  private static inline var width = 800;
  private static inline var height = 600;

  private var backbuffer: Image;
  private var controls: Controls;
  private var initialized: Bool = false;
  private var ship: Ship;
  private var timer: Timer;

  public function new() {
    Assets.loadEverything(loadingFinished);
  }

  private function loadingFinished(): Void {
    initialized = true;
    backbuffer = Image.createRenderTarget(width, height);
    controls = new Controls();
    timer = new Timer();
    Keyboard.get().notify(keyDown, keyUp);
    setupShip();
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

    update();
  }

  private function setupShip() {
    ship = new Ship(Math.round(width * 0.5 - Ship.width * 0.5), 
      Math.round(height * 0.5 - Ship.height * 0.5), 
      Assets.images.playerShip);
    ship.attachGun(new Gun(0.25, Assets.images.laser));
  }

  private function update() {
    timer.update();
    ship.update(controls, timer.deltaTime);
  }

  private function keyDown(key: Key, value: String): Void {
    controls.keyDown(key, value);
  }

  private function keyUp(key: Key, value: String): Void {
    controls.keyUp(key, value);
  }

}
