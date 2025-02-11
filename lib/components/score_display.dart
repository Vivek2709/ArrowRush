import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ScoreDisplay extends TextComponent with HasGameRef {
  ScoreDisplay() : super(anchor: Anchor.topCenter);
  @override
  Future<void> onLoad() async {
    position = Vector2(gameRef.size.x / 2, 20);
    textRenderer = TextPaint(
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        shadows: [
          Shadow(blurRadius: 5, color: Colors.black),
        ],
      ),
    );
    text = "Score: 0";
  }

  void updateScore(int newScore) {
    text = "Score: $newScore";
  }
}
