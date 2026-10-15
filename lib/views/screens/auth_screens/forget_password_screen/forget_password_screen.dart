import '../../../../utils/app_imports.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _api = ApiServices();

  final emailController = TextEditingController();
  final emailError = ''.obs;
  final apiError = ''.obs;

  final isLoading = false.obs;

  Future<void> _onSubmitted() async {
    apiError('');
    if (!GetUtils.isEmail(emailController.text)) {
      emailError('Please enter valid email address.');
      return;
    }
    closeKeyboard();
    isLoading(true);
    final res = await _api.post(
      '/forgot-password',
      payload: {"email": emailController.text},
    );
    isLoading(false);
    if (!res.success) {
      apiError(getErrorMessageFromRes(res.data));
      return;
    }
    Get.offNamed(
      AppRoutes.passwordResetSuccessScreen,
      arguments: {'email': emailController.text},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IgnorePointer(
          ignoring: isLoading.value,
          child: ListView(
            padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
            children: [
              SizedBox(height: Get.mediaQuery.padding.top + 80),
              CustomText.kText(
                'Forgot Password!',
                size: 30,
                weight: FontWeight.w800,
              ),
              CustomText.kText(
                'Enter registered email address to continue,\nWe will send a password reset link on it',
                size: 16,
                color: AppColors.subtitle,
              ),
              heightSpace40,
              AppTextfield(
                hintText: 'Email address',
                inputType: TextInputType.emailAddress,
                controller: emailController,
                errorText: emailError,
                onChanged: (input) {
                  emailError('');
                  apiError('');
                },
              ),
              heightSpace20,
              Obx(
                () => apiError.value.isEmpty
                    ? SizedBox.shrink()
                    : CustomText.kText(apiError.value, color: red),
              ),
              heightSpace20,
              CustomButton(
                showLoader: isLoading,
                text: 'Continue',
                onTap: () => _onSubmitted(),
              ),
              heightSpace40,
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordResetSuccessScreen extends StatelessWidget {
  const PasswordResetSuccessScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final e = (Get.arguments?['email'] as String?) ?? '';
    final email = e.isEmpty ? 'your email' : e;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mark_email_read_rounded,
                  size: 58,
                  color: Colors.green.shade600,
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Password Reset Link Sent!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF15243B),
                ),
              ),

              const SizedBox(height: 16),

              Text.rich(
                TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Colors.blueGrey,
                  ),
                  children: [
                    const TextSpan(
                      text: 'We have sent a password reset link to\n',
                    ),
                    TextSpan(
                      text: email,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF15243B),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              const Text(
                'Please check your inbox and follow the '
                'instructions to reset your password.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.blueGrey,
                ),
              ),

              const SizedBox(height: 40),

              CustomButton(text: 'Back to Login', onTap: Get.back),

              const SizedBox(height: 24),

              Text(
                'Didn’t receive the email? Check your spam folder.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
