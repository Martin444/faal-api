import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:math';

import '../utils/colors.dart';
import '../utils/text_styles.dart';
import 'anim/delayed_reveal.dart';
import 'button_primary.dart';

// ignore: must_be_immutable
class CongratsModal extends StatefulWidget {
  String? message;
  void Function()? onPressed;
  CongratsModal({
    Key? key,
    required this.message,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CongratsModal> createState() => _CongratsModalState();
}

class _CongratsModalState extends State<CongratsModal> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 4));
    _controllerCenter.play();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        // color: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '¡Bien hecho!',
                style: titleAppBar,
              ),
              const Divider(
                height: 25,
                thickness: 2,
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DelayedReveal(
                    delay: const Duration(milliseconds: 200),
                    child: Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            ConfettiWidget(
                              confettiController: _controllerCenter,
                              blastDirectionality:
                                  BlastDirectionality.explosive,
                              shouldLoop: true,
                              colors: const [
                                Colors.green,
                                Colors.blue,
                                Colors.pink,
                                Colors.orange,
                                Colors.purple
                              ], // manually specify the colors to be used
                              createParticlePath:
                                  drawStar, // define a custom shape/path.
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SvgPicture.asset(
                                'assets/okeylogo.svg',
                                height: 80,
                                width: 80,
                                color: kgreenSucces,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  DelayedReveal(
                    delay: const Duration(milliseconds: 300),
                    child: Text(
                      widget.message ?? '',
                      textAlign: TextAlign.center,
                      style: titleProduct,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ButtonPrimary(
                    title: 'Entendido',
                    onPressed: widget.onPressed!,
                    load: false,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
