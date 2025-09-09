// import 'package:ddavila/common_widgets/custom_button.dart';
// import 'package:ddavila/helpers/all_routes.dart';
// import 'package:ddavila/helpers/navigation_service.dart';
// import 'package:ddavila/networks/api_acess.dart';
// import 'package:flutter/material.dart';
// import 'package:ddavila/assets_helper/text_font_style.dart';
//
// class OtpVerificationScreen extends StatefulWidget {
//   final dynamic email;
//   const OtpVerificationScreen({super.key, this.email});
//
//   @override
//   State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
// }
//
// class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
//   final List<TextEditingController> _controllers =
//   List.generate(4, (_) => TextEditingController());
//   final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
//
//   bool _isLoading = false;
//
//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     for (var node in _focusNodes) {
//       node.dispose();
//     }
//     super.dispose();
//   }
//
//
//
//   void _onOtpChanged(String value, int index) {
//     if (value.length == 1 && index < _controllers.length - 1) {
//       _focusNodes[index + 1].requestFocus();
//     } else if (value.isEmpty && index > 0) {
//       _focusNodes[index - 1].requestFocus();
//     }
//   }
//
//
//
//   Future<void> _verifyOtp() async {
//     String otp = _controllers.map((c) => c.text).join();
//     if (otp.length < 4) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter a 4-digit code")),
//       );
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       bool success = await verificationOtpRx.verificationInfo(
//         email: widget.email,
//         otp: otp,
//       );
//
//       setState(() {
//         _isLoading = false;
//       });
//
//       if (success) {
//         NavigationService.navigateTo(Routes.successScreen);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("OTP Verified Successfully!")),
//         );
//       }
//       // No else needed here because the error is already handled in verificationInfo
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//     }
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "Enter the verification code",
//                 style: TextFontStyle.textLine20w400cFFFFFFDvSans
//                     .copyWith(color: Colors.black, fontSize: 22),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 "We sent a code to",
//                 style: TextFontStyle.textLine20w400cFFFFFFDvSans
//                     .copyWith(color: Colors.black, fontSize: 16),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 widget.email.toString(),
//                 style: TextFontStyle.textLine20w400cFFFFFFDvSans
//                     .copyWith(color: Colors.blueAccent, fontSize: 16),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: List.generate(
//                   4,
//                       (index) => SizedBox(
//                     width: 60,
//                     child: TextField(
//                       controller: _controllers[index],
//                       focusNode: _focusNodes[index],
//                       maxLength: 1,
//                       keyboardType: TextInputType.number,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(fontSize: 24),
//                       decoration: InputDecoration(
//                         counterText: "",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onChanged: (value) => _onOtpChanged(value, index),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//
//
//               TextButton(onPressed: () async {
//
//                 await resendOtpRx.resendOtpInfo(email: widget.email);
//
//               }, child: Text("Resend "))
//
//
//               // Show button or loading indicator
//               _isLoading
//                   ? const CircularProgressIndicator()
//                   : CustomButton(
//                 text: "Submit",
//                 context: context,
//                 onTap: () {
//                   _verifyOtp();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async'; // Add this import
import 'package:flutter/material.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';

class OtpVerificationScreen extends StatefulWidget {
  final dynamic email;
  const OtpVerificationScreen({super.key, this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  bool _isLoading = false;
  bool _canResend = false;
  int _resendCountdown = 60;
  late Timer _resendTimer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _resendTimer.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _canResend = false;
      _resendCountdown = 60;
    });

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() {
          _resendCountdown--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < _controllers.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> _verifyOtp() async {
    String otp = _controllers.map((c) => c.text).join();
    if (otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a 4-digit code")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      bool success = await verificationOtpRx.verificationInfo(
        email: widget.email,
        otp: otp,
      );

      setState(() {
        _isLoading = false;
      });

      if (success) {
        NavigationService.navigateTo(Routes.successScreen);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP Verified Successfully!")),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  Future<void> _resendOtp() async {
    if (!_canResend) return;

    try {
      await resendOtpRx.resendOtpInfo(email: widget.email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP sent successfully!")),
      );
      _startResendTimer();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to resend OTP: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Enter the verification code",
                style: TextFontStyle.textLine20w400cFFFFFFDvSans
                    .copyWith(color: Colors.black, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "We sent a code to",
                style: TextFontStyle.textLine20w400cFFFFFFDvSans
                    .copyWith(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                widget.email.toString(),
                style: TextFontStyle.textLine20w400cFFFFFFDvSans
                    .copyWith(color: Colors.blueAccent, fontSize: 16),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                      (index) => SizedBox(
                    width: 60,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24),
                      decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) => _onOtpChanged(value, index),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Resend OTP button with countdown
              TextButton(
                onPressed: _canResend ? _resendOtp : null,
                child: Text(
                  _canResend
                      ? "Resend OTP"
                      : "Resend in $_resendCountdown seconds",
                  style: TextStyle(
                    color: _canResend ? Colors.blue : Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Show button or loading indicator
              _isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                text: "Submit",
                context: context,
                onTap: _verifyOtp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}