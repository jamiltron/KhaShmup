package;

import kha.Scheduler;

class Timer {
  public var deltaTime(default, null): Float;
  public var lastTime(default, null): Float;

  public function new() {
    reset();
  }

  public function update() {
    var currentTime = Scheduler.time();
    deltaTime = currentTime - lastTime;
    lastTime = currentTime;
  }

  public function reset() {
    lastTime = Scheduler.time();
    deltaTime = 0;
  }
}