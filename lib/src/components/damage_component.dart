import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class DamageComponent extends SpriteAnimationComponent {
  DamageComponent({this.flip = false})
      : super(
          priority: 2,
          size: Vector2.all(100),
        );

  final bool flip;

  final _paint = Paint()..color = Colors.transparent;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    position
      ..y = size.x / 100
      ..x = size.x / 100;
    this.size = Vector2(size.x / 7, size.y / 4);
  }

  @mustCallSuper
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    debugMode = false;
    const textStyle = TextStyle(
      color: Colors.red,
      fontSize: 30,
      fontFamily: 'PoetsenOne',
      shadows: [
        Shadow(offset: Offset(-1.5, -1.5)),
        Shadow(offset: Offset(1.5, -1.5)),
        Shadow(offset: Offset(1.5, 1.5)),
        Shadow(offset: Offset(-1.5, 1.5)),
      ],
    );
    const textSpan = TextSpan(
      text: '- 100K',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textScaleFactor: size.y / 100,
      textAlign: TextAlign.center,
    )..layout(
        maxWidth: size.x,
      );
    final xCenter = (size.x - textPainter.width) / 2;
    final yCenter = (size.y - textPainter.height) / 2;
    final offset = Offset(xCenter, yCenter);
    canvas.drawRect(size.toRect(), _paint);
    textPainter.paint(canvas, offset);
  }

  @override
  Future<void>? onLoad() {
    if (flip) {
      flipHorizontallyAroundCenter();
    }
    add(
      OpacityEffect.fadeOut(
        EffectController(
          duration: 1.5,
          reverseDuration: 1.5,
          infinite: true,
        ),
      ),
    );
    return super.onLoad();
  }
}
