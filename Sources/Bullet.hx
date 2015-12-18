package;

import kha.Image;
import kha.graphics2.Graphics;

class Bullet implements Hitboxed {
  private var image: Image;
  private var hitbox: Rectangle;

  public var x: Int;
  public var y: Int;
  public var speed = 600;
  public var isActive = true;

  public function new(x: Int, y: Int, image: Image) {
    this.image = image;
    activate(x, y);
    hitbox = new Rectangle(x, y, image.width, image.height);
  }

  public function activate(x: Int, y: Int) {
    this.x = x;
    this.y = y;
    isActive = true;
  }

  public function getHitbox(): Rectangle {
    hitbox.x = x;
    hitbox.y = y;

    return hitbox;
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
  }
}
