import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_island/src/enums/toast_enum.dart';
import 'package:super_island/src/providers/login_provider.dart';
import 'package:super_island/src/routes/routes.dart';
import 'package:super_island/src/services/shared_local_storage_service.dart';
import 'package:super_island/src/utils/app_image.dart';
import 'package:super_island/src/utils/keys.dart';
import 'package:super_island/src/utils/utils.dart';
import 'package:super_island/src/widgets/app_animated_rotation.dart';
import 'package:super_island/src/widgets/app_fade_transition.dart';
import 'package:super_island/src/widgets/btn_2.dart';
import 'package:super_island/src/widgets/btn_3.dart';
import 'package:super_island/src/widgets/btn_sound.dart';
import 'package:super_island/src/widgets/login_dialog.dart';
import 'package:super_island/src/widgets/register_dialog.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool isChecked = false;
  bool isPlay = true;
  final sharedLocalStorageService = SharedLocalStorageService();

  @override
  void initState() {
    loadLoginAudio();
    validateLogin();
    super.initState();
  }

  Future<void> validateLogin() async {
    Future.delayed(
      const Duration(milliseconds: 1000),
      checkLogin,
    );
  }

  void checkLogin() {
    setState(() {
      isChecked = true;
    });
  }

  Future<void> loadLoginAudio() async {
    FlameAudio.bgm.initialize();
    final getSound = await sharedLocalStorageService.get<bool>(soundKey);
    if (getSound != null) {
      if (getSound) {
        await FlameAudio.bgm.play('bgm_login.mp3', volume: .50);
      }
      setState(() {
        isPlay = getSound;
      });
      return;
    }
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

  void showRegisterDialog() {
    showDialog<dynamic>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: const RegisterDialog(),
      ),
    );
  }

  void showLoginDialog() {
    showToast(context, 'Credenciais inv??lidas', ToastEnum.error);
    showDialog<dynamic>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: const LoginDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLogged = ref.watch(loginProvider);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                                callback: showLoginDialog,
                              ),
                              Btn3(
                                text: 'Cadastre-se',
                                callback: showRegisterDialog,
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
                          'Vers??o: 1.0.0',
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
