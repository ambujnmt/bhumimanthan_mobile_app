import 'package:bhumi_manthan/utils/app_imports.dart';

class SubmitUserDetailsController extends GetxController {
  final user = UserController.user.value;

  final _api = ApiServices();

  String? agentId;

  final otpSent = false.obs;

  final isLoading = false.obs;
  final isSubmitting = false.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  bool phoneReadOnly = false;

  final nameError = ''.obs;
  final emailError = ''.obs;
  final phoneError = ''.obs;

  Future<void> _getData() async {
    final res = await _api.get('endPoint');
    if (!res.success) return;
  }

  Future<void> onSend() async {
    if (!_validateForm()) return;
    closeKeyboard();

    isSubmitting(true);
    final success = await _sendOtp();
    isSubmitting(false);
    // if (!success || !isClosed) return;
    // Get.toNamed(
    //   AppRoutes.otpInputScreen,
    //   arguments: OtpInputArguments(
    //     waitDuration: Duration(seconds: 5),
    //     value: phoneController.text,
    //     onResend: () async {
    //       AppLoader.show();
    //       final success = await _sendOtp();
    //       AppLoader.close();
    //       return success;
    //     },
    //     onVerify: (otp) {},
    //   ),
    // );
    otpSent(true);
  }

  Future<bool> _sendOtp() async {
    final res = await _api.post(
      '/enquiry',
      payload: {
        // "property": property.slug,
        // "name": nameController.text,
        // "phone": phoneController.text,
        // "email": emailController.text,
        // 'subscribe': consent.value,
      },
      showErrorToast: true,
    );
    return res.success;
  }

  bool _validateForm() {
    bool isValid = true;

    // Name
    if (nameController.text.trim().isEmpty) {
      nameError.value = 'Please enter your name';
      isValid = false;
    } else if (nameController.text.trim().length < 3) {
      nameError.value = 'Name must be at least 3 characters';
      isValid = false;
    } else {
      nameError.value = '';
    }

    // Email (Optional)
    final email = emailController.text.trim();

    if (email.isNotEmpty && !GetUtils.isEmail(email)) {
      emailError.value = 'Please enter a valid email address';
      isValid = false;
    } else {
      emailError.value = '';
    }

    // Phone
    final phone = phoneController.text.trim();

    if (!GetUtils.isPhoneNumber(phone)) {
      phoneError.value = 'Please enter valid 10-digit phone number';
      isValid = false;
    } else {
      phoneError.value = '';
    }

    return isValid;
  }

  Future<void> refreshData() async {
    isLoading(true);
    await _getData();
    isLoading(false);
  }

  @override
  void onInit() {
    super.onInit();
    nameController.text = user?.name ?? '';
    // phoneController.text = user?.phone ?? '';
    // if (phoneController.text.isNotEmpty) {
    //   phoneReadOnly = true;
    // }
    final args = Get.arguments as Map<String, dynamic>?;
    agentId = args?['id']?.toString();
    if (agentId == null) return;
    refreshData();
  }
}
