import 'package:flutter/material.dart';

class AppFadeTransition extends StatefulWidget {
  const AppFadeTransition({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<AppFadeTransition> createState() => _AppFadeTransitionState();
}

class _AppFadeTransitionState extends State<AppFadeTransition>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat(reverse: true);

  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
