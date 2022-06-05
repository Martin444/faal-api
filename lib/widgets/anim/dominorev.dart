import 'package:flutter/material.dart';
import 'dart:async';

import './delayed_reveal.dart';

// This function increments and returns a Duration
// The delay is reset when no new animations have been added for a short moment
//  (you can change the conditions of this to match your requirements)
late Timer _dominoReset;
Duration _dominoDelay = const Duration();
_getDelay() {
  if (!_dominoReset.isActive) {
    _dominoReset = Timer(const Duration(milliseconds: 100), () {
      _dominoDelay = const Duration();
    });
  }
  _dominoDelay += const Duration(milliseconds: 100);
  return _dominoDelay;
}

class DominoReveal extends StatelessWidget {
  final Widget child;

  const DominoReveal({
    Key? key,
    required this.child,
    // ignore: unnecessary_null_comparison
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DelayedReveal(
      delay: _getDelay(),
      child: child,
    );
  }
}
