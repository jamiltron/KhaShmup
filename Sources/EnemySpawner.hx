package;

import kha.Image;
import kha.graphics2.Graphics;

class EnemySpawner {
  private var minSpawnX: Int;
  private var maxSpawnX: Int;
  private var maxPositionY: Int;
  private var enemyImage: Image;
  private var spawnMinTime: Float;
  private var spawnMaxTime: Float;
  private var spawnNextTime: Float;
  private var currentTime: Float;
  private var enemies: Array<Enemy>;

  public function new(enemyImage: Image, spawnMinTime: Float, spawnMaxTime: Float, 
                      ?minSpawnX: Int = 0, maxSpawnX: Int = 0, maxPositionY: Int = 600) {
    this.enemyImage = enemyImage;
    this.spawnMinTime = spawnMinTime;
    this.spawnMaxTime = spawnMaxTime;
    this.minSpawnX = minSpawnX;
    this.maxSpawnX = maxSpawnX;
    this.maxPositionY = maxPositionY;
    currentTime = 0;
    enemies = new Array<Enemy>();
    spawnNextTime = generateRandomSpawnTime(spawnMinTime, spawnMaxTime);
  }

  private function generateRandomSpawnTime(spawnMinTime: Float, spawnMaxTime: Float): Float {
    return spawnMinTime + Math.random() * (spawnMaxTime - spawnMinTime);
  }

  private function generateRandomX(minSpawnX, maxSpawnX): Int {
    return Std.random(maxSpawnX - minSpawnX) + minSpawnX;
  }

  private function spawn(x: Int, y: Int): Void {
      for (i in 0...enemies.length) {
        if (!enemies[i].isActive) {
          enemies[i].activate(x, y);
          return;
        }
      }
      
    enemies.push(new Enemy(x, y, enemyImage));
  }

  public function update(deltaTime: Float) {
    currentTime += deltaTime;

    if (currentTime >= spawnNextTime) {
      currentTime = 0;
      spawnNextTime = generateRandomSpawnTime(spawnMinTime, spawnMaxTime);
      spawn(generateRandomX(minSpawnX, maxSpawnX - enemyImage.width), -enemyImage.height);
    }

    for (i in 0...enemies.length) {
      var enemy = enemies[i];
      enemy.update(deltaTime);

      if (enemy.isActive && enemy.y > maxPositionY) {
        enemy.isActive = false;
      }
    }
  }

  public function render(g: Graphics) {
    for (i in 0...enemies.length) {
      enemies[i].render(g);
    }
  }
}