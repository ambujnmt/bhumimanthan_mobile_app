import 'package:flutter/gestures.dart';

import '../../../../utils/app_imports.dart';
import 'register_screen_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _con = Get.put(RegisterScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
        children: [
          SizedBox(height: Get.mediaQuery.padding.top + 80),
          CustomText.kText(
            'Welcome!',
            size: 30,
            weight: FontWeight.w800,
            family: CustomFonts.outfit,
          ),
          CustomText.kText(
            'Register to Continue',
            size: 16,
            color: AppColors.subtitle,
          ),
          heightSpace30,
          AppTextfield(
            isRequired: true,
            hintText: 'Name',
            inputType: TextInputType.name,
            controller: _con.nameController,
            errorText: _con.nameError,
          ),
          AppTextfield(
            isRequired: true,
            hintText: 'Email address',
            inputType: TextInputType.emailAddress,
            controller: _con.emailController,
            errorText: _con.emailError,
          ),
          AppTextfield(
            hintText: 'Mobile Number (Optional)',
            inputType: TextInputType.phone,
            controller: _con.phoneController,
            errorText: _con.phoneError,
          ),
          AppTextfield(
            isRequired: true,
            useObscure: true,
            hintText: 'Password',
            controller: _con.passController,
            errorText: _con.passError,
          ),
          AppTextfield(
            isRequired: true,
            useObscure: true,
            bottomPad: 0,
            hintText: 'Confirm password',
            controller: _con.cPassController,
            errorText: _con.cPassError,
          ),
          heightSpace10,
          Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  activeColor: AppColors.primary,
                  value: _con.terms.value,
                  onChanged: (value) => _con.terms.toggle(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                        children: [
                          const TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Open Terms & Conditions
                              },
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Open Privacy Policy
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          heightSpace15,
          CustomButton(text: 'Sign up', onTap: () => _con.onSubmit()),
          heightSpace30,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText.kText('Already have an Account? '),
              InkWell(
                onTap: Get.back,
                child: CustomText.kText('Login', color: AppColors.primary),
              ),
            ],
          ),

          heightSpace40,
        ],
      ),
    );
  }
}
