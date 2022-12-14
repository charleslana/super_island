import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:super_island/src/enums/character_move_enum.dart';
import 'package:super_island/src/game/battle_game.dart';
import 'package:super_island/src/providers/battle_provider.dart';

class SkillActionComponent extends PositionComponent
    with HasGameRef<BattleGame>, TapCallbacks {
  SkillActionComponent(this.order)
      : super(
          anchor: Anchor.center,
          size: Vector2.all(100),
        );

  final int order;

  final _paint = Paint()..color = const Color(0xffffffff);

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    position
      ..y = size.y / 1.15
      ..x = size.x / 10 * order;
    this.size = Vector2(size.x / 10, size.y / 5);
    _paint.color = Colors.deepPurple;
  }

  @override
  void render(Canvas canvas) {
    debugMode = false;
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 30,
      decoration: TextDecoration.underline,
    );
    final textSpan = TextSpan(
      text: '$order',
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
  void onTapUp(TapUpEvent event) {
    if (order == 8) {
      gameRef.ref.read(battleProvider.notifier).isReverse =
          !gameRef.ref.watch(battleProvider).isReverse;
      return;
    }
    if (order == 7) {
      if (gameRef.ref.watch(battleProvider).hit >= 6) {
        gameRef.ref.read(battleProvider.notifier).hit = 1;
        return;
      }
      gameRef.ref.read(battleProvider.notifier).hit++;
      return;
    }
    if (gameRef.ref.watch(battleProvider).move == CharacterMoveEnum.standard) {
      gameRef.ref.read(battleProvider.notifier)
        ..start = order
        ..move = CharacterMoveEnum.run;
      if (order >= 4 && order < 6) {
        gameRef.areaPlayer();
        return;
      }
      if (order > 5) {
        gameRef.magicPlayer();
        return;
      }
      gameRef.movePlayer();
    }
    super.onTapUp(event);
  }
}
