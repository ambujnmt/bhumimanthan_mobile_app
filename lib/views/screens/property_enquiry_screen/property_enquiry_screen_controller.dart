import 'package:bhumi_manthan/models/propertiy_details_model.dart';

import '../../../utils/app_imports.dart';
import '../../widgets/app_dropdown.dart';

class PropertyEnquiryScreenController extends GetxController {
  late final PropertyDetailsModel property;

  final isLoading = false.obs;

  final selectedBudget = Rxn<CustomDropdownItem>();
  final selectedInterest = Rxn<CustomDropdownItem>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final moreController = TextEditingController();

  final nameError = ''.obs;
  final phoneError = ''.obs;
  final emailError = ''.obs;
  final typeError = ''.obs;
  final budgetError = ''.obs;
  final moreError = ''.obs;

  Future<void> onSend() async {
    if (!_validateForm()) return;
    closeKeyboard();
    isLoading(true);
    final res = await ApiServices().post(
      '/enquiry',
      payload: {
        "property": property.slug,
        "name": nameController.text,
        "phone": phoneController.text,
        "email": emailController.text,
        "interested_in": selectedInterest.value?.value,
        "budget": selectedBudget.value?.value,
        "message": moreController.text,
      },
      showErrorToast: true,
    );
    isLoading(false);
    if (!res.success) return;
    Get.offNamed(AppRoutes.enquirySuccessScreen, arguments: {'data': property});
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

    // Phone
    final phone = phoneController.text.trim();

    if (!GetUtils.isPhoneNumber(phone)) {
      phoneError.value = 'Please enter valid 10-digit phone number';
      isValid = false;
    } else {
      phoneError.value = '';
    }

    // Email (optional, but validate if entered)
    final email = emailController.text.trim();

    if (!GetUtils.isEmail(email)) {
      emailError.value = 'Please enter a valid email address';
      isValid = false;
    } else {
      emailError.value = '';
    }

    // Interested property type
    if (selectedInterest.value == null) {
      typeError.value = 'Please select a property type';
      isValid = false;
    } else {
      typeError.value = '';
    }

    // Budget
    if (selectedBudget.value == null) {
      budgetError.value = 'Please select your budget';
      isValid = false;
    } else {
      budgetError.value = '';
    }

    // Message
    if (moreController.text.trim().isEmpty) {
      moreError.value = 'Please enter your enquiry message';
      isValid = false;
    } else {
      moreError.value = '';
    }

    return isValid;
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;

    property = args['data'] as PropertyDetailsModel;
  }
}

class EnquirySuccessScreen extends StatelessWidget {
  const EnquirySuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final property = Get.arguments['data'] as PropertyDetailsModel;

    final propertyTitle = property.title;
    final propertyImage = property.mainImage;
    final propertyLocation = property.location;
    final propertyPrice = formatPrice(property.price);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  // Success illustration
                  Container(
                    height: 116,
                    width: 116,
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.10),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        height: 82,
                        width: 82,
                        decoration: const BoxDecoration(
                          color: Color(0xFF269B68),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 52,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    'Enquiry Submitted!',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Thank you for your interest. Your enquiry has '
                    'been submitted successfully. Our team will '
                    'get in touch with you soon.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Property summary
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant,
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: 92,
                            height: 92,
                            child: AppNetworkImage(
                              imgUrl: propertyImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ENQUIRY FOR',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  letterSpacing: 1.1,
                                  fontWeight: FontWeight.w700,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                propertyTitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                propertyLocation,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                propertyPrice,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // What happens next
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: theme.colorScheme.primary.withValues(alpha: 0.05),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.support_agent_rounded,
                          size: 28,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'What happens next?',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Our property team will review your enquiry '
                                'and contact you with further details.',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  height: 1.5,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  CustomButton(
                    text: 'Go Back',
                    color: transparent,
                    textColor: black,
                    border: Border.all(color: AppColors.secondary, width: 1.2),
                    onTap: Get.back,
                  ),
                  heightSpace100,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
