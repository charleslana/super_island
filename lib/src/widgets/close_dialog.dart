import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:super_island/src/utils/app_image.dart';

class CloseDialog extends StatelessWidget {
  const CloseDialog(this.callback, {Key? key}) : super(key: key);

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onTap: () {
          FlameAudio.play('close.mp3').then((value) => callback());
        },
        child: Align(
          alignment: Alignment.topRight,
          child: CircleAvatar(
            radius: 20,
            child: Image.asset(
              closeDialog1Image,
              fit: BoxFit.contain,
              width: 50,
              height: 46,
            ),
          ),
        ),
      ),
    );
  }
}
