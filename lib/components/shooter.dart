import 'package:flame/components.dart';
import '../arrow_rush_game.dart';

class Shooter extends SpriteComponent with HasGameRef<ArrowRushGame> {
  final double speed = 300;
  Vector2 moveDirection = Vector2.zero();
  Shooter()
      : super(
          size: Vector2(80, 80),
          anchor: Anchor.center,
        );
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite("blasterF.png");
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - height * 1.5);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += moveDirection * (speed * dt);
    position.x = position.x.clamp(width / 2, gameRef.size.x - width / 2);
  }

  void move(Vector2 direction) {
    moveDirection = direction;
  }

  void stop() {
    moveDirection = Vector2.zero();
  }
}
