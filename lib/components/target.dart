import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../arrow_rush_game.dart';

class Target extends SpriteComponent
    with HasGameRef<ArrowRushGame>, CollisionCallbacks {
  static const double baseSpeed = 100;
  bool movingRight = true;
  double speed;
  Target(double difficultyMultiplier)
      : speed = baseSpeed * difficultyMultiplier,
        super(anchor: Anchor.center, priority: 3);
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite("targetB_NE.png");
    size = Vector2(80, 80);
    position = Vector2(gameRef.size.x / 2, 100);
    add(RectangleHitbox(size: size * 0.9));
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (movingRight) {
      position.x += speed * dt;
      if (position.x > gameRef.size.x - size.x) movingRight = false;
    } else {
      position.x -= speed * dt;
      if (position.x < 0) movingRight = true;
    }
  }

  void hitByBullet() {
    removeFromParent();
    gameRef.increaseScore();
  }
}
