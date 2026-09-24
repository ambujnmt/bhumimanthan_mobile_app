import '../utils/app_imports.dart';

class AppToast {
  static void show(
    String message, {
    Color background = Colors.black87,
    Color textColor = Colors.white,
    int duration = 2,
    IconData? icon,
  }) {
    Get.rawSnackbar(
      icon: Icon(icon ?? Icons.settings, color: Colors.white, size: 26),
      messageText: CustomText.kText(
        message,
        color: textColor,
        weight: FontWeight.w600,
        align: TextAlign.left,
      ),
      backgroundColor: background,
      borderRadius: 16,
      margin: const EdgeInsets.all(16),
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: false,
      duration: Duration(seconds: duration),
      animationDuration: const Duration(milliseconds: 400),
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void success(String message) {
    show(message, background: Colors.green.shade600, icon: Icons.done);
  }

  static void error(String message) {
    show(message, background: Colors.red.shade600, icon: Icons.error);
  }

  static void warning(String message) {
    show(
      message,
      background: Colors.amber.shade700,
      textColor: Colors.black,
      icon: Icons.warning,
    );
  }

  static void info(String message) {
    show(message, background: Colors.blue.shade600, icon: Icons.info);
  }
}
