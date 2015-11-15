package ;

import kha.graphics2.Graphics;
import kha.Image;

class Ship {
  public static var width: Int = 99;
  public static var height: Int = 75;

  private var image: Image;

  public var x: Float;
  public var y: Float;
  public var speed: Float = 200.0;

  public function new(x: Float, y: Float, image: Image) {
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
      x -= speed * deltaTime;
    } else if (controls.right && !controls.left) {
      x += speed * deltaTime;
    }

    if (controls.up && !controls.down) {
      y -= speed * deltaTime;
    } else if (controls.down && !controls.up) {
      y += speed * deltaTime;
    }
  }
}