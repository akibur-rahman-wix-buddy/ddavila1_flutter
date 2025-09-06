// // ignore_for_file: must_be_immutable
//
// import 'package:ddavila/assets_helper/app_colors.dart';
// import 'package:ddavila/assets_helper/app_icons.dart';
// import 'package:ddavila/assets_helper/app_image.dart';
// import 'package:ddavila/assets_helper/text_font_style.dart';
// import 'package:ddavila/common_widgets/custom_button.dart';
// import 'package:ddavila/helpers/ui_helpers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class ResetPasswordScreen extends StatefulWidget {
//   dynamic email, otp;
//   ResetPasswordScreen({
//     super.key,
//     this.email,
//     this.otp,
//   });
//
//   @override
//   State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
// }
//
// class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
//   // * Form key for validation
//   final _formKey = GlobalKey<FormState>();
//
//
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _ConfirmPasswordController = TextEditingController();
//
//   // * Loading state
//   bool _isLoading = false;
//
//   @override
//   void dispose() {
//     _ConfirmPasswordController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   // * Method to handle sign in
//   Future<void> _signIn() async {
//     // if (_formKey.currentState!.validate()) {
//     //   setState(() {
//     //     _isLoading = true;
//     //   });
//
//     //   try {
//     //     bool success = await signInApiRx.signIn(
//     //       email: _emailController.text,
//     //       password: _passwordController.text,
//     //     );
//     //     if (success) {
//     //       // Navigate to home screen or next screen after successful login
//     //       NavigationService.navigateTo(Routes.navigationScreen);
//     //     } else {
//     //       ToastUtil.showLongToast("Failed");
//     //     }
//     //   } catch (e) {
//     //     // Show error message
//     //     ScaffoldMessenger.of(context).showSnackBar(
//     //       SnackBar(
//     //         content: Text('Failed: ${e.toString()}'),
//     //         backgroundColor: Colors.red,
//     //       ),
//     //     );
//     //   } finally {
//     //     if (mounted) {
//     //       setState(() {
//     //         _isLoading = false;
//     //       });
//     //     }
//     //   }
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(24),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     AppImages.appLogo,
//                     height: 100,
//                     width: 200,
//                   ),
//                   const SizedBox(height: 72),
//                   const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'New Password Setup!',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Setup your new password, enjoy it',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                   // Email Field
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'New Password',
//                       style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: AppColor.c000000,
//                       ),
//                     ),
//                   ),
//                   TextFormField(
//                     controller: _ConfirmPasswordController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       suffixIcon: _ConfirmPasswordController.text.isNotEmpty &&
//                               !_ConfirmPasswordController.text.contains('@')
//                           ? Padding(
//                               padding: const EdgeInsets.all(14.0),
//                               child: SvgPicture.asset(
//                                 AppIcons.checkMark,
//                               ),
//                             )
//                           : null,
//                       hintText: 'Enter your new password',
//                       hintStyle:
//                           TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         color: AppColor.cAEAEAE,
//                       ),
//                     ),
//                   ),
//
//                   UIHelper.verticalSpaceMedium,
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Re-Type New Password',
//                       style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: AppColor.c000000,
//                       ),
//                     ),
//                   ),
//                   TextFormField(
//                     controller: _passwordController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//
//                       suffixIcon: _passwordController.text.isNotEmpty &&
//                               !_passwordController.text.contains('@')
//                           ? Padding(
//                               padding: const EdgeInsets.all(14.0),
//                               child: SvgPicture.asset(
//                                 AppIcons.checkMark,
//                               ),
//                             )
//                           : null,
//                       hintText: 'Enter your re-new password',
//                       hintStyle:
//                           TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         color: AppColor.cAEAEAE,
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 56),
//                   // Login Button
//                   _isLoading
//                       ? const CircularProgressIndicator()
//                       : CustomButton(
//                           onTap: _signIn,
//                           text: 'Reset Password',
//                           context: context,
//                           minWidth: double.infinity,
//                         ),
//                   const SizedBox(height: 19),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: must_be_immutable

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
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordScreen extends StatefulWidget {
  dynamic email;
  ResetPasswordScreen({
    super.key,
    this.email,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // * Form key for validation
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // * Password visibility states
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // * Loading state
  bool _isLoading = false;

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // * Method to handle password reset
  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Your API call logic here
        bool success = await resetPasswordRx.resetPasswordInfo(
          email: widget.email,
          password: _passwordController.text,
          password_confirmation: _confirmPasswordController.text
        );

        if (success) {
          // Navigate to success screen or login screen
          NavigationService.navigateTo(Routes.loginScreen);
          ToastUtil.showLongToast("Password reset successfully");
        } else {
          ToastUtil.showLongToast("Password reset failed");
        }
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed: ${e.toString()}'),
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

  // * Password validation method
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    // Check for minimum length
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }


    return null;
  }

  // * Confirm password validation method
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
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
                      'New Password Setup!',
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
                      'Setup your new password, enjoy it',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // New Password Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'New Password',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColor.c000000,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    validator: _validatePassword,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      hintText: 'Enter your new password',
                      hintStyle: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.cAEAEAE,
                      ),
                    ),
                  ),
                  UIHelper.verticalSpaceMedium,
                  // Confirm Password Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Re-Type New Password',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColor.c000000,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    validator: _validateConfirmPassword,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                      hintText: 'Confirm your new password',
                      hintStyle: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.cAEAEAE,
                      ),
                    ),
                  ),
                  const SizedBox(height: 56),
                  // Reset Password Button
                  _isLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                    onTap: _resetPassword,
                    text: 'Reset Password',
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