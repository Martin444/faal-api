import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

var systemDart = const SystemUiOverlayStyle(
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
  statusBarColor: Colors.transparent,
  systemNavigationBarContrastEnforced: true,
);

var decorationMethod = BoxDecoration(
  color: kModalcolor,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      color: const Color(0xFFC4C4C4).withOpacity(0.4),
      offset: const Offset(0, 2),
      blurRadius: 10,
    ),
  ],
);

var decorationMethodSelected = BoxDecoration(
  color: const Color(0xFFF3F6FF),
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      color: const Color(0xFF3D73FE).withOpacity(0.4),
      offset: const Offset(0, 2),
      blurRadius: 10,
    ),
  ],
);
