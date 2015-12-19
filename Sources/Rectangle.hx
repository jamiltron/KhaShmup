package;

class Rectangle {
  public var x: Int;
  public var y: Int;
  public var width: Int;
  public var height: Int;

  public inline function new(x: Int, y: Int, width: Int, height: Int) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }

  public inline function overlaps(other: Rectangle): Bool {
    return x <= other.x + other.width && 
           x + width >= other.x && 
           y <= other.y + other.height && 
           y + height >= other.y;
  }
}