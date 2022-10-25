import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final provider = ChangeNotifierProvider(
  (ref) => ModelProvider(false),
);

class ModelProvider extends ValueNotifier<dynamic> {
  ModelProvider(super.value);
}
