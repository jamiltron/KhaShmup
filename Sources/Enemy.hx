package;

import kha.Image;
import kha.graphics2.Graphics;

class Enemy implements Hitboxed {
  private var image: Image;
  private var hitbox: Rectangle;

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
    activate(x, y);
    hitbox = new Rectangle(x, y, image.width, image.height);
  }

  public function activate(x: Int, y: Int): Void {
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
  }
}