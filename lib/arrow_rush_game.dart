import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'components/shooter.dart';
import 'components/bullet.dart';
import 'components/target.dart';
import 'components/background.dart';
import 'components/score_display.dart';

class ArrowRushGame extends FlameGame with HasCollisionDetection, TapDetector {
  late Shooter shooter;
  late Target target;
  late ScoreDisplay scoreDisplay;
  int score = 0;
  double difficultyMultiplier = 1.0;
  final Random random = Random();
  double elapsedTime = 0;
  @override
  Future<void> onLoad() async {
    await images.loadAll([
      "game_background_3.1.png",
      "blasterF.png",
      "foamBulletB.png",
      "targetB_NE.png"
    ]);
    add(GameBackground());
    shooter = Shooter();
    target = Target(difficultyMultiplier);
    scoreDisplay = ScoreDisplay();
    add(shooter);
    add(target);
    add(scoreDisplay);
  }

  void increaseScore() {
    score += 5;
    scoreDisplay.updateScore(score);
    if (score % 20 == 0) {
      difficultyMultiplier += 0.2;
    }
    spawnNewTarget();
  }

  void spawnNewTarget() {
    remove(target);
    target = Target(difficultyMultiplier);
    add(target);
  }

  @override
  void onTap() {
    Vector2 bulletStartPosition = shooter.position.clone()
      ..y -= shooter.height / 2;
    Bullet bullet = Bullet(bulletStartPosition, difficultyMultiplier);
    add(bullet);
    bullet.shoot(Vector2(0, -1));
  }

  @override
  void update(double dt) {
    super.update(dt);
    elapsedTime += dt;
    double moveAmount =
        sin(elapsedTime * (2 + difficultyMultiplier)) * 150 * dt;
    shooter.position.x += moveAmount;
    shooter.position.x = shooter.position.x.clamp(50, size.x - 50);
  }
}
