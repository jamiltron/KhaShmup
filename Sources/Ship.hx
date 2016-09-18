package;

import kha.Image;
import kha.Sound;
import kha.audio1.Audio;
import kha.graphics2.Graphics;

class Ship implements Hitboxed {
  private var image: Image;
  private var gunOffsetY = 10;
  private var isActive = true;

  public var explosionSound: Sound;
  public var hitbox: Hitbox;
  public var gun: Gun;
  public var x(default, set): Int;
  public var y(default, set): Int;
  public var width(get, null): Int;
  public var height(get, null): Int;
  public var speed = 300.0;

  public function new(x: Int, y: Int, image: Image, explosionSound: Sound) {
    hitbox = new Hitbox(x, y, 0, 0, image.width, image.height);
    this.x = x;
    this.y = y;
    this.image = image;
    this.explosionSound = explosionSound;
  }

  private function get_width(): Int {
    return image.width;
  }

  private function get_height(): Int {
    return image.height;
  }

  private function set_x(x: Int) {
    hitbox.updatePosition(x, y);
    return this.x = x;
  }

  private function set_y(y: Int) {
    hitbox.updatePosition(x, y);
    return this.y = y;
  }

  public function hit(): Void {
    isActive = false;
    Audio.play(explosionSound, false);
  }

  public function render(g: Graphics): Void {
    if (!isActive) {
      return;
    }

    if (gun != null) {
      gun.render(g);
    }
    g.drawImage(image, x, y);
  }

  public function reset(x: Int, y: Int): Void {
    isActive = true;
    this.x = x;
    this.y = y;

    if (gun != null) {
      gun.reset();
    }
  }

  public function update(controls: Controls, deltaTime: Float) {
    if (!isActive) {
      return;
    }

    if (controls.left && !controls.right) {
      x -= Math.round(speed * deltaTime);
    } else if (controls.right && !controls.left) {
      x += Math.round(speed * deltaTime);
    }

    if (controls.up && !controls.down) {
      y -= Math.round(speed * deltaTime);
    } else if (controls.down && !controls.up) {
      y += Math.round(speed * deltaTime);
    }

    if (gun != null) {
      if (controls.shoot) {
        gun.shoot(x + Std.int(image.width / 2), y - gunOffsetY);
      }
      gun.update(deltaTime);
    }
  }
}
