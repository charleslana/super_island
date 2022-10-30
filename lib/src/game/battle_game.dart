import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_island/src/components/battle_bg_component.dart';
import 'package:super_island/src/components/battle_sound_component.dart';
import 'package:super_island/src/components/character_component.dart';
import 'package:super_island/src/components/skill_action_component.dart';
import 'package:super_island/src/components/skill_component.dart';
import 'package:super_island/src/enums/character_move_enum.dart';
import 'package:super_island/src/game/character_position.dart';
import 'package:super_island/src/providers/battle_provider.dart';

class BattleGame extends FlameGame
    with HasTappableComponents, HasCollisionDetection {
  BattleGame(this.ref);

  final WidgetRef ref;

  late CharacterComponent player1;

  late CharacterComponent enemy1;

  @override
  Color backgroundColor() {
    return Colors.white;
  }

  @override
  Future<void>? onLoad() async {
    // await loadBattleAudio();

    await add(BattleBgComponent());
    await add(BattleSoundComponent());

    player1 = CharacterComponent(
      characterImage: 'characters/shanks2.png',
      characterPosition: left1,
    );
    await add(player1);

    enemy1 = CharacterComponent(
      characterImage: 'characters/shanks2.png',
      characterPosition: right1,
      isFlip: true,
    );
    await add(enemy1);

    await add(SkillComponent(size));
    await add(SkillActionComponent());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    final battleWatch = ref.watch(battleProvider);
    _run(battleWatch);
    _collision(battleWatch);
    _standard(battleWatch);
    super.update(dt);
  }

  @override
  void onRemove() {
    FlameAudio.bgm.dispose();
  }

  Future<void> _run(BattleProvider battleWatch) async {
    if (battleWatch.move == CharacterMoveEnum.run &&
        !player1.isColliding &&
        (player1.size.x + player1.x) < size.x) {
      await player1.setSprite(battleWatch.move);
      player1
        ..priority = 1
        ..x += size.x / 70;
      print('run');
    }
  }

  Future<void> _collision(BattleProvider battleWatch) async {
    if (player1.isColliding && battleWatch.move == CharacterMoveEnum.run) {
      ref.read(battleProvider.notifier).move = CharacterMoveEnum.attack;
      await player1.setSprite(CharacterMoveEnum.attack);
      Future.delayed(const Duration(milliseconds: 300), () async {
        await FlameAudio.play('shanks1.wav');
      });
      print('collision');
      _defense();
      player1.spriteAnimation.animation?.onComplete = () async {
        await player1.setSprite(CharacterMoveEnum.standard);
        ref.read(battleProvider.notifier).move = CharacterMoveEnum.standard;
        print('fim da animação de ataque');
        Future.delayed(const Duration(milliseconds: 300), () async {
          player1
            ..changeRage(10)
            ..toggleBar();
        });
      };
    }
  }

  void _defense() {
    Future.delayed(const Duration(milliseconds: 300), () async {
      await enemy1.setSprite(CharacterMoveEnum.defense);
      enemy1
        ..setDamageColor()
        ..removeDamage()
        ..setDamage(flip: true)
        ..changeLife(25)
        ..changeRage(50);
      enemy1.spriteAnimation.animation?.onComplete = () async {
        Future.delayed(const Duration(milliseconds: 200), () async {
          await enemy1.setSprite(CharacterMoveEnum.standard);
        });
        Future.delayed(const Duration(milliseconds: 400), () async {
          enemy1.removeDamage();
        });
      };
    });
  }

  void _standard(BattleProvider battleWatch) {
    if (battleWatch.move == CharacterMoveEnum.standard &&
        player1.x > player1.starterPosition.x) {
      player1
        ..priority = 0
        ..x -= size.x / 70;
      print('standard');
    }
  }

  Future<void> loadBattleAudio() async {
    await FlameAudio.audioCache.loadAll(['shanks1.wav', 'bgm_wano.mp3']);
    FlameAudio.bgm.initialize();
    await FlameAudio.bgm.stop();
    await FlameAudio.bgm.play('bgm_wano.mp3', volume: .50);
  }
}
