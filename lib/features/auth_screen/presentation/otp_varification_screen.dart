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
//   final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
//   final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
//
//   @override
//   void dispose() {
//     for (var controller in _controllers) controller.dispose();
//     for (var node in _focusNodes) node.dispose();
//     super.dispose();
//   }
//
//   void _onOtpChanged(String value, int index) {
//     if (value.length == 1 && index < _controllers.length - 1) {
//       _focusNodes[index + 1].requestFocus();
//     } else if (value.isEmpty && index > 0) {
//       _focusNodes[index - 1].requestFocus();
//     }
//   }
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
//
//     bool success = await verificationOtpRx.verificationInfo(email: widget.email, otp: otp);
//
//     if (success) {
//       NavigationService.navigateTo(Routes.otpVerificationScreen);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("OTP Verified Successfully!")),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Invalid OTP, try again.")),
//       );
//     }
//   }
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
//                 "na********@chaublog.com",
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
//               CustomButton(text: "Submit" , context:context,
//                 onTap: () {
//                   _verifyOtp();
//                   String otp = _controllers.map((c) => c.text).join();
//                   print("Entered OTP: $otp");
//                 },),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
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
      // No else needed here because the error is already handled in verificationInfo
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
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

              // Show button or loading indicator
              _isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                text: "Submit",
                context: context,
                onTap: () {
                  _verifyOtp();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
