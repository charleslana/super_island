import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:super_island/src/utils/app_image.dart';

class Btn3 extends StatelessWidget {
  const Btn3({
    Key? key,
    required this.text,
    required this.callback,
  }) : super(key: key);

  final String text;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await FlameAudio.play('click.mp3');
        callback();
      },
      child: Container(
        width: 122,
        height: 50,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(btn3Image),
            fit: BoxFit.contain,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
