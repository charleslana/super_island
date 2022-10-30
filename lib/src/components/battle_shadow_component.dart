import 'package:flame/components.dart';
import 'package:super_island/src/game/battle_game.dart';

class BattleShadowComponent extends PositionComponent
    with HasGameRef<BattleGame> {
  late SpriteComponent _spriteComponent;

  @override
  Future<void>? onLoad() async {
    debugMode = false;
    size = Vector2(85, 53);
    scale = Vector2(85 * gameRef.size.y / 60000, 53 * gameRef.size.y / 60000);
    position = Vector2(gameRef.size.y / 10, gameRef.size.y / 4.5);
    _spriteComponent = SpriteComponent()
      ..sprite = await Sprite.load('characters/shadow.png')
      ..size = size;
    await add(_spriteComponent);
    return super.onLoad();
  }
}
