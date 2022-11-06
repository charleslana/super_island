import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_island/src/utils/app_image.dart';

void loadAllImage(BuildContext context) {
  precacheImage(const AssetImage(landingImage), context);
  precacheImage(const AssetImage(superIslandImage), context);
  precacheImage(const AssetImage(btn1Image), context);
  precacheImage(const AssetImage(btn2Image), context);
  precacheImage(const AssetImage(btn3Image), context);
  precacheImage(const AssetImage(loginImage), context);
  precacheImage(const AssetImage(loginMihawkImage), context);
  precacheImage(const AssetImage(loginZoroImage), context);
  precacheImage(const AssetImage(soundOnImage), context);
  precacheImage(const AssetImage(soundOffImage), context);
}

Future<void> loadAllAudio() async {
  await FlameAudio.audioCache.loadAll([
    'bgm_login.mp3',
    'click.mp3',
  ]);
}

void loadAllFont() {
  FontLoader('Asap')
    ..addFont(rootBundle.load('assets/fonts/Asap-Medium.otf'))
    ..load();
  FontLoader('PoetsenOne')
    ..addFont(rootBundle.load('assets/fonts/PoetsenOne-Regular.ttf'))
    ..load();
  FontLoader('SVN')
    ..addFont(rootBundle.load('assets/fonts/SVN-Titillium-bold.ttf'))
    ..load();
}
