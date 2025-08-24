// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
//
// class StripeCardScreen extends StatefulWidget {
//   const StripeCardScreen({super.key});
//
//   @override
//   State<StripeCardScreen> createState() => _StripeCardScreenState();
// }
//
// class _StripeCardScreenState extends State<StripeCardScreen> {
//   final CardEditController _controller = CardEditController();
//   bool _isValid = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() {
//       setState(() {
//         _isValid = _controller.complete; // Stripe auto-validates card
//       });
//     });
//   }
//
//   void _submitCard() {
//
//     print(">>>>>>>>>>>>>>>>. here is validation: $_isValid");
//      print(">>>>>>>>>>>>>>>>. here is card details: ${_controller.details}");
//
//
//
//     if (_isValid) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Card is valid ✅")),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Invalid card ❌")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue.shade900,
//       body: Center(
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           margin: const EdgeInsets.symmetric(horizontal: 20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//
//
//
//
//               CardField(
//                 controller: _controller,
//                 decoration: const InputDecoration(
//                   labelText: "Card number",
//                   border: InputBorder.none,
//                   enabled: false,
//                 ),
//                 style: const TextStyle(fontSize: 16),
//                 enablePostalCode: false, // Disable postal codec
//                 cvcHintText : "", // Disable CVC field
//                 expirationHintText: "", // Disable expiry date field
//               ),
//
//
//
//
//               // CardField(
//               //   controller: _controller,
//               //   decoration: const InputDecoration(
//               //     labelText: "Card number",
//               //     border: InputBorder.none,
//               //     enabled: false,
//               //   ),
//               //   style: const TextStyle(fontSize: 16),
//               //   enablePostalCode: true, // Hide postal code if not needed
//               // ),
//
//
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submitCard,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   minimumSize: const Size(double.infinity, 50),
//                 ),
//                 child: const Text("Submit"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeCardScreen extends StatefulWidget {
  const StripeCardScreen({super.key});

  @override
  State<StripeCardScreen> createState() => _StripeCardScreenState();
}

class _StripeCardScreenState extends State<StripeCardScreen> {
  final CardEditController _controller = CardEditController();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isValid = _controller.complete;
      });
    });
  }

  void _submitCard() {
    print("Validation: $_isValid");
    print("Card details: ${_controller.details}");

    if (_isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Card is valid ✅")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid card ❌")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Card Field with only number visible
              CardField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "Card Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                style: const TextStyle(fontSize: 16),
                // These settings help minimize the appearance of other fields
                enablePostalCode: false,
                cursorColor: Colors.blue,
                // // You can also try setting the width to force only number field
                // width: double.infinity,
                // height: 60, // Adjust height to fit only one field
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitCard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}