package;

import kha.Image;
import kha.graphics2.Graphics;

class Ship {
  private var image: Image;

  public var x: Int;
  public var y: Int;

  public function new(x: Int, y: Int, image: Image) {
    this.x = x;
    this.y = y;
    this.image = image;
  }

  public function render(g: Graphics) {
    g.drawImage(image, x, y);
  }
}