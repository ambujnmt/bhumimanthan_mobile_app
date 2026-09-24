import '../../../../utils/app_imports.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
        children: [
          SizedBox(height: Get.mediaQuery.padding.top + 80),
          CustomText.kText(
            'Forgot Password!',
            size: 30,
            weight: FontWeight.w800,
          ),
          CustomText.kText(
            'Enter registered mobile number to continue',
            size: 16,
            color: AppColors.subtitle,
          ),
          heightSpace40,
          AppTextfield(
            hintText: 'Mobile Number',
            inputType: TextInputType.phone,
          ),
          heightSpace40,
          CustomButton(text: 'Continue'),
          heightSpace40,
        ],
      ),
    );
  }
}
