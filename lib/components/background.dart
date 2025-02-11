import 'package:flame/components.dart';

class GameBackground extends SpriteComponent {
  GameBackground() : super(priority: -1);
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load("game_background_3.1.png");
    size = Vector2(360, 780);
  }
}
