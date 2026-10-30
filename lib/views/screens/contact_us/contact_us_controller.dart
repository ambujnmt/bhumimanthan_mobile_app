import '../../../utils/app_imports.dart';

class ContactUsController extends GetxController {
  final showLoader = false.obs;

  final subController = TextEditingController(),
      messController = TextEditingController();

  final subError = ''.obs, messError = ''.obs;

  Future<void> onSubmitTapped() async {
    if (subController.text.isEmpty) {
      subError('This field is required.');
      return;
    } else if (messController.text.isEmpty) {
      messError('This field is required.');
      return;
    }
    closeKeyboard();
    showLoader(true);
    final res = await ApiServices().post(
      '/support/contact',
      payload: {"subject": subController.text, "message": messController.text},
      showErrorToast: true,
    );
    showLoader(false);
    if (isClosed || !res.success) return;
    // Get.offNamed(AppRoutes.contactUsSuccessScreen);
  }
}
