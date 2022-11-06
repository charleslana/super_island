import 'package:flutter/material.dart';
import 'package:super_island/src/utils/app_image.dart';
import 'package:super_island/src/widgets/app_animated_rotation.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                        child: Center(child: Text('Login Page')),
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
                // Center(
                //   child: Text('Login Page'),
                // ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: AppAnimatedRotation(loginLuffyImage),
                // ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Text('Second image'),
                // ),
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
    );
  }
}
