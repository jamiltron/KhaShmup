package;

import kha.Image;
import kha.Sound;
import kha.audio1.Audio;
import kha.graphics2.Graphics;

enum EnemyState {
  Active;
  InActive;
  Exploding;
}

class Enemy implements Hitboxed {
  private var activeAnimation: Animation;
  private var explodeAnimation: Animation;
  private var explosionSound: Sound;
  private var enemyState: EnemyState;

  public var animation: Animation;
  public var hitbox: Hitbox;
  public var isActive(get, set): Bool;
  public var x: Int;
  public var y: Int;
  public var width(get, null): Int;
  public var height(get, null): Int;
  public var speed = 200.0;

  private function get_isActive(): Bool {
    return !Type.enumEq(enemyState, EnemyState.InActive);
  }

  private function set_isActive(value: Bool): Bool {
    if (value) {
      enemyState = EnemyState.Active;
    } else {
      enemyState = EnemyState.InActive;
    }

    return value;
  }

  private function get_width(): Int {
    return activeAnimation.getFrame(0).width;
  }

  private function get_height(): Int {
    return activeAnimation.getFrame(0).height;
  }

  public function new(x: Int, y: Int, activeAnimation: Animation, 
                      explodeAnimation: Animation, explosionSound: Sound) {
    this.activeAnimation = activeAnimation;
    this.explodeAnimation = explodeAnimation;
    this.explosionSound = explosionSound;
    hitbox = new Hitbox(x, y, 2, 0, activeAnimation.getFrame(0).width - 4, 
                        Std.int(activeAnimation.getFrame(0).height / 2));
    activate(x, y);
  }

  public function activate(x: Int, y: Int): Void {
    this.x = x;
    this.y = y;
    hitbox.updatePosition(x, y);
    enemyState = EnemyState.Active;
    setAnimation(activeAnimation);
    hitbox.enabled = true;
  }

  public function hit(): Void {
    Audio.play(explosionSound, false, true);
    enemyState = EnemyState.Exploding;
    setAnimation(explodeAnimation);
    hitbox.enabled = false;
  }

  public function render(g: Graphics): Void {
    if (!isActive) {
      return;
    }

    if (!animation.isDone) {
      g.drawImage(animation.getCurrentFrame(), x, y);
    }
  }

  public function update(deltaTime: Float): Void {
    if (!isActive) {
      return;
    }

    if (Type.enumEq(enemyState, EnemyState.Active)) {
      y += Math.round(speed * deltaTime);
      hitbox.updatePosition(x, y);
    }
    animation.update(deltaTime);

    if (Type.enumEq(enemyState, EnemyState.Exploding) &&animation.isDone) {
      isActive = false;
    }
  }

  private function setAnimation(newAnimation: Animation) {
    animation = newAnimation;
    animation.reset();
  }
}