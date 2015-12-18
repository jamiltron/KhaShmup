package;

class CollisionHandler {

  // checks if 2 entities collide, and if so 'hits' them both
  public static function handleBiCollision(h1: Hitboxed, h2: Hitboxed): Void {
    if (testCollision(h1, h2)) {
      h1.hit();
      h2.hit();
    }
  }

  public static function handleGroupCollisions(leftGroup: Array<Hitboxed>, rightGroup: Array<Hitboxed>): Void {
    for (left in leftGroup) {
      for (right in rightGroup) {
        handleBiCollision(left, right);
      }
    }
  }

  public static function testCollision(h1: Hitboxed, h2: Hitboxed): Bool {
    return h1.getHitbox().overlaps(h2.getHitbox());
  }

}