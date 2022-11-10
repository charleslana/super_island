import 'package:flutter/material.dart';
import 'package:super_island/src/utils/app_image.dart';

class LoadingAnimated extends StatefulWidget {
  const LoadingAnimated({Key? key}) : super(key: key);

  @override
  State<LoadingAnimated> createState() => _LoadingAnimatedState();
}

class _LoadingAnimatedState extends State<LoadingAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    _controller
      ..forward()
      ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: Tween(
          begin: 0.0,
          end: 1.0,
        ).animate(_controller),
        child: Image.asset(loadingImage),
      ),
    );
  }
}
