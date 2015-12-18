package;

import kha.Image;
import kha.graphics2.Graphics;

class Bullet implements Hitboxed {
  private var image: Image;

  public var hitbox: Hitbox;
  public var x: Int;
  public var y: Int;
  public var speed = 600;
  public var isActive = true;

  public function new(x: Int, y: Int, image: Image) {
    this.image = image;
    hitbox = new Hitbox(x, y, 0, 0, image.width, image.height);
    activate(x, y);
  }

  public function activate(x: Int, y: Int) {
    this.x = x;
    this.y = y;
    hitbox.updatePosition(x, y);
    isActive = true;
  }

  public function hit(): Void {
    isActive = false;
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

    y -= Math.round(speed * deltaTime);
    hitbox.updatePosition(x, y);
  }
}
