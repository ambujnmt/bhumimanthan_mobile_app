import 'package:bhumi_manthan/views/widgets/app_network_image.dart';

import '../../../../utils/app_imports.dart';

class PdsSellerWidget extends StatelessWidget {
  const PdsSellerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Seller / Agent Information',
      content: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimentions.defaultScreenPadding,
        ),
        child: Column(
          children: [
            AppContainer(
              color: fromHex('f3f7fc'),
              child: Row(
                children: [
                  AppContainer(
                    clip: Clip.hardEdge,
                    padding: EdgeInsets.zero,
                    shape: BoxShape.circle,
                    child: AppNetworkImage(
                      height: 64,
                      width: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                  widthSpace10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText.kText(
                          'Aarav Gupta',
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                        CustomText.kText(
                          'Certified Property Consultant · 8 years experience',
                          size: 14,
                          color: AppColors.subtitle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            heightSpace15,
            AppTextfield(hintText: 'Your name'),
            AppTextfield(
              hintText: 'Your mobile number',
              inputType: TextInputType.phone,
            ),
            CustomButton(text: 'View Phone Number'),
          ],
        ),
      ),
    );
  }
}
