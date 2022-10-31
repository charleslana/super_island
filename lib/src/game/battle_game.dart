import 'package:flame/collisions.dart';
import 'package:flame/effects.dart';
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
import 'package:super_island/src/data/sprite_data.dart';
import 'package:super_island/src/enums/character_move_enum.dart';
import 'package:super_island/src/game/character_position.dart';
import 'package:super_island/src/providers/battle_provider.dart';

class BattleGame extends FlameGame
    with HasTappableComponents, HasCollisionDetection {
  BattleGame(this.ref);

  final WidgetRef ref;

  late CharacterComponent player;
  late CharacterComponent player1;
  late CharacterComponent player2;
  late CharacterComponent player3;
  late CharacterComponent player4;
  late CharacterComponent player5;
  late CharacterComponent player6;

  late CharacterComponent enemy;
  late CharacterComponent enemy1;
  late CharacterComponent enemy2;
  late CharacterComponent enemy3;
  late CharacterComponent enemy4;
  late CharacterComponent enemy5;
  late CharacterComponent enemy6;

  @override
  Color backgroundColor() {
    return Colors.white;
  }

  @override
  Future<void>? onLoad() async {
    await _loadBattleAudio();
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
    player = player3;
    enemy = enemy3;
    return super.onLoad();
  }

  @override
  void onRemove() {
    FlameAudio.bgm.dispose();
  }

  Future<void> move() async {
    _startPlayer(ref.watch(battleProvider).start);
    _hitPlayer(ref.watch(battleProvider).hit);
    await player.setSprite(CharacterMoveEnum.run);
    player
      ..priority = 4
      ..toggleBar(isShow: false);
    await player.add(
      MoveToEffect(
        Vector2(enemy.position.x - size.x / 15, enemy.position.y),
        EffectController(duration: 0.5),
      )..onComplete = () async {
          await _attack();
        },
    );
  }

  Future<void> _attack() async {
    await player.setSprite(CharacterMoveEnum.attack);
    Future.delayed(const Duration(milliseconds: 300), () async {
      await FlameAudio.play('shanks1.wav');
      await _defense();
    });
  }

  Future<void> _defense() async {
    await enemy.setSprite(CharacterMoveEnum.defense);
    enemy
      ..setDamageColor()
      ..removeDamage()
      ..setDamage(flip: true)
      ..changeLife(25)
      ..changeRage(50);
    Future.delayed(const Duration(milliseconds: 400), () async {
      enemy.removeDamage();
      await enemy.setSprite(CharacterMoveEnum.standard);
      await _standard();
    });
  }

  Future<void> _standard() async {
    await player.setSprite(CharacterMoveEnum.standard);
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
    await FlameAudio.audioCache.loadAll(['shanks1.wav', 'bgm_wano.mp3']);
    FlameAudio.bgm.initialize();
    await FlameAudio.bgm.stop();
    await FlameAudio.bgm.play('bgm_wano.mp3', volume: .50);
  }

  Future<void> _addPlayers() async {
    player1 = CharacterComponent(
      character: SpriteData.shanks2(),
      characterPosition: left1,
      characterPriority: 1,
      collisionType: CollisionType.passive,
    );
    await add(player1);

    player2 = CharacterComponent(
      character: SpriteData.shanks2(),
      characterPosition: left2,
      characterPriority: 2,
      collisionType: CollisionType.passive,
    );
    await add(player2);

    player3 = CharacterComponent(
      character: SpriteData.shanks2(),
      characterPosition: left3,
      characterPriority: 3,
      collisionType: CollisionType.passive,
    );
    await add(player3);

    player4 = CharacterComponent(
      character: SpriteData.shanks2(),
      characterPosition: left4,
      characterPriority: 0,
      collisionType: CollisionType.passive,
    );
    await add(player4);

    player5 = CharacterComponent(
      character: SpriteData.shanks2(),
      characterPosition: left5,
      characterPriority: 1,
      collisionType: CollisionType.passive,
    );
    await add(player5);

    player6 = CharacterComponent(
      character: SpriteData.shanks2(),
      characterPosition: left6,
      characterPriority: 2,
      collisionType: CollisionType.passive,
    );
    await add(player6);
  }

  Future<void> _addEnemies() async {
    enemy1 = CharacterComponent(
      character: SpriteData.shanks2(),
      characterPosition: right1,
      characterPriority: 0,
      isFlip: true,
    );
    await add(enemy1);

    enemy2 = CharacterComponent(
      character: SpriteData.shanks2(),
      characterPosition: right2,
      characterPriority: 1,
      isFlip: true,
    );
    await add(enemy2);

    enemy3 = CharacterComponent(
      character: SpriteData.shanks2(),
      characterPosition: right3,
      characterPriority: 2,
      isFlip: true,
    );
    await add(enemy3);

    enemy4 = CharacterComponent(
      character: SpriteData.shanks2(),
      characterPosition: right4,
      characterPriority: 1,
      isFlip: true,
    );
    await add(enemy4);

    enemy5 = CharacterComponent(
      character: SpriteData.shanks2(),
      characterPosition: right5,
      characterPriority: 2,
      isFlip: true,
    );
    await add(enemy5);

    enemy6 = CharacterComponent(
      character: SpriteData.shanks2(),
      characterPosition: right6,
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
