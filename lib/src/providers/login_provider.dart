import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider =
    StateNotifierProvider<LoginProvider, bool>((ref) => LoginProvider());

class LoginProvider extends StateNotifier<bool> {
  LoginProvider() : super(false);

  bool get isLogged {
    return state;
  }

  void toggleLogged() {
    state = !state;
  }

  set isLogged(bool value) {
    state = value;
  }
}
