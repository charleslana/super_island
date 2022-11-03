import 'package:flame/components.dart';
import 'package:super_island/src/models/character_model.dart';

class SpriteData {
  SpriteData._();

  static CharacterModel shanks2() {
    return CharacterModel(
      image: 'characters/shanks2.png',
      audio: 'shanks1.wav',
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
    );
  }

  static CharacterModel crocodile1() {
    return CharacterModel(
      image: 'characters/crocodile1.png',
      audio: 'crocodile1.wav',
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
        textureSize: Vector2(192, 200),
        texturePosition: Vector2(270, 215),
        loop: false,
      ),
    );
  }

  static CharacterModel enel1() {
    return CharacterModel(
      image: 'characters/enel1.png',
      audio: 'enel1.wav',
      standard: SpriteAnimationData.sequenced(
        amount: 7,
        stepTime: 0.1,
        textureSize: Vector2(144, 230),
        texturePosition: Vector2(0, 30),
      ),
      run: SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.3,
        textureSize: Vector2(204, 224),
        texturePosition: Vector2(-15, 790),
        loop: false,
      ),
      attack: SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 0.3,
        textureSize: Vector2(150, 200),
        texturePosition: Vector2(675, 554),
        loop: false,
      ),
      defense: SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 0.1,
        textureSize: Vector2(144, 230),
        texturePosition: Vector2(15, 320),
        loop: false,
      ),
    );
  }
}
