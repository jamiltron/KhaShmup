package;

import kha.Font;
import kha.graphics2.Graphics;

class UIManager {

  public var font: Font;
  public var x: Int;
  public var y: Int;
  public var fontSize: Int;

  private var score: Int;

  public function new(x: Int, y: Int, font: Font, fontSize: Int) {
    this.x = x;
    this.y = y;
    this.font = font;
    this.fontSize = fontSize;
  }

  public function scoreUp(): Void {
    score += 1;
  }

  public function render(g: Graphics): Void {
    g.font = font;
    g.fontSize = fontSize;
    g.drawString("score: " + score, x, y);
  }
}