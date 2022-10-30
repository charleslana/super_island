import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:super_island/src/components/battle_shadow_component.dart';
import 'package:super_island/src/components/damage_component.dart';
import 'package:super_island/src/components/empty_bar_component.dart';
import 'package:super_island/src/enums/bar_enum.dart';
import 'package:super_island/src/enums/character_move_enum.dart';
import 'package:super_island/src/game/battle_game.dart';
import 'package:super_island/src/models/character_model.dart';

class CharacterComponent extends SpriteAnimationComponent
    with HasGameRef<BattleGame>, CollisionCallbacks {
  CharacterComponent({
    required this.character,
    required this.characterPosition,
    required this.characterPriority,
    this.collisionType = CollisionType.active,
    this.isFlip = false,
  }) : super() {
    priority = 1;
    debugMode = false;
  }

  final CharacterModel character;
  final Vector2 characterPosition;
  final int characterPriority;
  final CollisionType collisionType;
  final bool isFlip;

  Vector2 starterPosition = Vector2.all(0);
  final spriteAnimation = SpriteAnimationComponent();

  Vector2 _screenSize = Vector2.all(0);
  TextComponent? _textComponent;
  late EmptyBarComponent _lifeBar;
  late EmptyBarComponent _rageBar;

  @override
  Future<void>? onLoad() async {
    priority = characterPriority;
    _screenSize = gameRef.size;
    _setDataComponent();
    await _setSpriteAnimation(character.standard);
    if (isFlip) {
      spriteAnimation.flipHorizontallyAroundCenter();
    }
    await _addLifeBar();
    await _addRageBar();
    await spriteAnimation.add(BattleShadowComponent());
    await add(spriteAnimation);
    await add(RectangleHitbox()..collisionType = collisionType);
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
        await _setSpriteAnimation(character.standard);
        break;
      case CharacterMoveEnum.run:
        await _setSpriteAnimation(character.run);
        break;
      case CharacterMoveEnum.attack:
        await _setSpriteAnimation(character.attack);
        break;
      case CharacterMoveEnum.defense:
        await _setSpriteAnimation(character.defense);
        break;
      case CharacterMoveEnum.special:
        await _setSpriteAnimation(character.special);
        break;
      default:
        await _setSpriteAnimation(character.standard);
    }
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

  void changeLife(int size) {
    _lifeBar.changeLife(size);
  }

  void toggleBar({bool isShow = true}) {
    _lifeBar.toggleBar(isShow: isShow);
    _rageBar.toggleBar(isShow: isShow);
  }

  void changeRage(int size) {
    _rageBar.changeRage(size);
  }

  Future<void> _setSpriteAnimation(
      SpriteAnimationData spriteAnimationData) async {
    final sprite = await Images().load(character.image);
    final spriteAnimationComponent =
        SpriteAnimationComponent.fromFrameData(sprite, spriteAnimationData);
    spriteAnimation
      ..animation = spriteAnimationComponent.animation
      ..size = character.size * (_screenSize.y / 800);
  }

  void _setDataComponent() {
    starterPosition = Vector2(characterPosition.x * (_screenSize.x / 1),
        characterPosition.y * (_screenSize.y / 1));
    size = character.size * (_screenSize.y / 800);
    size.x = size.x / 2;
    position = starterPosition;
  }

  Future<void> _addRageBar() async {
    _rageBar = EmptyBarComponent(
      barScale: Vector2(gameRef.size.y / 1000 * 2, gameRef.size.y / 1000 * 1.5),
      barPosition: Vector2(
          gameRef.size.y / 20, (-gameRef.size.y - gameRef.size.y) / 120),
      bar: BarEnum.rage,
      flip: isFlip,
    );
    await spriteAnimation.add(_rageBar);
  }

  Future<void> _addLifeBar() async {
    _lifeBar = EmptyBarComponent(
      bar: BarEnum.life,
      barScale: Vector2.all(gameRef.size.y / 1000 * 2),
      barPosition:
          Vector2(gameRef.size.y / 20, (-gameRef.size.y - gameRef.size.y) / 60),
      barPriority: 1,
      flip: isFlip,
    );
    await spriteAnimation.add(_lifeBar);
  }
}
