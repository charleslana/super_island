import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:super_island/src/utils/app_image.dart';

class BtnSound extends StatelessWidget {
  const BtnSound({
    Key? key,
    required this.isPlay,
    required this.callback,
  }) : super(key: key);

  final bool isPlay;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await FlameAudio.play('click.mp3');
        callback();
      },
      child: Image.asset(
        isPlay ? soundOnImage : soundOffImage,
        fit: BoxFit.contain,
      ),
    );
  }
}
