import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Platform-aware notification helper
/// - Web: Uses Dialog (reliable)
/// - Mobile/Desktop: Uses Snackbar
class UIHelper {
  /// Show error/warning notifications that work across all platforms
  static void showNotification({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 4),
    Color? backgroundColor,
    Color? textColor,
  }) {
    if (kIsWeb) {
      // Web: Use Dialog for reliability
      Get.dialog(
        AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
        barrierDismissible: true,
      );
    } else {
      // Mobile/Desktop: Use Snackbar
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        duration: duration,
        backgroundColor: backgroundColor ?? Colors.red,
        colorText: textColor ?? Colors.white,
      );
    }
  }

  /// Show error notification
  static void showError(String title, String message) {
    showNotification(
      title: title,
      message: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  /// Show success notification
  static void showSuccess(String title, String message) {
    showNotification(
      title: title,
      message: message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  /// Show warning notification
  static void showWarning(String title, String message) {
    showNotification(
      title: title,
      message: message,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
    );
  }
}
