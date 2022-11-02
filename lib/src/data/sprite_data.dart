import 'package:flame/components.dart';
import 'package:super_island/src/models/character_model.dart';

class SpriteData {
  SpriteData._();

  static CharacterModel shanks2() {
    return CharacterModel(
      image: 'characters/shanks2.png',
      size: Vector2(256, 224),
      standard: SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2(256, 224),
        texturePosition: Vector2(0, 0),
      ),
      run: SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 0.1,
        textureSize: Vector2(256, 224),
        texturePosition: Vector2(0, 256),
        loop: false,
      ),
      attack: SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: 0.3,
        textureSize: Vector2(256, 224),
        texturePosition: Vector2(500, 250),
        loop: false,
      ),
      defense: SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 0.1,
        textureSize: Vector2(256, 224),
        texturePosition: Vector2(256, 235),
        loop: false,
      ),
      special: SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: 0.3,
        textureSize: Vector2(256, 224),
        texturePosition: Vector2(500, 250),
        loop: false,
      ),
    );
  }

  static CharacterModel crocodile1() {
    return CharacterModel(
      image: 'characters/crocodile1.png',
      size: Vector2(192, 224),
      standard: SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2(192, 224),
        texturePosition: Vector2(-35, 0),
      ),
      run: SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: 0.3,
        textureSize: Vector2(192, 224),
        texturePosition: Vector2(-20, 408),
        loop: false,
      ),
      attack: SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: 0.3,
        textureSize: Vector2(192, 224),
        texturePosition: Vector2(410, 408),
      ),
      defense: SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 0.1,
        textureSize: Vector2(256, 224),
        texturePosition: Vector2(256, 235),
        loop: false,
      ),
      special: SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: 0.3,
        textureSize: Vector2(256, 224),
        texturePosition: Vector2(500, 250),
        loop: false,
      ),
    );
  }
}
