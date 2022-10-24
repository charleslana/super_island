import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:super_island/src/game/battle_game.dart';

class CharacterComponent extends PositionComponent with HasGameRef<BattleGame> {
  CharacterComponent({
    required this.characterImage,
    required this.characterPosition,
    this.isFlip = false,
  }) : super() {
    debugMode = false;
  }

  final String characterImage;
  final Vector2 characterPosition;
  final bool isFlip;

  Vector2 screenSize = Vector2.all(0);
  Vector2 starterPosition = Vector2.all(0);

  @override
  Future<void>? onLoad() async {
    screenSize = gameRef.size;
    starterPosition = Vector2(characterPosition.x * (screenSize.x / 1),
        characterPosition.y * (screenSize.y / 1));
    size = Vector2(640, 512) * (screenSize.y / 2000);
    position = starterPosition;

    final component = SpriteComponent()
      ..sprite = await Sprite.load(characterImage)
      ..size = Vector2(640, 512) * (screenSize.y / 2000);
    if (isFlip) {
      component.flipHorizontallyAroundCenter();
    }
    await add(component);
    await add(RectangleHitbox());
    return super.onLoad();
  }
}
