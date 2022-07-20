import 'package:faal/utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SnackMessagesHandle {
  void snackErrorHandle(String? message) {
    HapticFeedback.vibrate();
    Get.showSnackbar(
      GetSnackBar(
        message: message!,
        backgroundColor: kredDesensa,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      ),
    );
  }
}
