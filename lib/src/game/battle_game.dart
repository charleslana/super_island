import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_island/src/components/battle_bg_component.dart';
import 'package:super_island/src/components/battle_skill_area_component.dart';
import 'package:super_island/src/components/battle_sound_component.dart';
import 'package:super_island/src/components/character_component.dart';
import 'package:super_island/src/components/character_position_component.dart';
import 'package:super_island/src/components/skill_action_component.dart';
import 'package:super_island/src/components/skill_component.dart';
import 'package:super_island/src/data/sprite_data.dart';
import 'package:super_island/src/enums/character_move_enum.dart';
import 'package:super_island/src/providers/battle_provider.dart';

class BattleGame extends FlameGame with HasTappableComponents {
  BattleGame(this.ref);

  final WidgetRef ref;

  late CharacterPositionComponent player;
  late CharacterPositionComponent player1;
  late CharacterPositionComponent player2;
  late CharacterPositionComponent player3;
  late CharacterPositionComponent player4;
  late CharacterPositionComponent player5;
  late CharacterPositionComponent player6;

  late CharacterPositionComponent enemy;
  late CharacterPositionComponent enemy1;
  late CharacterPositionComponent enemy2;
  late CharacterPositionComponent enemy3;
  late CharacterPositionComponent enemy4;
  late CharacterPositionComponent enemy5;
  late CharacterPositionComponent enemy6;

  @override
  Color backgroundColor() {
    return Colors.white;
  }

  @override
  Future<void>? onLoad() async {
    // await _loadBattleAudio();
    await add(BattleBgComponent());
    await add(BattleSoundComponent());
    await _addPlayers();
    await _addEnemies();
    await add(SkillComponent(size));
    await add(SkillActionComponent(1));
    await add(SkillActionComponent(2));
    await add(SkillActionComponent(3));
    await add(SkillActionComponent(4));
    await add(SkillActionComponent(5));
    await add(SkillActionComponent(6));
    await add(SkillActionComponent(7));
    return super.onLoad();
  }

  @override
  void onRemove() {
    FlameAudio.bgm.dispose();
  }

  Future<void> move() async {
    _startPlayer(ref.watch(battleProvider).start);
    _hitPlayer(ref.watch(battleProvider).hit);
    await player.character.setSprite(CharacterMoveEnum.run);
    player
      ..priority = 1
      ..toggleBar(isShow: false);
    await player.add(
      MoveToEffect(
        Vector2(enemy.position.x - (size.y / 2.2), enemy.position.y),
        EffectController(duration: 0.5),
      )..onComplete = () async {
          await _attack();
        },
    );
  }

  Future<void> area() async {
    _startPlayer(ref.watch(battleProvider).start);
    _hitPlayer(ref.watch(battleProvider).hit);
    await player.character.setSprite(CharacterMoveEnum.run);
    final battleSkillAreaComponent =
        BattleSkillAreaComponent(character: player.character.model);
    await add(battleSkillAreaComponent);
    await FlameAudio.play(player.character.model.audio);
    await _defenseAll();
    player.character.spriteAnimation.animation?.onComplete = () async {
      await player.character.setSprite(CharacterMoveEnum.standard);
      player
        ..changeRage(10)
        ..toggleBar();
      ref.read(battleProvider.notifier).move = CharacterMoveEnum.standard;
      await battleSkillAreaComponent.hideArea();
    };
  }

  Future<void> magic() async {
    _startPlayer(ref.watch(battleProvider).start);
    _hitPlayer(ref.watch(battleProvider).hit);
    await player.character.setSprite(CharacterMoveEnum.run);
  }

  Future<void> _defenseAll() async {
    final enemies = [
      enemy1,
      enemy2,
      enemy3,
      enemy4,
      enemy5,
      enemy6,
    ];
    for (final e in enemies) {
      await e.character.setSprite(CharacterMoveEnum.defense);
      e.character.setDamageColor();
      e.removeDamage();
      await e.setDamage(flip: true);
      e
        ..changeLife(25)
        ..changeRage(50);
      Future.delayed(const Duration(milliseconds: 500), () async {
        await e.character.setSprite(CharacterMoveEnum.standard);
        e.removeDamage();
        await e.character.setSprite(CharacterMoveEnum.standard);
      });
    }
  }

  Future<void> _attack() async {
    await player.character.setSprite(CharacterMoveEnum.attack);
    player.priority = 5;
    Future.delayed(const Duration(milliseconds: 300), () async {
      await FlameAudio.play(player.character.model.audio);
      await _defense();
    });
  }

