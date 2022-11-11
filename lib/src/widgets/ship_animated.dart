import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:super_island/src/utils/app_image.dart';

class ShipAnimated extends StatefulWidget {
  const ShipAnimated({Key? key}) : super(key: key);

  @override
  State<ShipAnimated> createState() => _ShipAnimatedState();
}

class _ShipAnimatedState extends State<ShipAnimated>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );

  late final Animation<Offset> _animation = Tween<Offset>(
    begin: const Offset(0, 0),
    end: const Offset(0.2, 0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInCubic,
  ));

  double _size = 150;

  @override
  void initState() {
    _runShip();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _buildSizeAnimationWithAnimatedContainer();

  Future<void> _runShip() async {
    final physicalScreenSize = window.physicalSize;
    final physicalHeight = physicalScreenSize.height;
    setState(() {
      _size = physicalHeight * 0.40;
    });
    await _controller.forward();
    await Future.delayed(
      const Duration(),
      () => setState(() {
        _size = physicalHeight * 0.90;
      }),
    );
  }

  Widget _buildSizeAnimationWithAnimatedContainer() {
    return SlideTransition(
      position: _animation,
      textDirection: TextDirection.rtl,
      child: AnimatedContainer(
        height: _size,
        duration: const Duration(milliseconds: 1000),
        child: Image.asset(
          goingMerryImage,
        ),
      ),
    );
  }
}
