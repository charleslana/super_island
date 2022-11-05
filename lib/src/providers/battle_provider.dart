import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_island/src/enums/character_move_enum.dart';

final battleProvider = ChangeNotifierProvider(
  (ref) => BattleProvider(CharacterMoveEnum.standard),
);

class BattleProvider extends ValueNotifier<dynamic> {
  BattleProvider(this.move) : super(move);

  CharacterMoveEnum move;

  int start = 1;

  int hit = 1;

  bool isReverse = false;

  Future<void> toggleAudio({bool playAudio = true}) async {
    if (playAudio) {
      await FlameAudio.bgm.play('bgm_wano.mp3', volume: .50);
      return;
    }
    await FlameAudio.bgm.stop();
  }
}
