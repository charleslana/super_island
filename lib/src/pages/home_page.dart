import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:super_island/src/routes/routes.dart';
import 'package:super_island/src/services/shared_local_storage_service.dart';
import 'package:super_island/src/utils/app_image.dart';
import 'package:super_island/src/utils/keys.dart';
import 'package:super_island/src/widgets/btn_sound.dart';
import 'package:super_island/src/widgets/ship_animated.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPlay = true;
  final sharedLocalStorageService = SharedLocalStorageService();

  @override
  void initState() {
    loadLoginAudio();
    super.initState();
  }

  @override
  void dispose() {
    FlameAudio.bgm.dispose();
    super.dispose();
  }

  Future<void> loadLoginAudio() async {
    FlameAudio.bgm.initialize();
    final getSound = await sharedLocalStorageService.get<bool>(soundKey);
    if (getSound != null) {
      if (getSound) {
        await FlameAudio.bgm.play('bgm_home.wav', volume: .50);
      }
      setState(() {
        isPlay = getSound;
      });
      return;
    }
    await FlameAudio.bgm.play('bgm_home.wav', volume: .50);
  }

  Future<void> toggleAudio() async {
    setState(() {
      isPlay = !isPlay;
    });
    if (isPlay) {
      await FlameAudio.bgm.play('bgm_home.wav', volume: .50);
      return;
    }
    await FlameAudio.bgm.stop();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(homeImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                Positioned(
                  bottom: height * 0.05,
                  right: width * 0.01,
                  child: const ShipAnimated(),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: width / 6,
                    height: height / 6,
                    child: BtnSound(
                      isPlay: isPlay,
                      callback: toggleAudio,
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.battle),
                    child: const Text('battle page'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
