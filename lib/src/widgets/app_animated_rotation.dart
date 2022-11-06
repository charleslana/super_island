import 'package:flutter/material.dart';

class AppAnimatedRotation extends StatefulWidget {
  const AppAnimatedRotation({
    required this.image,
    required this.begin,
    required this.end,
    super.key,
  });

  final String image;
  final double begin;
  final double end;

  @override
  State<AppAnimatedRotation> createState() => _AppAnimatedRotationState();
}

class _AppAnimatedRotationState extends State<AppAnimatedRotation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(reverse: true);
  late final Tween<double> _animation = Tween<double>(
    begin: widget.begin,
    end: widget.end,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation.animate(_controller),
      child: Image.asset(
        widget.image,
        fit: BoxFit.contain,
      ),
    );
  }
}
