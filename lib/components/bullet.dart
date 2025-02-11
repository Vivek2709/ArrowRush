import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../arrow_rush_game.dart';
import 'target.dart';

class Bullet extends SpriteComponent
    with HasGameRef<ArrowRushGame>, CollisionCallbacks {
  double speed;
  Vector2 direction = Vector2(0, -1);
  Bullet(Vector2 startPosition, double difficultyMultiplier)
      : speed = 500 * difficultyMultiplier,
        super(
          size: Vector2(15, 15),
          anchor: Anchor.center,
          priority: 2,
        ) {
    position = startPosition;
  }
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite("foamBulletB.png");
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += direction * (speed * dt);
    if (position.y < 0) {
      removeFromParent();
    }
  }

  void shoot(Vector2 newDirection) {
    direction = newDirection;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Target) {
      removeFromParent();
      other.removeFromParent();
      gameRef.increaseScore();
    }
  }
}
