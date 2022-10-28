import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_island/src/components/battle_bg_component.dart';
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
    final battleBgComponent = BattleBgComponent();
    await add(battleBgComponent);

    player1 = CharacterComponent(
      characterImage: 'characters/shanks2.png',
      characterPosition: left1,
    );
    await add(player1);
    player1.setDamage();

    enemy1 = CharacterComponent(
      characterImage: 'characters/shanks2.png',
      characterPosition: right1,
      isFlip: true,
    );
    await add(enemy1);
    enemy1.setDamage(flip: true);

    await add(SkillComponent(size));
    await add(SkillActionComponent());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    final battleWatch = ref.watch(battleProvider);
    _run(battleWatch);
    _attack(battleWatch);
    _validateCollision(battleWatch);
    super.update(dt);
  }

  Future<void> _run(BattleProvider battleWatch) async {
    if (battleWatch.move == CharacterMoveEnum.run &&
        !battleWatch.isAttack &&
        (player1.size.x + player1.x) < size.x) {
      await player1.setSprite(battleWatch.move);
      player1
        ..priority = 1
        ..x += size.x / 70;
    }
    _goBack(battleWatch);
  }

  void _goBack(BattleProvider battleWatch) {
    if (battleWatch.move == CharacterMoveEnum.standard &&
        !battleWatch.isAttack &&
        player1.x > player1.starterPosition.x) {
      player1.x -= size.x / 70;
    }
  }

  Future<void> _attack(BattleProvider battleWatch) async {
    if (battleWatch.move == CharacterMoveEnum.attack) {
      await player1.setSprite(CharacterMoveEnum.attack);
    }
  }

  void _validateCollision(BattleProvider battleWatch) {
    if (battleWatch.move == CharacterMoveEnum.standard &&
        battleWatch.isAttack &&
        player1.isColliding) {
      ref.read(battleProvider.notifier).move = CharacterMoveEnum.animation;
      _defense();
      player1.spriteAnimation.animation?.onComplete = () async {
        ref.read(battleProvider.notifier)
          ..isAttack = false
          ..move = CharacterMoveEnum.standard;
        await player1.setSprite(CharacterMoveEnum.standard);
        await enemy1.setSprite(CharacterMoveEnum.standard);
      };
    }
  }

  Future<void> _defense() async {
    enemy1.isDefense = true;
    if (enemy1.isDefense) {
      Future.delayed(const Duration(milliseconds: 300), () async {
        await enemy1.setSprite(CharacterMoveEnum.defense);
        enemy1.setDamageColor();
      });
      enemy1.spriteAnimation.animation?.onComplete = () {
        enemy1.isDefense = false;
      };
      return;
    }
  }
}
