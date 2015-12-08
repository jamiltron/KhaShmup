package;

import kha.Image;
import kha.graphics2.Graphics;

class Bullet {

  private var image: Image;
  public var offscreen(default, null): Bool;

  public var x: Int;
  public var y: Int;
  public var speed: Int = 400;

  public function new(x: Int, y: Int, image: Image) {
    this.x = x;
    this.y = y;
    this.image = image;
  }

  public function render(g: Graphics): Void {
    g.drawImage(image, x, y);
  }

  public function update(delta: Float): Void {
    y += Math.round(speed * delta);

    if (y + image.height * 0.5 < 0) {
      offscreen = true;
    }
  }

}
