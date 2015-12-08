package;

import kha.Image;
import kha.graphics2.Graphics;

class Gun {

  private var bulletImage: Image;
  private var shotInterval: Float;
  private var cooldownLeft: Float;
  private var bullets: Array<Bullet>;
  private var halfBulletWidth: Int;
  private var halfBulletHeight: Int;

  public function new(shotInterval: Float, bulletImage: Image) {
    this.shotInterval = shotInterval;
    this.bulletImage = bulletImage;
    cooldownLeft = 0;
    bullets = new Array<Bullet>();
    halfBulletWidth = Std.int(bulletImage.width / 2);
  }

  public function shoot(x: Int, y: Int): Void {
    if (cooldownLeft <= 0) {
      cooldownLeft = shotInterval;
      var adjX: Int = x - halfBulletWidth;

      var foundBullet = false;
      for (i in 0...bullets.length) {
        if (!bullets[i].isActive) {
          bullets[i].activate(adjX, y);
          foundBullet = true;
          return;
        }
      }

      if (!foundBullet) {
        bullets.push(new Bullet(adjX, y, bulletImage));
      }
    }
  }

  public function update(deltaTime: Float) {
    cooldownLeft -= deltaTime;
    if (cooldownLeft < 0) {
      cooldownLeft = 0;
    }

    for (i in 0...bullets.length) {
      var bullet = bullets[i];
      bullet.update(deltaTime);

      if (bullet.isActive && bullet.y + bulletImage.height < 0) {
        bullets[i].isActive = false;
      }
    }
  }

  public function render(g: Graphics) {
    for (i in 0...bullets.length) {
      bullets[i].render(g);
    }
  }

}