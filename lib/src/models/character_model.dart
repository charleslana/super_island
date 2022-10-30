import 'package:flame/extensions.dart';
import 'package:flame/particles.dart';

class CharacterModel {
  CharacterModel({
    required this.image,
    required this.size,
    required this.standard,
    required this.run,
    required this.attack,
    required this.defense,
    required this.special,
  });

  final String image;
  final Vector2 size;
  final SpriteAnimationData standard;
  final SpriteAnimationData run;
  final SpriteAnimationData attack;
  final SpriteAnimationData defense;
  final SpriteAnimationData special;
}
