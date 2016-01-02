package;

import kha.Image;
import kha.graphics2.Graphics;

class Ship {
  private var image: Image;
  private var gunOffsetY = 10;

  public var gun: Gun;
  public var x: Int;
  public var y: Int;
  public var width(get, null): Int;
  public var height(get, null): Int;
  public var speed = 300.0;


  public function new(x: Int, y: Int, image: Image) {
    this.x = x;
    this.y = y;
    this.image = image;
  }

  private function get_width(): Int {
    return image.width;
  }

  private function get_height(): Int {
    return image.height;
  }

  public function render(g: Graphics) {
    if (gun != null) {
      gun.render(g);
    }
    g.drawImage(image, x, y);
  }

  public function reset(x: Int, y: Int) {
    this.x = x;
    this.y = y;

    if (gun != null) {
      gun.reset();
    }
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
        gun.shoot(x + Std.int(image.width / 2), y - gunOffsetY);
      }
      gun.update(deltaTime);
    }
  }
}