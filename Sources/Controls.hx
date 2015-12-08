package ;

import kha.Button;

class Controls {

  public var left: Bool;
  public var right: Bool;
  public var up: Bool;
  public var down: Bool;
  public var shoot: Bool;

  public function new() {
  }

  public function buttonDown(button: Button) { 
    if (button == Button.LEFT) {
      left = true;
    } else if (button == Button.RIGHT) {
      right = true;
    } else if (button == Button.UP) {
      up = true;
    } else if (button == Button.DOWN) {
      down = true;
    } else if (button == Button.Z) {
      shoot = true;
    }
  }

  public function buttonUp(button: Button) { 
    if (button == Button.LEFT) {
      left = false;
    } else if (button == Button.RIGHT) {
      right = false;
    } else if (button == Button.UP) {
      up = false;
    } else if (button == Button.DOWN) {
      down = false;
    } else if (button == Button.Z) {
      shoot = false;
    }
  }

}
