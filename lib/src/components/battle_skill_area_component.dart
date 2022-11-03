import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:super_island/src/game/battle_game.dart';
import 'package:super_island/src/models/character_model.dart';

class BattleSkillAreaComponent extends SpriteAnimationComponent
    with HasGameRef<BattleGame> {
  BattleSkillAreaComponent({
    required this.character,
    this.isFlip = false,
  }) : super() {
    priority = 4;
    debugMode = false;
  }
  final CharacterModel character;
  final bool isFlip;

  final _spriteAnimation = SpriteAnimationComponent();

  @override
  Future<void>? onLoad() async {
    position = Vector2(gameRef.size.x / 1.60, gameRef.size.x / 15);
    scale = Vector2.all(2.5);
    await _setSpriteAnimation(character.attack);
    if (isFlip) {
      _spriteAnimation.flipHorizontallyAroundCenter();
    }
    await add(_spriteAnimation);
    return super.onLoad();
  }

  Future<void> hideArea() async {
    await _spriteAnimation
        .add(OpacityEffect.fadeOut(EffectController(duration: 0.2)));
  }

  Future<void> _setSpriteAnimation(
      SpriteAnimationData spriteAnimationData) async {
    final sprite = await Images().load(character.image);
    final spriteAnimationComponent =
        SpriteAnimationComponent.fromFrameData(sprite, spriteAnimationData);
    _spriteAnimation
      ..animation = spriteAnimationComponent.animation
      ..size = character.attack.frames.first.srcSize * (gameRef.size.y / 800);
  }
}
