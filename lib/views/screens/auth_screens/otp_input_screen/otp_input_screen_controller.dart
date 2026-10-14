import 'dart:async';

import '../../../../utils/app_imports.dart';

class OtpInputScreenController extends GetxController {
  final args = (Get.arguments ?? OtpInputArguments()) as OtpInputArguments;

  final otpController = TextEditingController();

  final otpError = ''.obs;

  Future<void> onResentTapped() async {
    final success = await args.onResend?.call() ?? false;
    if (!success) return;
    AppToast.success('OTP resent successfully.');
    otpController.clear();
    otpError('');
    startTimer();
  }

  Timer? timer;
  late final timeLeft = args.waitDuration.obs;

  void startTimer() {
    timeLeft.value = args.waitDuration;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timeLeft.value.inSeconds == 0) {
        t.cancel();
      } else {
        timeLeft.value -= const Duration(seconds: 1);
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }
}

class OtpInputArguments {
  final Duration waitDuration;
  final int length;
  final String value;

  final Future<bool> Function()? onResend;
  final Function(String otp)? onVerify;

  const OtpInputArguments({
    this.value = '',
    this.onResend,
    this.onVerify,
    this.waitDuration = const Duration(seconds: 90),
    this.length = 6,
  });
}
