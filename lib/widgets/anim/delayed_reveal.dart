import 'package:flutter/material.dart';
import 'dart:async';

class DelayedReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const DelayedReveal({
    Key? key,
    required this.child,
    required this.delay,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DelayedRevealState createState() => _DelayedRevealState();
}

class _DelayedRevealState extends State<DelayedReveal>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _timer = Timer(widget.delay, _controller.forward);
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.translate(
            offset: Offset(0.0, (1 - _animation.value) * 20.0),
            child: child,
          ),
        );
      },
    );
  }
}
