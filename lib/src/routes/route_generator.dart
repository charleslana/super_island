import 'package:flutter/material.dart';
import 'package:super_island/src/pages/battle_page.dart';
import 'package:super_island/src/pages/home_page.dart';
import 'package:super_island/src/pages/landing_page.dart';
import 'package:super_island/src/pages/login_page.dart';
import 'package:super_island/src/pages/splash_screen_page.dart';
import 'package:super_island/src/routes/routes.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreenPage());
      case Routes.landing:
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.battle:
        return MaterialPageRoute(builder: (_) => const BattlePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
