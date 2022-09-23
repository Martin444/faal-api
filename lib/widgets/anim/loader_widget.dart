import 'package:flutter/material.dart';

class LoadAnimation extends StatefulWidget {
  final Widget? child;

  const LoadAnimation({@required this.child, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoadAnimationState createState() => _LoadAnimationState();
}

class _LoadAnimationState extends State<LoadAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child!,
        Positioned.fill(
          child: ClipRect(
              child: AnimatedBuilder(
            animation: controller!,
            builder: (context, child) {
              return FractionallySizedBox(
                widthFactor: .3,
                alignment: AlignmentGeometryTween(
                  begin: const Alignment(-1.0 - .2 * 3, .0),
                  end: const Alignment(1.0 + .2 * 3, .0),
                )
                    .chain(CurveTween(curve: Curves.easeOut))
                    .evaluate(controller!)!,
                child: child,
              );
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(0, 255, 255, 255),
                    Colors.grey[200]!,
                    Colors.grey[100]!,
                  ],
                ),
              ),
            ),
          )),
        ),
      ],
    );
  }
}
