import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final battleProvider = ChangeNotifierProvider(
  (ref) => BattleProvider(false),
);

class BattleProvider extends ValueNotifier<dynamic> {
  BattleProvider(super.value);
}
