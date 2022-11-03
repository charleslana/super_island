import 'package:flame/particles.dart';

class CharacterModel {
  CharacterModel({
    required this.image,
    required this.audio,
    required this.standard,
    required this.run,
    required this.attack,
    required this.defense,
  });

  final String image;
  final String audio;
  final SpriteAnimationData standard;
  final SpriteAnimationData run;
  final SpriteAnimationData attack;
  final SpriteAnimationData defense;
}
