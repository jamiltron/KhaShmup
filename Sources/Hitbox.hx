package;

class Hitbox {
  public var rectangle(default, null): Rectangle;
  public var parentX: Int;
  public var parentY: Int;
  public var offsetX: Int;
  public var offsetY: Int;
  public var width: Int;
  public var height: Int;

  public function new(parentX: Int, parentY: Int, offsetX: Int, offsetY: Int, width: Int, height: Int) {
    this.parentX = parentX;
    this.parentY = parentY;
    this.offsetX = offsetX;
    this.offsetY = offsetY;
    this.width = width;
    this.height = height;

    rectangle = new Rectangle(parentX + offsetX, parentY + offsetY, width, height);
  }

  public function overlaps(other: Hitbox): Bool {
    return rectangle.overlaps(other.rectangle);
  }

  public function updatePosition(parentX: Int, parentY: Int): Void {
    this.parentX = parentX;
    this.parentY = parentX;
    rectangle.x = parentX + offsetX;
    rectangle.y = parentY + offsetY;
    rectangle.width = width;
    rectangle.height = height;
  }

}