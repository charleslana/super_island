import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class SkillComponent extends PositionComponent {
  SkillComponent(this.refSize) : super(size: refSize);

  final Vector2 refSize;

  final _paint = Paint()..color = const Color(0xffffffff);

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    position.y = size.y / 1.35;
    _paint.color = Colors.black.withOpacity(0.5);
  }

  @override
  void render(Canvas canvas) {
    debugMode = false;
    canvas.drawRect(size.toRect(), _paint);
  }
}
