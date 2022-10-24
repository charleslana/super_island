import 'package:flutter/material.dart';
import 'package:super_island/src/routes/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.battle),
            child: const Text('battle page'),
          ),
        ),
      ),
    );
  }
}