  Future<void> _defense() async {
    await enemy.character.setSprite(CharacterMoveEnum.defense);
    enemy.character.setDamageColor();
    enemy
      ..priority = 4
      ..removeDamage();
    await enemy.setDamage(flip: true);
    enemy
      ..changeLife(25)
      ..changeRage(50);
    Future.delayed(const Duration(milliseconds: 400), () async {
      enemy
        ..priority = enemy.characterPriority
        ..removeDamage();
      await enemy.character.setSprite(CharacterMoveEnum.standard);
      await _standard();
    });
  }

  Future<void> _standard() async {
    await player.character.setSprite(CharacterMoveEnum.standard);
    await player.add(
      MoveToEffect(
        player.starterPosition,
        EffectController(duration: 0.5),
      )..onComplete = () async {
          player
            ..priority = player.characterPriority
            ..changeRage(10)
            ..toggleBar();
          ref.read(battleProvider.notifier).move = CharacterMoveEnum.standard;
        },
    );
  }

  Future<void> _loadBattleAudio() async {
    await FlameAudio.audioCache.loadAll([
      'shanks1.wav',
      'crocodile1.wav',
      'bgm_wano.mp3',
    ]);
    FlameAudio.bgm.initialize();
    await FlameAudio.bgm.stop();
    await FlameAudio.bgm.play('bgm_wano.mp3', volume: .50);
  }

  Future<void> _addPlayers() async {
    player1 = CharacterPositionComponent(
      character: CharacterComponent(SpriteData.shanks2()),
      characterPosition: 1,
      characterPriority: 1,
    );
    await add(player1);

    player2 = CharacterPositionComponent(
      character: CharacterComponent(SpriteData.shanks2()),
      characterPosition: 2,
      characterPriority: 2,
    );
    await add(player2);

    player3 = CharacterPositionComponent(
      character: CharacterComponent(SpriteData.shanks2()),
      characterPosition: 3,
      characterPriority: 3,
    );
    await add(player3);

    player4 = CharacterPositionComponent(
      character: CharacterComponent(SpriteData.crocodile1()),
      characterPosition: 4,
      characterPriority: 1,
    );
    await add(player4);

    player5 = CharacterPositionComponent(
      character: CharacterComponent(SpriteData.crocodile1()),
      characterPosition: 5,
      characterPriority: 2,
    );
    await add(player5);

    player6 = CharacterPositionComponent(
      character: CharacterComponent(SpriteData.enel1()),
      characterPosition: 6,
      characterPriority: 3,
    );
    await add(player6);
  }

  Future<void> _addEnemies() async {
    enemy1 = CharacterPositionComponent(
      character: CharacterComponent(SpriteData.shanks2()),
      characterPosition: 7,
      characterPriority: 1,
      isFlip: true,
    );
    await add(enemy1);

    enemy2 = CharacterPositionComponent(
      character: CharacterComponent(SpriteData.shanks2()),
      characterPosition: 8,
      characterPriority: 2,
      isFlip: true,
    );
    await add(enemy2);

    enemy3 = CharacterPositionComponent(
      character: CharacterComponent(SpriteData.shanks2()),
      characterPosition: 9,
      characterPriority: 3,
      isFlip: true,
    );
    await add(enemy3);

    enemy4 = CharacterPositionComponent(
      character: CharacterComponent(SpriteData.crocodile1()),
      characterPosition: 10,
      characterPriority: 1,
      isFlip: true,
    );
    await add(enemy4);

    enemy5 = CharacterPositionComponent(
      character: CharacterComponent(SpriteData.crocodile1()),
      characterPosition: 11,
      characterPriority: 2,
      isFlip: true,
    );
    await add(enemy5);

    enemy6 = CharacterPositionComponent(
      character: CharacterComponent(SpriteData.enel1()),
      characterPosition: 12,
      characterPriority: 3,
      isFlip: true,
    );
    await add(enemy6);
  }

  void _startPlayer(int value) {
    switch (value) {
      case 1:
        player = player1;
        break;
      case 2:
        player = player2;
        break;
      case 3:
        player = player3;
        break;
      case 4:
        player = player4;
        break;
      case 5:
        player = player5;
        break;
      case 6:
        player = player6;
        break;
      default:
    }
  }

  void _hitPlayer(int value) {
    switch (value) {
      case 1:
        enemy = enemy1;
        break;
      case 2:
        enemy = enemy2;
        break;
      case 3:
        enemy = enemy3;
        break;
      case 4:
        enemy = enemy4;
        break;
      case 5:
        enemy = enemy5;
        break;
      case 6:
        enemy = enemy6;
        break;
      default:
    }
  }
}
