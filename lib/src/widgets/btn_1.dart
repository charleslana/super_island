import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:super_island/src/utils/app_image.dart';

class Btn1 extends StatelessWidget {
  const Btn1({
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
      child: SizedBox(
        width: 123,
        height: 41,
        child: Stack(
          children: [
            Image.asset(
              btn1Image,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Align(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(text),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
