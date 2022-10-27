import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_island/src/enums/character_move_enum.dart';

final battleProvider = ChangeNotifierProvider(
  (ref) => BattleProvider(CharacterMoveEnum.standard),
);

class BattleProvider extends ValueNotifier<dynamic> {
  BattleProvider(this.move, {this.isAttack = false}) : super(move);

  CharacterMoveEnum move;
  bool isAttack;
}
