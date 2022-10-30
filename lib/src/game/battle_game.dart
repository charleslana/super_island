import 'package:flame/collisions.dart';
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
    player = player3;
    enemy = enemy2;
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
        !player.isColliding &&
        (player.size.x + player.x) < size.x) {
      _startPlayer(battleWatch.start);
      await player.setSprite(battleWatch.move);
      player
        ..toggleBar(isShow: false)
        ..priority = 4
        ..x += size.x / 70;
      if (player.characterPosition.y < enemy.characterPosition.y) {
        player.y += enemy.characterPosition.y / 0.15;
      }
      if (player.characterPosition.y > enemy.characterPosition.y) {
        player.y -= enemy.characterPosition.y / 0.15;
      }
      print('run');
    }
  }

  Future<void> _collision(BattleProvider battleWatch) async {
    if (player.isColliding && battleWatch.move == CharacterMoveEnum.run) {
      ref.read(battleProvider.notifier).move = CharacterMoveEnum.attack;
      await player.setSprite(CharacterMoveEnum.attack);
      Future.delayed(const Duration(milliseconds: 300), () async {
        await FlameAudio.play('shanks1.wav');
      });
      print('collision');
      _defense();
      player.spriteAnimation.animation?.onComplete = () async {
        await player.setSprite(CharacterMoveEnum.standard);
        ref.read(battleProvider.notifier).move = CharacterMoveEnum.standard;
        print('fim da animação de ataque');
        Future.delayed(const Duration(milliseconds: 300), () async {
          player
            ..changeRage(10)
            ..toggleBar();
        });
      };
    }
  }

  void _defense() {
    Future.delayed(const Duration(milliseconds: 300), () async {
      await enemy.setSprite(CharacterMoveEnum.defense);
      enemy
        ..priority = 1
        ..setDamageColor()
        ..removeDamage()
        ..setDamage(flip: true)
        ..changeLife(25)
        ..changeRage(50);
      enemy.spriteAnimation.animation?.onComplete = () async {
        Future.delayed(const Duration(milliseconds: 200), () async {
          await enemy.setSprite(CharacterMoveEnum.standard);
        });
        Future.delayed(const Duration(milliseconds: 400), () async {
          enemy
            ..priority = 1
            ..removeDamage();
        });
      };
    });
  }

  void _standard(BattleProvider battleWatch) {
    if (battleWatch.move == CharacterMoveEnum.standard &&
        (player.x - 1) > player.starterPosition.x) {
      player
        ..priority = player.characterPriority
        ..x -= size.x / 70;
      if (player.characterPosition.y < enemy.characterPosition.y) {
        player.y -= enemy.characterPosition.y / 0.15;
      }
      if (player.characterPosition.y > enemy.characterPosition.y) {
        player.y += enemy.characterPosition.y / 0.15;
      }
      print('standard');
    }
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
      characterPriority: 1,
      isFlip: true,
    );
    await add(enemy1);

    enemy2 = CharacterComponent(
      character: SpriteData.shanks2(),
      characterPosition: right2,
      characterPriority: 2,
      isFlip: true,
    );
    await add(enemy2);

    enemy3 = CharacterComponent(
      character: SpriteData.shanks2(),
      characterPosition: right3,
      characterPriority: 3,
      isFlip: true,
    );
    await add(enemy3);

    enemy4 = CharacterComponent(
      character: SpriteData.shanks2(),
      characterPosition: right4,
      characterPriority: 0,
      isFlip: true,
    );
    await add(enemy4);

    enemy5 = CharacterComponent(
      character: SpriteData.shanks2(),
      characterPosition: right5,
      characterPriority: 1,
      isFlip: true,
    );
    await add(enemy5);

    enemy6 = CharacterComponent(
      character: SpriteData.shanks2(),
      characterPosition: right6,
      characterPriority: 2,
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
}
