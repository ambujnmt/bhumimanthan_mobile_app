import '../utils/app_imports.dart';

class AppDialog {
  static Future<bool?> show({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    bool showCancelButton = true,
    bool barrierDismissible = false,
    Color? positiveButtonColor,
    Color? negativeButtonColor,
  }) async {
    if (Get.isDialogOpen ?? false) return null; // avoid duplicate dialogs

    final result = await Get.dialog<bool>(
      PopScope(
        canPop: barrierDismissible,
        child: Dialog(
          backgroundColor: white,
          child: AppContainer(
            borderColor: transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.kText(title, size: 18),
                heightSpace5,
                CustomText.kText(
                  message,
                  size: 14,
                  weight: FontWeight.w400,
                  lines: 20,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (showCancelButton && cancelText != null)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: negativeButtonColor ?? green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () => Get.back(result: false),
                        child: CustomText.kText(cancelText, color: white),
                      ),
                    widthSpace10,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: positiveButtonColor ?? red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: () => Get.back(result: true),
                      child: CustomText.kText(
                        confirmText ?? 'Ok',
                        color: white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black38,
    );

    return result;
  }

  static Future<void> info(String message, {String? title}) async {
    await show(
      title: title ?? 'Info',
      message: message,
      confirmText: 'Ok',
      showCancelButton: false,
    );
  }

  static Future<bool> confirm({
    required String message,
    String? title,
    String? confirmText,
    String? cancelText,
    bool barrierDismissible = true,
    Color? positiveButtonColor,
    Color? negativeButtonColor,
  }) async {
    final result = await show(
      title: title ?? 'Confirm',
      message: message,
      confirmText: confirmText ?? 'Yes',
      cancelText: cancelText ?? 'No',
      showCancelButton: true,
      barrierDismissible: barrierDismissible,
      positiveButtonColor: positiveButtonColor,
      negativeButtonColor: negativeButtonColor,
    );
    return result ?? false;
  }

  static Future<void> error(String message, {String? title}) async {
    await show(
      title: title ?? 'Error',
      message: message,
      confirmText: 'Close',
      showCancelButton: false,
    );
  }
}
