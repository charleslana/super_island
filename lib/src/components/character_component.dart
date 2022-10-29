import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:super_island/src/components/damage_component.dart';
import 'package:super_island/src/enums/character_move_enum.dart';
import 'package:super_island/src/game/battle_game.dart';
import 'package:super_island/src/providers/battle_provider.dart';

class CharacterComponent extends SpriteAnimationComponent
    with HasGameRef<BattleGame>, CollisionCallbacks {
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

  final spriteAnimation = SpriteAnimationComponent();
  bool isDefense = false;
  TextComponent? textComponent;

  @override
  Future<void>? onLoad() async {
    screenSize = gameRef.size;
    _setDataComponent();
    await _setSpriteAnimation(_getStandardSprite());
    if (isFlip) {
      spriteAnimation.flipHorizontallyAroundCenter();
    }
    await add(spriteAnimation);
    await add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is CharacterComponent &&
        gameRef.ref.watch(battleProvider).move == CharacterMoveEnum.run) {
      gameRef.ref.read(battleProvider.notifier)
        ..move = CharacterMoveEnum.attack
        ..isAttack = true;
    }
    super.onCollision(intersectionPoints, other);
  }

  Future<void> setSprite(CharacterMoveEnum move) async {
    switch (move) {
      case CharacterMoveEnum.standard:
        await _setSpriteAnimation(_getStandardSprite());
        break;
      case CharacterMoveEnum.run:
        await _setSpriteAnimation(_getRunSprite());
        break;
      case CharacterMoveEnum.attack:
        await _setSpriteAnimation(_getAttackSprite());
        gameRef.ref.read(battleProvider.notifier).move =
            CharacterMoveEnum.standard;
        break;
      case CharacterMoveEnum.defense:
        await _setSpriteAnimation(_getDefenseSprite());
        break;
      default:
        await _setSpriteAnimation(_getStandardSprite());
    }
  }

  Future<void> _setSpriteAnimation(
      SpriteAnimationData spriteAnimationData) async {
    final sprite = await Images().load(characterImage);
    final spriteAnimationComponent =
        SpriteAnimationComponent.fromFrameData(sprite, spriteAnimationData);
    spriteAnimation
      ..animation = spriteAnimationComponent.animation
      ..size = Vector2(256, 224) * (screenSize.y / 800);
  }

  void _setDataComponent() {
    starterPosition = Vector2(characterPosition.x * (screenSize.x / 1),
        characterPosition.y * (screenSize.y / 1));
    size = Vector2(256, 224) * (screenSize.y / 800);
    size.x = size.x / 2;
    position = starterPosition;
  }

  SpriteAnimationData _getStandardSprite() {
    return SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(256, 224),
      texturePosition: Vector2(0, 0),
    );
  }

  SpriteAnimationData _getRunSprite() {
    return SpriteAnimationData.sequenced(
      amount: 1,
      stepTime: 0.1,
      textureSize: Vector2(256, 224),
      texturePosition: Vector2(0, 256),
      loop: false,
    );
  }

  SpriteAnimationData _getAttackSprite() {
    return SpriteAnimationData.sequenced(
      amount: 2,
      stepTime: 0.3,
      textureSize: Vector2(256, 224),
      texturePosition: Vector2(500, 250),
      loop: false,
    );
  }

  SpriteAnimationData _getDefenseSprite() {
    return SpriteAnimationData.sequenced(
      amount: 1,
      stepTime: 0.1,
      textureSize: Vector2(256, 224),
      texturePosition: Vector2(256, 235),
      loop: false,
    );
  }

  void setDamageColor() {
    spriteAnimation.add(
      ColorEffect(
        Colors.white,
        const Offset(
          0,
          1,
        ),
        EffectController(
          duration: 0.1,
          reverseDuration: 0.1,
        ),
      ),
    );
  }

  void setDamage({bool flip = false}) {
    textComponent = DamageComponent(flip: flip);
    if (textComponent?.parent != null) {
      spriteAnimation.remove(textComponent!);
    }
    spriteAnimation.add(textComponent!);
  }

  void removeDamage() {
    if (textComponent?.parent != null) {
      spriteAnimation.remove(textComponent!);
    }
  }
}
