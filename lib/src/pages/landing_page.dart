import 'package:flutter/material.dart';
import 'package:super_island/src/utils/app_image.dart';
import 'package:super_island/src/widgets/animated_super_island_logo.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(logoImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black87,
                  Colors.black12,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 200,
                      child: AnimatedSuperIslandLogo(),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 0,
                        color: Colors.black.withOpacity(0.7),
                        child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Carregando informações...',
                            textAlign: TextAlign.center,
                          ),
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
    );
  }
}
