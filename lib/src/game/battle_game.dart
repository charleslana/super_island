import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_island/src/components/battle_bg_component.dart';
import 'package:super_island/src/components/character_component.dart';
import 'package:super_island/src/components/skill_action_component.dart';
import 'package:super_island/src/components/skill_component.dart';
import 'package:super_island/src/game/character_position.dart';

class BattleGame extends FlameGame with HasTappableComponents {
  BattleGame(this.ref);

  final WidgetRef ref;

  late CharacterComponent player1;
  late CharacterComponent player2;
  late CharacterComponent player3;

  late CharacterComponent enemy1;
  late CharacterComponent enemy2;
  late CharacterComponent enemy3;

  @override
  Color backgroundColor() {
    return Colors.white;
  }

  @override
  Future<void>? onLoad() async {
    final battleBgComponent = BattleBgComponent();
    await add(battleBgComponent);

    player3 = CharacterComponent(
      characterImage: 'characters/luffy1.png',
      characterPosition: left3,
      isFlip: true,
    );
    await add(player3);

    player2 = CharacterComponent(
      characterImage: 'characters/luffy1.png',
      characterPosition: left2,
      isFlip: true,
    );
    await add(player2);

    player1 = CharacterComponent(
      characterImage: 'characters/luffy1.png',
      characterPosition: left1,
      isFlip: true,
    );
    await add(player1);

    enemy3 = CharacterComponent(
      characterImage: 'characters/zoro1.png',
      characterPosition: right3,
    );
    await add(enemy3);

    enemy2 = CharacterComponent(
      characterImage: 'characters/zoro1.png',
      characterPosition: right2,
    );
    await add(enemy2);

    enemy1 = CharacterComponent(
      characterImage: 'characters/zoro1.png',
      characterPosition: right1,
    );
    await add(enemy1);

    await add(SkillComponent(size));
    await add(SkillActionComponent());
    return super.onLoad();
  }
}
