package;

import kha.Image;
import kha.graphics2.Graphics;

class Enemy {
  public static inline var width = 93;
  public static inline var height = 84;

  private var image: Image;

  public var x: Int;
  public var y: Int;
  public var speed = 200.0;
  public var isActive = true;

  public function new(x: Int, y: Int, image: Image) {
    this.image = image;
    activate(x, y);
  }

  public function activate(x: Int, y: Int): Void {
    this.x = x;
    this.y = y;
    isActive = true;
  }

  public function render(g: Graphics): Void {
    if (isActive && image != null) {
      g.drawImage(image, x, y);
    }
  }

  public function update(deltaTime: Float): Void {
    if (!isActive) {
      return;
    }

    y += Math.round(speed * deltaTime);
  }
}