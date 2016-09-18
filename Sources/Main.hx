package;

import kha.System;

class Main {

  public static function main() {
    System.init({ title: "KhaShmup", width: 800, height: 600 }, init);
  }

  private static function init() {
    var game = new KhaShmup();
    System.notifyOnRender(game.render);
  }

}
