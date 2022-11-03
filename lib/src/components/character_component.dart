import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:super_island/src/enums/character_move_enum.dart';
import 'package:super_island/src/models/character_model.dart';

class CharacterComponent extends SpriteAnimationComponent {
  CharacterComponent(this.model) : super() {
    debugMode = false;
  }

  final CharacterModel model;

  final spriteAnimation = SpriteAnimationComponent();

  @override
  Future<void>? onLoad() async {
    await _setSpriteAnimation(model.standard);
    await add(spriteAnimation);
    return super.onLoad();
  }

  Future<void> setSprite(CharacterMoveEnum move) async {
    switch (move) {
      case CharacterMoveEnum.standard:
        await _setSpriteAnimation(model.standard);
        break;
      case CharacterMoveEnum.run:
        await _setSpriteAnimation(model.run);
        break;
      case CharacterMoveEnum.attack:
        await _setSpriteAnimation(model.attack);
        break;
      case CharacterMoveEnum.defense:
        await _setSpriteAnimation(model.defense);
        break;
      case CharacterMoveEnum.special:
        await _setSpriteAnimation(model.special);
        break;
      default:
        await _setSpriteAnimation(model.standard);
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

  Future<void> _setSpriteAnimation(
      SpriteAnimationData spriteAnimationData) async {
    final sprite = await Images().load(model.image);
    final spriteAnimationComponent =
        SpriteAnimationComponent.fromFrameData(sprite, spriteAnimationData);
    spriteAnimation
      ..animation = spriteAnimationComponent.animation
      ..size = model.size;
  }
}
