import 'package:pinput/pinput.dart';

import '../../../../../utils/app_imports.dart';

class CustomPinput extends StatelessWidget {
  final int length;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final RxString errorText;
  CustomPinput({
    super.key,
    this.length = 4,
    this.controller,
    this.onChanged,
    RxString? errorText,
  }) : errorText = errorText ?? ''.obs;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 65,
      height: 65,
      textStyle: CustomText.kTextStyle(size: 22, weight: FontWeight.w600),
      decoration: BoxDecoration(
        color: fromHex('e7f0f4'),
        borderRadius: BorderRadius.circular(AppDimentions.boxRadiusL),
        border: Border.all(color: grey[300]!),
      ),
    );
    return Column(
      children: [
        Pinput(
          length: length,
          controller: controller,
          defaultPinTheme: defaultPinTheme,
          onChanged: onChanged,
          focusedPinTheme: defaultPinTheme.copyWith(
            decoration: defaultPinTheme.decoration!.copyWith(
              border: Border.all(color: AppColors.secondary),
            ),
          ),
          submittedPinTheme: defaultPinTheme,
          cursor: Container(width: 2, height: 22, color: grey[600]),
        ),
        Obx(
          () => AnimatedSize(
            duration: Duration(milliseconds: 220),
            child: errorText.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 17),
                    child: SizedBox(
                      width: Get.width,
                      child: CustomText.kText(
                        errorText.value.tr,
                        color: red,
                        weight: FontWeight.w400,
                      ),
                    ),
                  )
                : SizedBox(width: Get.width),
          ),
        ),
      ],
    );
  }
}
