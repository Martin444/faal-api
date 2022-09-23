import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';

class SnackMessagesHandle {
  void snackErrorHandle(String? message) {
    HapticFeedback.vibrate();
    Get.showSnackbar(
      GetSnackBar(
        message: message!,
        backgroundColor: kredDesensa,
        duration: const Duration(seconds: 4),
        snackPosition: SnackPosition.TOP,
      ),
    );
  }
}
