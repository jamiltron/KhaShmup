package;

import kha.System;

class Main {

  public static function main() {
    System.init("KhaShmup", 800, 600, init);
  }

  private static function init() {
    var game = new KhaShmup();
    System.notifyOnRender(game.render);
  }

}
