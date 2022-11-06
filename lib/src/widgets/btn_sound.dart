import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:super_island/src/services/shared_local_storage_service.dart';
import 'package:super_island/src/utils/app_image.dart';
import 'package:super_island/src/utils/keys.dart';

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
    final sharedLocalStorageService = SharedLocalStorageService();

    return InkWell(
      onTap: () async {
        await FlameAudio.play('click.mp3');
        callback();
        await sharedLocalStorageService.put(soundKey, !isPlay);
      },
      child: Image.asset(
        isPlay ? soundOnImage : soundOffImage,
        fit: BoxFit.contain,
      ),
    );
  }
}
