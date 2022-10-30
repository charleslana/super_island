import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:super_island/src/components/damage_component.dart';
import 'package:super_island/src/components/empty_bar_component.dart';
import 'package:super_island/src/enums/bar_enum.dart';
import 'package:super_island/src/enums/character_move_enum.dart';
import 'package:super_island/src/game/battle_game.dart';

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

  Vector2 starterPosition = Vector2.all(0);
  final spriteAnimation = SpriteAnimationComponent();

  Vector2 _screenSize = Vector2.all(0);
  TextComponent? _textComponent;
  late EmptyBarComponent _lifeBar;

  @override
  Future<void>? onLoad() async {
    _screenSize = gameRef.size;
    _setDataComponent();
    await _setSpriteAnimation(_getStandardSprite());
    if (isFlip) {
      spriteAnimation.flipHorizontallyAroundCenter();
    }
    _lifeBar = EmptyBarComponent(bar: BarEnum.life, flip: isFlip);
    await spriteAnimation.add(_lifeBar);
    await add(spriteAnimation);
    await add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is CharacterComponent) {}
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
      ..size = Vector2(256, 224) * (_screenSize.y / 800);
  }

  void _setDataComponent() {
    starterPosition = Vector2(characterPosition.x * (_screenSize.x / 1),
        characterPosition.y * (_screenSize.y / 1));
    size = Vector2(256, 224) * (_screenSize.y / 800);
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
    _textComponent = DamageComponent(flip: flip);
    if (_textComponent?.parent != null) {
      spriteAnimation.remove(_textComponent!);
    }
    spriteAnimation.add(_textComponent!);
  }

  void removeDamage() {
    if (_textComponent?.parent != null) {
      spriteAnimation.remove(_textComponent!);
    }
  }

  void changeLife() {
    _lifeBar.changeLife();
  }

  void toggleBar({bool isShow = true}) {
    _lifeBar.toggleBar(isShow: isShow);
  }
}
