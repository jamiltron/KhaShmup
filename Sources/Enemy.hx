package;

import kha.Assets;
import kha.Image;
import kha.audio1.Audio;
import kha.graphics2.Graphics;

class Enemy implements Hitboxed {
  private var image: Image;

  public var hitbox: Hitbox;
  public var x: Int;
  public var y: Int;
  public var width(get, null): Int;
  public var height(get, null): Int;
  public var speed = 200.0;
  public var isActive = true;

  private function get_width(): Int {
    return image.width;
  }

  private function get_height(): Int {
    return image.height;
  }

  public function new(x: Int, y: Int, image: Image) {
    this.image = image;
    hitbox = new Hitbox(x, y, 2, 0, image.width - 4, Std.int(image.height / 2));
    activate(x, y);
  }

  public function activate(x: Int, y: Int): Void {
    this.x = x;
    this.y = y;
    hitbox.updatePosition(x, y);
    isActive = true;
  }

  public function hit(): Void {
    Audio.play(Assets.sounds.enemyExplosion, true);
    isActive = false;
  }

  public function render(g: Graphics): Void {
    if (!isActive) {
      return;
    }
    g.drawImage(image, x, y);
  }

  public function update(deltaTime: Float): Void {
    if (!isActive) {
      return;
    }

    y += Math.round(speed * deltaTime);
    hitbox.updatePosition(x, y);
  }
}