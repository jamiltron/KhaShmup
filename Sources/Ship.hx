package;

import kha.Image;
import kha.graphics2.Graphics;

class Ship {
  public static var width: Int = 99;
  public static var height: Int = 75;

  private var image: Image;

  public var x: Int;
  public var y: Int;

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
}