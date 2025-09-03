import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  // * Form key for validation
  final _formKey = GlobalKey<FormState>();

  // * Text editing controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // * Loading state
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // * Method to handle sign in
  Future<void> _signIn() async {
    // if (_formKey.currentState!.validate()) {
    //   setState(() {
    //     _isLoading = true;
    //   });

    //   try {
    //     bool success = await signInApiRx.signIn(
    //       email: _emailController.text,
    //       password: _passwordController.text,
    //     );
    //     if (success) {
    //       // Navigate to home screen or next screen after successful login
    //       NavigationService.navigateTo(Routes.navigationScreen);
    //     } else {
    //       ToastUtil.showLongToast("Failed");
    //     }
    //   } catch (e) {
    //     // Show error message
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text('Failed: ${e.toString()}'),
    //         backgroundColor: Colors.red,
    //       ),
    //     );
    //   } finally {
    //     if (mounted) {
    //       setState(() {
    //         _isLoading = false;
    //       });
    //     }
    //   }
    // }
    NavigationService.navigateToWithArgs(Routes.forgetOTPScreen, {
      'email': _emailController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.appLogo,
                    height: 100,
                    width: 200,
                  ),
                  const SizedBox(height: 72),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Forget Password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'If you forgot your password, Please reset it',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Email Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColor.c000000,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      suffixIcon: _emailController.text.isNotEmpty &&
                              !_emailController.text.contains('@')
                          ? Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: SvgPicture.asset(
                                AppIcons.checkMark,
                              ),
                            )
                          : null,
                      hintText: 'Enter your email',
                      hintStyle:
                          TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.cAEAEAE,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 56),
                  // Login Button
                  _isLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          onTap: _signIn,
                          text: 'Send OTP',
                          context: context,
                          minWidth: double.infinity,
                        ),
                  const SizedBox(height: 19),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
