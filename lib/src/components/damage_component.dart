import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class DamageComponent extends TextComponent {
  DamageComponent({this.flip = false})
      : super(
          priority: 2,
          size: Vector2.all(100),
        );

  final bool flip;

  late TextComponent textComponent;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    position
      ..y = size.x / 100
      ..x = size.x / 100;
    this.size = Vector2(size.x / 7, size.y / 4);
  }

  @override
  Future<void>? onLoad() {
    debugMode = false;
    if (flip) {
      flipHorizontallyAroundCenter();
    }
    final textPaint = TextPaint(
      style: TextStyle(
        color: Colors.red,
        fontSize: size.x / 4,
        fontFamily: 'PoetsenOne',
        shadows: const [
          Shadow(offset: Offset(-1.5, -1.5)),
          Shadow(offset: Offset(1.5, -1.5)),
          Shadow(offset: Offset(1.5, 1.5)),
          Shadow(offset: Offset(-1.5, 1.5)),
        ],
      ),
    );
    textComponent = TextComponent(
      text: '-100K',
      textRenderer: textPaint,
      size: Vector2(size.x / 7, size.y / 3),
      position: Vector2(size.x / 6.5, size.y / 50),
    );
    // textComponent
    //   ..add(
    //     OpacityEffect.fadeOut(
    //       EffectController(
    //         duration: 1.5,
    //         reverseDuration: 1.5,
    //         infinite: true,
    //       ),
    //     ),
    //   );
    add(textComponent);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (textComponent.y > (size.y - (size.y / 1.7) * 2.3)) {
      textComponent.y -= size.y / 50;
    }
    super.update(dt);
  }
}
