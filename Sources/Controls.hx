package;

import kha.Key;

class Controls {
  public var left: Bool;
  public var right: Bool;
  public var up: Bool;
  public var down: Bool;

  public function new() {}

  public function keyDown(key: Key) { 
    switch (key) {
    case LEFT:
      left = true;
    case RIGHT:
      right = true;
    case UP:
      up = true;
    case DOWN:
      down = true;
    default:
      // no-op
    }
  }

  public function keyUp(key: Key) { 
    switch (key) {
    case LEFT:
      left = false;
    case RIGHT:
      right = false;
    case UP:
      up = false;
    case DOWN:
      down = false;
    default:
      //no-op
    }
  }
}