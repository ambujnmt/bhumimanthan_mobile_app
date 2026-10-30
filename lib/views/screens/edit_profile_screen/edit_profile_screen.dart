import 'package:bhumi_manthan/controllers/user_controller.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final user = UserController.user;

  late TextEditingController nameContorller;
  late TextEditingController phoneContorller;
  late TextEditingController emailContorller;

  final nameError = ''.obs;

  final isLoading = false.obs;

  Future<void> _saveNow() async {
    if (nameContorller.text.isEmpty) {
      nameError('Please enter name.');
      return;
    }
    closeKeyboard();
    isLoading(true);
    final res = await ApiServices().post(
      '/profile/update',
      payload: {'name': nameContorller.text},
      showErrorToast: true,
    );
    isLoading(false);
    if (!res.success) return;
    AppLoader.show();
    await UserController.getUser();
    AppLoader.close();
    Get.back();
    AppToast.success('Profile updated successfully.');
  }

  @override
  void initState() {
    super.initState();
    nameContorller = TextEditingController(text: user.value?.name);
    phoneContorller = TextEditingController(text: user.value?.phone);
    emailContorller = TextEditingController(text: user.value?.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Edit Profile'),
      body: Obx(
        () => IgnorePointer(
          ignoring: isLoading.value,
          child: ListView(
            padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
            children: [
              AppTextfield(
                isRequired: true,
                label: 'Name',
                hintText: 'Name',
                controller: nameContorller,
                errorText: nameError,
              ),
              AppTextfield(
                readOnly: true,
                label: 'Phone',
                hintText: 'Phone',
                controller: phoneContorller,
              ),
              AppTextfield(
                readOnly: true,
                label: 'Email Address',
                hintText: 'Email',
                controller: emailContorller,
              ),
              heightSpace20,
              CustomButton(
                showLoader: isLoading,
                text: 'Save',
                onTap: () => _saveNow(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
