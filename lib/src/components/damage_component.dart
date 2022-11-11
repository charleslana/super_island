import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:super_island/src/utils/app_theme.dart';
import 'package:super_island/src/utils/utils.dart';

class DamageComponent extends TextComponent {
  DamageComponent({this.flip = false})
      : super(
          priority: 1,
          size: Vector2.all(100),
        );

  final bool flip;

  late TextComponent _textComponent;

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
      style: dinRegular().copyWith(
        color: Colors.red,
        fontSize: size.y / 2,
        shadows: const [
          Shadow(offset: Offset(-1.5, -1.5)),
          Shadow(offset: Offset(1.5, -1.5)),
          Shadow(offset: Offset(1.5, 1.5)),
          Shadow(offset: Offset(-1.5, 1.5)),
        ],
      ),
    );
    _textComponent = TextComponent(
      text: '-${numberAbbreviation(145210)}',
      textRenderer: textPaint,
      size: Vector2(size.x / 7, size.y / 3),
      position: Vector2(size.x / 6.5, size.y / 50),
    );
    add(_textComponent);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (_textComponent.y > (size.y - (size.y / 1.7) * 2.3)) {
      _textComponent.y -= size.y / 50;
    }
    super.update(dt);
  }
}
