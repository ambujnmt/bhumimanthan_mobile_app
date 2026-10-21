import '../../../../utils/app_imports.dart';
import '../property_details_screen_controller.dart';

class PdsSellerWidget extends StatelessWidget {
  PdsSellerWidget({super.key});
  final _con = Get.find<PropertyDetailsScreenController>();

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
                    height: 64,
                    width: 64,
                    clip: Clip.hardEdge,
                    padding: EdgeInsets.zero,
                    shape: BoxShape.circle,
                    child: _con.data.value!.agentImage == null
                        ? Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(Images.userIcon),
                          )
                        : AppNetworkImage(
                            imgUrl: _con.data.value!.agentImage,

                            fit: BoxFit.cover,
                          ),
                  ),
                  widthSpace10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText.kText(
                          _con.data.value!.agentName,
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                        CustomText.kText(
                          '${_con.data.value!.agentVerified ? ' Certified Property Consultant' : 'Not verified'} · ${_con.data.value!.agentExperience} of experience',
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
