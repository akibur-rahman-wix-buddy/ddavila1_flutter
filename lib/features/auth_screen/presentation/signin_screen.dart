import 'package:custom_social_button/custom_social_button.dart';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Password visibility toggle
  bool _obscurePassword = true;

  // Loading state
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Method to handle sign in
  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        bool success = await signInApiRx.signIn(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (success) {
          // Navigate to home screen or next screen after successful login
          NavigationService.navigateTo(Routes.navigationScreen);
        } else {
          ToastUtil.showLongToast(" login failed");
        }
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
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
                      'Welcome!',
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
                      'please login or sign up to continue our app',
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
                  const SizedBox(height: 25),
                  // Password Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColor.c000000,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      hintText: 'Enter your password',
                      hintStyle:
                          TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.cAEAEAE,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  UIHelper.verticalSpace(10.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        NavigationService.navigateTo(Routes.forgetPasswordScreen);
                      },
                      child: Text(
                        'Forgot Password?',
                        style:
                            TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.cAEAEAE,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 56),
                  // Login Button
                  _isLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          onTap: _signIn,
                          text: 'Login',
                          context: context,
                          minWidth: double.infinity,
                        ),
                  const SizedBox(height: 19),
                  // Or divider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: const Color(0xFFEDEDED),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 25),
                      Text(
                        'Or',
                        style:
                            TextFontStyle.textLine12w300c919191Roboto.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.c919191,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 150,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: const Color(0xFFEDEDED),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 19),
                  // Google Sign In Button
                  SocialButton(
                    title: 'google',
                    buttonTitle: 'Sign in with Google',
                    color: AppColor.cFFFFFF,
                    height: 52.0,
                    width: double.infinity,
                    borderRadius: 67.0,
                    borderColor: AppColor.c666666.withAlpha(35),
                    borderWidth: 2.0,
                    textStyle: const TextStyle(
                      color: AppColor.c666666,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    iconHeight: 24.0,
                    iconWidth: 24.0,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Google sign in tapped!'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          NavigationService.navigateTo(Routes.signUpScreen);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: AppColor.c4275f6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
