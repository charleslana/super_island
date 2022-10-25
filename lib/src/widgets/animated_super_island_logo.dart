import 'package:flutter/material.dart';
import 'package:super_island/src/utils/app_image.dart';

class AnimatedSuperIslandLogo extends StatefulWidget {
  const AnimatedSuperIslandLogo({super.key});

  @override
  State<AnimatedSuperIslandLogo> createState() =>
      _AnimatedSuperIslandLogoState();
}

class _AnimatedSuperIslandLogoState extends State<AnimatedSuperIslandLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(reverse: true);
  late final Animation<Offset> _animation = Tween(
    begin: Offset.zero,
    end: const Offset(0, 0.08),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Image.asset(
        logoSuperIsland,
        fit: BoxFit.contain,
      ),
    );
  }
}
