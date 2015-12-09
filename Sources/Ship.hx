package;

import kha.Image;
import kha.graphics2.Graphics;

class Ship {

  public static var width: Int = 99;
  public static var height: Int = 75;

  private var image: Image;
  private var gun: Gun;
  private var halfWidth: Int;
  private var gunOffsetY = 10;

  public var x: Int;
  public var y: Int;
  public var speed: Float = 300.0;

  public function new(x: Int, y: Int, image: Image) {
    this.x = x;
    this.y = y;
    this.image = image;
    halfWidth = Std.int(image.width / 2);
  }

  public function attachGun(gun: Gun) {
    this.gun = gun;
  }

  public function render(g: Graphics) {
    if (gun != null) {
      gun.render(g);
    }
    g.drawImage(image, x, y);
  }

  public function update(controls: Controls, deltaTime: Float) {
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
        gun.shoot(x + halfWidth, y - gunOffsetY);
      }
      gun.update(deltaTime);
    }
  }
}