import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/common_widgets/custom_textfiled.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  // Password visibility toggle - separate for each field
  bool currentObscure = true;
  bool newObscure = true;
  bool confirmObscure = true;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldMessengerKey,
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: AppColor.cFFFFFF,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIHelper.verticalSpace(16.h),

                  // Current Password
                  Text(
                    "Current password",
                    style: TextFontStyle.textLine12w500cFFFFFFLato.copyWith(
                      fontSize: 16,
                      color: AppColor.blackColor,
                    ),
                  ),
                  UIHelper.verticalSpace(10.h),
                  TextFormField(
                    controller: currentPassController,
                    obscureText: currentObscure,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(
                            currentObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              currentObscure = !currentObscure;
                            });
                          },
                        ),
                      ),
                      hintText: 'Enter your current password',
                      hintStyle: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.cAEAEAE,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your current password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  UIHelper.verticalSpace(16.h),

                  // New Password
                  Text(
                    "New password",
                    style: TextFontStyle.textLine12w500cFFFFFFLato.copyWith(
                      fontSize: 16,
                      color: AppColor.blackColor,
                    ),
                  ),
                  UIHelper.verticalSpace(10.h),
                  TextFormField(
                    controller: newPassController,
                    obscureText: newObscure,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(
                            newObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              newObscure = !newObscure;
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      if (value == currentPassController.text) {
                        return 'New password must be different from current password';
                      }
                      return null;
                    },
                  ),

                  UIHelper.verticalSpace(16.h),

                  // Confirm Password
                  Text(
                    "Confirm password",
                    style: TextFontStyle.textLine12w500cFFFFFFLato.copyWith(
                      fontSize: 16,
                      color: AppColor.blackColor,
                    ),
                  ),
                  UIHelper.verticalSpace(10.h),
                  TextFormField(
                    controller: confirmPassController,
                    obscureText: confirmObscure,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(
                            confirmObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              confirmObscure = !confirmObscure;
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != newPassController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  UIHelper.verticalSpace(250.h),

                  // Submit Button
                  Center(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : CustomButton(
                      onTap: _updatePassword,
                      text: 'Update Password',
                      context: context,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updatePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
     bool success =   await updatePasswordRx.updatePassword(
            oldPassword: currentPassController.text,
            newPassword: newPassController.text,
            newPasswordConfirmation: confirmPassController.text
        );
if(success){
  NavigationService.goBack;
}

        // Clear the form
        currentPassController.clear();
        newPassController.clear();
        confirmPassController.clear();

      } catch (error) {
        // Handle API errors
        String errorMessage = 'Failed to update password';

        if (error is ApiException) {
          errorMessage = error.message;
        } else if (error.toString().contains('network')) {
          errorMessage = 'Network error. Please check your connection.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            )
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    currentPassController.dispose();
    newPassController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }
}

// Add this class if you don't have it already for better error handling
class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}