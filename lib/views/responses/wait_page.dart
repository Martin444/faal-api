import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class WaitPage extends StatelessWidget {
  const WaitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Center(
        child: SizedBox(
          height: 170,
          child: Image.asset('assets/logo-animate.gif'),
        ),
      ),
    );
  }
}
