import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:super_island/src/enums/toast_enum.dart';
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

void showToast(BuildContext context, String message, ToastEnum toastEnum) {
  showDialog<dynamic>(
    context: context,
    barrierColor: null,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: toastEnum == ToastEnum.error
                    ? Colors.redAccent
                    : Colors.green,
                shadows: const [
                  Shadow(
                    // bottomLeft
                    offset: Offset(-1.5, -1.5),
                  ),
                  Shadow(
                    // bottomRight
                    offset: Offset(1.5, -1.5),
                  ),
                  Shadow(
                    // topRight
                    offset: Offset(1.5, 1.5),
                  ),
                  Shadow(
                    // topLeft
                    offset: Offset(-1.5, 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
