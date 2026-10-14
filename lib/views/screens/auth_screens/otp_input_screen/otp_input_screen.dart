import '../../../../utils/app_imports.dart';
import 'otp_input_screen_controller.dart';
import 'widgets/custom_otp_widget.dart';

class OtpInputScreen extends StatefulWidget {
  const OtpInputScreen({super.key});

  @override
  State<OtpInputScreen> createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OtpInputScreen> {
  final _con = Get.put(OtpInputScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
        children: [
          SizedBox(height: Get.mediaQuery.padding.top),
          heightSpace100,
          CustomText.kText('Verify Account', size: 24, weight: FontWeight.w600),
          heightSpace10,
          Center(
            child: CustomText.kText(
              'Enter the 6-digit code sent on\n ${_con.args.value}',
              size: 16,
              color: fromHex('#3F3F3F'),
              align: TextAlign.center,
            ),
          ),
          SizedBox(height: 120),
          CustomPinput(
            length: _con.args.length,
            controller: _con.otpController,
            errorText: _con.otpError,
          ),
          SizedBox(height: 90),
          Center(
            child: Obx(() {
              final canResend = _con.timeLeft.value.inSeconds < 1;
              if (canResend) {
                return TextButton(
                  onPressed: () => _con.onResentTapped(),
                  child: CustomText.kText(
                    'Resend OTP',
                    color: canResend ? AppColors.primary : grey,
                    size: 18,
                  ),
                );
              }
              final duration = _con.timeLeft.value;
              final minutes = duration.inMinutes;
              final seconds = duration.inSeconds % 60;
              return TextButton(
                onPressed: null,
                child: CustomText.kText(
                  'Resend in ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                  color: canResend ? AppColors.primary : grey,
                  size: 18,
                ),
              );
            }),
          ),
          heightSpace20,
          CustomButton(
            text: 'Verify OTP',
            onTap: () {
              if (_con.otpController.text.length < _con.args.length) {
                _con.otpError('Please enter valid 6-digit verification code.');
                return;
              }
              _con.args.onVerify?.call(_con.otpController.text);
            },
          ),
          heightSpace25,
          TextButton(
            onPressed: Get.back,
            child: CustomText.kText(
              'Cancel',
              color: red,
              size: 17,
              weight: FontWeight.w600,
            ),
          ),
          heightSpace40,
        ],
      ),
    );
  }
}
