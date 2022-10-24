import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_island/src/game/battle_game.dart';

class BattlePage extends ConsumerWidget {
  const BattlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: GameWidget(
          game: BattleGame(ref),
          loadingBuilder: (context) => const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
