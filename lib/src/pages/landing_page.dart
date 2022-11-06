import 'package:flutter/material.dart';
import 'package:super_island/src/routes/routes.dart';
import 'package:super_island/src/utils/app_image.dart';
import 'package:super_island/src/utils/utils.dart';
import 'package:super_island/src/widgets/btn_1.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isError = false;
  String text = 'Validando versão...';
  String currentVersion = '1.0.0';

  @override
  void initState() {
    start();
    super.initState();
  }

  Future<void> start() async {
    Future.delayed(
      const Duration(milliseconds: 1000),
      () => {
        setState(() {
          isError = true;
        }),
        connection(),
      },
    );
  }

  void checkVersion() {
    if (appVersion != currentVersion) {
      setState(() {
        isError = false;
        text =
            'Há uma nova versão disponível, verifique na sua loja de aplicativos';
      });
      return;
    }
    goToLogin();
  }

  void tryAgain() {
    setState(() {
      isError = false;
      text = 'Validando versão...';
    });
    connection();
  }

  void connection() {
    if (isError) {
      setState(() {
        text = 'Erro na conexão com o servidor';
      });
      return;
    }
    checkVersion();
  }

  void goToLogin() {
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(landingImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(superIslandImage),
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Card(
                        elevation: 0,
                        color: Colors.black.withOpacity(0.7),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    if (isError) ...[
                      const SizedBox(height: 10),
                      Btn1(
                        text: 'Tentar novamente',
                        callback: tryAgain,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
