package;

import kha.Font;
import kha.graphics2.Graphics;

class UIManager {
  private static inline var scoreX = 10;
  private static inline var scoreY = 10;
  private static inline var titleY = 60;
  private static inline var titleStr = "Kha Shmup";
  private static inline var keysStr = "Arrow Keys to move, Z key to shoot.";
  private static inline var keysY = 130;
  private static inline var startStr = "Press Z to start.";
  private static inline var startY = 100;

  public var font: Font;
  public var scoreSize: Int;
  public var titleSize: Int;
  public var instructionSize: Int;
  public var viewport: Rectangle;

  private var score: Int;

  public function new(font: Font, scoreSize: Int, titleSize: Int, 
                      instructionSize: Int, viewport: Rectangle) {
    this.font = font;
    this.scoreSize = scoreSize;
    this.titleSize = titleSize;
    this.instructionSize = instructionSize;
    this.viewport = viewport;
  }

  public function scoreUp(): Void {
    score += 1;
  }

  public function renderScore(g: Graphics): Void {
    g.font = font;
    g.fontSize = scoreSize;
    g.drawString("score: " + score, viewport.x + scoreX, viewport.y + scoreY);
  }

  public function renderMainMenu(g: Graphics): Void {
    g.font = font;
    g.fontSize = titleSize;
    var x = viewport.x + Math.round(viewport.width / 2);

    var titleW = g.font.width(titleSize, titleStr);
    g.drawString(titleStr, x - Math.round(titleW / 2), viewport.y + titleY);

    g.fontSize = instructionSize;
    var keysW = g.font.width(instructionSize, keysStr);
    g.drawString(keysStr, x - Math.round(keysW / 2), viewport.height - keysY);

    var startW = g.font.width(instructionSize, startStr);
    g.drawString(startStr, x - Math.round(startW / 2), viewport.height - startY);

  }
}