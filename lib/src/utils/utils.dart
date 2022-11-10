import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:super_island/src/widgets/loading_animated.dart';

String appVersion = '1.0.0';

String numberAbbreviation(dynamic number) {
  final String stringNumber = number.toString();
  final double doubleNumber = double.tryParse(stringNumber) ?? 0;
  final NumberFormat numberFormat = NumberFormat.compact();
  return numberFormat.format(doubleNumber);
}

bool isName(String name) {
  return RegExp(r'^[a-zA-Z0-9]([_](?![_])|[a-zA-Z0-9]){1,18}[a-zA-Z0-9]$')
      .hasMatch(name);
}

void closeKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

void loading(BuildContext context) {
  showDialog<dynamic>(
    barrierDismissible: false,
    context: context,
    builder: (_) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                LoadingAnimated(),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Carregando...',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
