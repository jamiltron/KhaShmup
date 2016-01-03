package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Image;
import kha.Key;
import kha.Scaler;
import kha.System;
import kha.graphics2.Graphics;
import kha.input.Keyboard;

enum GameState {
  Initializing;
  MainMenu;
  Playing;
  Over;
}

class KhaShmup {

  private static var bgColor = Color.fromValue(0x26004d);

  public static inline var screenWidth = 800;
  public static inline var screenHeight = 600;
  public static inline var gunSpeed = 0.25;

  private var backbuffer: Image;
  private var controls: Controls;
  private var enemySpawner: EnemySpawner;
  private var gameState: GameState;
  private var ship: Ship;
  private var timer: Timer;
  private var uiManager: UIManager;

  public function new() {
    gameState = GameState.Initializing;
    Assets.loadEverything(loadingFinished);
  }

  private function loadingFinished(): Void {
    gameState = GameState.MainMenu;

    // create a buffer to draw to
    backbuffer = Image.createRenderTarget(screenWidth, screenHeight);

    // create our player
    setupShip();
    controls = new Controls();
    enemySpawner = new EnemySpawner(1.0, 3.0, 0, screenWidth, screenHeight);
    timer = new Timer();
    uiManager = new UIManager(Assets.fonts.kenpixel_mini_square, 20, 80, 30, new Rectangle(0, 0, screenWidth, screenHeight));
    Keyboard.get().notify(keyDown, keyUp);
  }

  private function reset() {
    controls.reset();
    ship.reset(Std.int(screenWidth / 2) - Std.int(ship.width / 2), 
      Std.int(screenHeight / 2) - Std.int(ship.height / 2));
    enemySpawner.reset();
    uiManager.reset();
    timer.reset();
  }  

  private function renderMainMenu(g: Graphics): Void {
    uiManager.renderMainMenu(g);
  }

  private function renderPlaying(g: Graphics): Void {
    enemySpawner.render(g);
    ship.render(g);
    uiManager.renderScore(g);
  }

  private function renderOver(g: Graphics): Void {

  }

  public function render(framebuffer: Framebuffer): Void {
    if (Type.enumEq(gameState, GameState.Initializing)) {
      return;
    }

    var g = backbuffer.g2;

    // clear and draw to our backbuffer
    g.begin(bgColor);
    switch(gameState) {
    case GameState.MainMenu:
      renderMainMenu(g);
      updateMainMenu();
    case GameState.Playing:
      renderPlaying(g);
      updatePlaying();
    default:
      // no-op
    }
    g.end();

    // draw our backbuffer onto the active framebuffer
    framebuffer.g2.begin();
    Scaler.scale(backbuffer, framebuffer, System.screenRotation);
    framebuffer.g2.end();
  }

  private function handleCollisions() {
    var bullets: Array<Hitboxed> = cast ship.gun.getActiveBullets();
    var enemies: Array<Hitboxed> = cast enemySpawner.getActiveEnemies();

    CollisionHandler.handleGroupCollisions(bullets, enemies, uiManager.scoreUp);
    CollisionHandler.handleSingleToGroupCollisions(ship, enemies, setGameOver);
  }

  private function setGameOver() {
    trace("GAME OVER!");
  }

  private function setupShip() {
    var shipImg = Assets.images.playerShip;
    ship = new Ship(Std.int(screenWidth / 2) - Std.int(shipImg.width / 2), 
      Std.int(screenHeight / 2) - Std.int(shipImg.height / 2), 
      shipImg);
    ship.gun = new Gun(gunSpeed, Assets.images.bullet, Assets.sounds.bulletShoot);
  }

  private function updateMainMenu() {
    if (controls.shoot) {
      reset();
      gameState = GameState.Playing;
    }
  }

  private function updatePlaying() {
    timer.update();
    enemySpawner.update(timer.deltaTime);
    updateShip();
    handleCollisions();
  }

  private function updateShip() {
    ship.update(controls, timer.deltaTime);

    // limit the ship to the width of the screen
    if (ship.x < 0) {
      ship.x = 0;
    } else if (ship.x + ship.width > screenWidth) {
      ship.x = screenWidth - ship.width;
    }

    // limit the ship to the height of the screen
    if (ship.y < 0) {
      ship.y = 0;
    } else if (ship.y + ship.height > screenHeight) {
      ship.y = screenHeight - ship.height;
    }
  }

  private function keyDown(key: Key, value: String): Void {
    controls.keyDown(key, value);
  }

  private function keyUp(key: Key, value: String): Void {
    controls.keyUp(key, value);
  }

}
