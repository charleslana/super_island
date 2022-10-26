import 'package:flame/components.dart';
import 'package:super_island/src/game/battle_game.dart';

class BattleBgComponent extends PositionComponent with HasGameRef<BattleGame> {
  @override
  Future<void>? onLoad() async {
    final component = SpriteComponent()
      ..sprite = await Sprite.load('battle/bg/1.png')
      ..size = gameRef.size;
    await add(component);
    return super.onLoad();
  }
}
