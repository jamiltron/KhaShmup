package;

import kha.Image;
import kha.graphics2.Graphics;

class Ship {
  public static inline var width: Int = 99;
  public static inline var height: Int = 75;

  private var image: Image;

  public var x: Float;
  public var y: Float;
  public var speed: Float = 200.0;

  public function new(x: Int, y: Int, image: Image) {
    this.x = x;
    this.y = y;
    this.image = image;
  }

  public function render(g: Graphics) {
    if (image != null) {
      g.drawImage(image, x, y);
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
  }
}