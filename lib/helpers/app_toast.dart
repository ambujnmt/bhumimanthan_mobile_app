import '../utils/app_imports.dart';

class AppToast {
  static void show(
    String message, {
    Color background = Colors.black87,
    Color textColor = Colors.white,
    int duration = 2,
    IconData? icon,
    String? actionLabel,
    VoidCallback? onActionTap,
    Color? actionColor,
  }) {
    Get.rawSnackbar(
      icon: Icon(icon ?? Icons.settings, color: textColor, size: 26),
      messageText: CustomText.kText(
        message,
        color: textColor,
        weight: FontWeight.w600,
        align: TextAlign.left,
      ),
      mainButton: actionLabel != null && onActionTap != null
          ? TextButton(
              style: TextButton.styleFrom(
                foregroundColor: actionColor ?? textColor,
                backgroundColor: white.withValues(alpha: .25),
              ),
              onPressed: () {
                Get.closeCurrentSnackbar();
                onActionTap();
              },
              child: Text(
                actionLabel,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          : null,
      backgroundColor: background,
      borderRadius: 16,
      margin: const EdgeInsets.all(16),
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      duration: Duration(seconds: duration),
      animationDuration: const Duration(milliseconds: 400),
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void success(
    String message, {
    String? actionLabel,
    VoidCallback? onActionTap,
    int duration = 3,
  }) {
    show(
      message,
      background: Colors.green.shade600,
      icon: Icons.done,
      actionLabel: actionLabel,
      onActionTap: onActionTap,
      duration: duration,
    );
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
