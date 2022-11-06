import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:super_island/src/routes/routes.dart';
import 'package:super_island/src/utils/app_image.dart';
import 'package:super_island/src/widgets/app_animated_rotation.dart';
import 'package:super_island/src/widgets/app_fade_transition.dart';
import 'package:super_island/src/widgets/btn_2.dart';
import 'package:super_island/src/widgets/btn_3.dart';
import 'package:super_island/src/widgets/btn_sound.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogged = false;
  bool isChecked = false;
  bool isPlay = true;

  @override
  void initState() {
    loadLoginAudio();
    validateLogin();
    super.initState();
  }

  @override
  void dispose() {
    FlameAudio.bgm.dispose();
    super.dispose();
  }

  Future<void> validateLogin() async {
    Future.delayed(
      const Duration(milliseconds: 1000),
      checkLogin,
    );
  }

  void checkLogin() {
    setState(() {
      isLogged = false;
      isChecked = true;
    });
  }

  Future<void> loadLoginAudio() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.bgm.play('bgm_login.mp3', volume: .50);
  }

  Future<void> toggleAudio() async {
    setState(() {
      isPlay = !isPlay;
    });
    if (isPlay) {
      await FlameAudio.bgm.play('bgm_login.mp3', volume: .50);
      return;
    }
    await FlameAudio.bgm.stop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(loginImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
                  Colors.black54,
                  Colors.black12,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(superIslandImage),
                      fit: BoxFit.contain,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Expanded(
                              flex: 2,
                              child: AppAnimatedRotation(
                                image: loginMihawkImage,
                                begin: 1,
                                end: 1.03,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: AppAnimatedRotation(
                                image: loginZoroImage,
                                begin: 1,
                                end: 0.97,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isChecked && !isLogged)
                        Align(
                          child: Card(
                            elevation: 0,
                            color: Colors.black.withOpacity(0.4),
                            child: const Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                'Aguarde...',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      if (!isLogged && isChecked)
                        Align(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Btn2(
                                text: 'Login',
                                callback: () {},
                              ),
                              Btn3(
                                text: 'Cadastre-se',
                                callback: () {},
                              ),
                            ],
                          ),
                        ),
                      if (isLogged && isChecked)
                        Align(
                          child: AppFadeTransition(
                            child: InkWell(
                              onTap: () => Navigator.pushReplacementNamed(
                                  context, Routes.home),
                              child: SizedBox(
                                child: Card(
                                  elevation: 0,
                                  color: Colors.black.withOpacity(0.4),
                                  child: const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      'Toque aqui para continuar',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          width: size.width / 6,
                          height: size.height / 6,
                          child: BtnSound(
                            isPlay: isPlay,
                            callback: toggleAudio,
                          ),
                        ),
                      ),
                      const Positioned(
                        right: 0,
                        bottom: 0,
                        child: Text(
                          'Versão: 1.0.0',
                          style: TextStyle(
                            shadows: [
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
