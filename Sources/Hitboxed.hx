package;

interface Hitboxed {

  public function getHitbox(): Rectangle;
  public function hit(): Void;
}