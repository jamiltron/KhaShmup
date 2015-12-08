package;

import kha.Image;
import kha.graphics2.Graphics;

class Ship {

  public static var width: Int = 99;
  public static var height: Int = 75;

  private var image: Image;
  private var bulletImage: Image;
  private var bullets: Array<Bullet>;

  public var x: Float;
  public var y: Float;
  public var speed: Float = 200.0;

  public function new(x: Int, y: Int, image: Image) {
    this.x = x;
    this.y = y;
    this.image = image;
    bullets = new Array<Bullet>();
  }

  public function render(g: Graphics) {
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

    updateBullets();

    if (controls.shoot) {
      bullets.push(new Bullet(x - 5, y - 3, bulletImage));
      bullets.push(new Bullet(x + 5, y - 3, bulletImage));
    }
  }
}