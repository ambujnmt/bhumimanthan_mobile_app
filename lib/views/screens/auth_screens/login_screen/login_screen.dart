import 'dart:io';

import 'package:bhumi_manthan/utils/app_imports.dart';

import 'login_screen_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _con = Get.put(LoginScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
        children: [
          SizedBox(height: Get.mediaQuery.padding.top + 80),
          CustomText.kText(
            'Welcome Back!',
            size: 30,
            weight: FontWeight.w800,
            family: CustomFonts.outfit,
          ),
          CustomText.kText(
            'Login to Continue',
            size: 16,
            color: AppColors.subtitle,
          ),
          heightSpace40,
          AppTextfield(
            hintText: 'Email address',
            inputType: TextInputType.emailAddress,
            controller: _con.emailController,
            errorText: _con.emailError,
          ),
          AppTextfield(
            useObscure: true,
            bottomPad: 0,
            hintText: 'Password',
            controller: _con.passController,
            errorText: _con.passError,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Get.toNamed(AppRoutes.forgetPasswordScreen),
              child: CustomText.kText('Forgot Password?', color: blue),
            ),
          ),
          heightSpace50,
          CustomButton(text: 'Login', onTap: () => _con.onSubmit()),
          heightSpace30,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText.kText('Don’t have an Account? '),
              InkWell(
                onTap: () => Get.toNamed(AppRoutes.registerScreen),
                child: CustomText.kText('Sign up', color: AppColors.primary),
              ),
            ],
          ),
          heightSpace40,
          Row(
            children: [
              Expanded(child: Divider(color: grey[400])),
              widthSpace10,
              CustomText.kText('Or continue with', size: 16, color: grey),
              widthSpace10,
              Expanded(child: Divider(color: grey[400])),
            ],
          ),
          heightSpace20,
          InkWell(
            onTap: () => Get.toNamed(AppRoutes.mainScreen),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (Platform.isAndroid)
                  Image.asset(height: 70, width: 70, Images.googleIcon),
                widthSpace10,
                if (Platform.isIOS)
                  Image.asset(height: 70, width: 70, Images.appleIcon),
              ],
            ),
          ),
          heightSpace40,
        ],
      ),
    );
  }
}
