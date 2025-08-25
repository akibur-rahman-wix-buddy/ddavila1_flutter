import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // Controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Validation flags
  bool _isUsernameValid = false;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _doPasswordsMatch = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateUsername(String value) {
    setState(() {
      _isUsernameValid = value.length >= 4; // At least 4 characters
    });
  }

  void _validateEmail(String value) {
    setState(() {
      _isEmailValid =
          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
    });
  }

  void _validatePassword(String value) {
    setState(() {
      _isPasswordValid = value.length >= 8; // At least 8 characters
      if (_confirmPasswordController.text.isNotEmpty) {
        _doPasswordsMatch =
            _passwordController.text == _confirmPasswordController.text;
      }
    });
  }

  void _validateConfirmPassword(String value) {
    setState(() {
      _doPasswordsMatch = _passwordController.text == value;
    });
  }

  Future<void> _submitForm() async {

    if (_formKey.currentState!.validate() && isChecked) {
      setState(() {
        isLoading =true;
      });
      print(">>>>>>>>>>>> ${_usernameController.text} ");
      print(">>>>>>>>>>>> ${_emailController.text} ");
      print(">>>>>>>>>>>> ${_passwordController.text} ");
      print(">>>>>>>>>>>> ${_confirmPasswordController.text} ");
      print(">>>>>>>>>>>> ${isChecked} ");

 bool success =      await signUpApiRx.signUp(
          email: _emailController.text,
          name: _usernameController.text,
          confirmPassword: _confirmPasswordController.text,
          terms: isChecked,
          password: _passwordController.text);

   if(success){

     NavigationService.navigateTo(Routes.successScreen);
     setState(() {
       isLoading = false;
     });
   }
      setState(() {
        isLoading = false;
      });
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
                      'Sign Up!',
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
                      'Create a new account',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Username Field
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _usernameController,
                    onChanged: _validateUsername,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      if (value.length < 4) {
                        return 'Username must be at least 4 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: _isUsernameValid
                          ? const Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Icon(Icons.check, color: Colors.green),
                            )
                          : null,
                      hintText: 'Enter your username',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Email Field
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    onChanged: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: _isEmailValid
                          ? const Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Icon(Icons.check, color: Colors.green),
                            )
                          : null,
                      hintText: 'Enter your email',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Password Field
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    onChanged: _validatePassword,
                    obscureText: _obscurePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_isPasswordValid)
                              const Icon(Icons.check, color: Colors.green),
                            IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      hintText: 'Enter your password',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Confirm Password Field
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Confirm Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    onChanged: _validateConfirmPassword,
                    obscureText: _obscureConfirmPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_doPasswordsMatch &&
                                _passwordController.text.isNotEmpty)
                              const Icon(Icons.check, color: Colors.green),
                            IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      hintText: 'Confirm your password',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Terms Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                        activeColor: AppColor.c4275f6,
                      ),
                      Expanded(
                        child: Text(
                          'By creating an account you have to agree with our terms & conditions.',
                          style: const TextStyle(fontSize: 14),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 56),
                  // Sign Up Button
                isLoading? CircularProgressIndicator(color: Colors.blueAccent,):  CustomButton(
                    text: 'Sign Up',
                    context: context,
                    color:
                        isChecked && _formKey.currentState?.validate() == true
                            ? Colors.blueAccent
                            : Colors.grey,
                    minWidth: double.infinity,
                    onTap: _submitForm,
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
