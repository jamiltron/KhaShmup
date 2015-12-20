package;

import kha.Image;

class Animation {
  private var currentTime: Float;
  private var index: Int;

  public var playState: PlayState;
  public var frames: Array<Image>;
  public var frameDuration: Float;
  public var isDone(get, null): Bool;

  private function get_isDone(): Bool {
    return (Type.enumEq(playState, PlayState.Once) &&
            index >= frames.length);
  }

  public function new(frameDuration: Float, frames: Array<Image>, playState: PlayState) {
    this.playState = playState;
    this.frameDuration = frameDuration;
    this.frames = frames;
    index = 0;
  }

  public function reset(): Void {
    index = 0;
    currentTime = 0;
  }

  public function update(deltaTime: Float) {
    currentTime += deltaTime;

    if (currentTime >= frameDuration) {
      currentTime -= frameDuration;
      index += 1;
    }

    if (index >= frames.length) {
      if (Type.enumEq(playState, PlayState.Loop)) {
        index = 0;
      } else {
        index = frames.length;
      }
    }
  }

  public function getCurrentFrame(): Image {
    return frames[index];
  }

  public function getFrame(i: Int): Image {
    return frames[i];
  }

}