import 'dart:developer';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeCardScreen extends StatefulWidget {
  const StripeCardScreen({super.key});

  @override
  State<StripeCardScreen> createState() => _StripeCardScreenState();
}

class _StripeCardScreenState extends State<StripeCardScreen> {
  final CardEditController _controller = CardEditController();
  CardFieldInputDetails? _cardDetails;

  @override
  void initState() {
    super.initState();

    // Listen to controller updates (optional)
    _controller.addListener(() {
      setState(() {});
    });
  }

  void _createPaymentMethod() async {
    if (_cardDetails == null || !_cardDetails!.complete) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete the card form")),
      );
      return;
    }

    try {
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );

      log('🟢 Payment Method ID: ${paymentMethod.id}');


      bool success = await stripeCardAddRx.stripeCardAddInfo(paymentMethodId: paymentMethod.id);

      if(success){
        mySelfRx.mySelfData();
        NavigationService.navigateToRemoveuntil(Routes.navigationScreen);
      }

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("🟢 Payment Method ID: ${paymentMethod.id}")),
      // );
    } catch (e) {
      log('🔴 Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isValid = _cardDetails?.complete ?? false;

    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: IconButton(onPressed: (){

                    NavigationService.goBack;

                  }, icon: Icon(Icons.arrow_circle_left,color: Colors.white,size: 45,))),
        
              Center(
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
        
                      // CardField for card input
                      CardField(
                        controller: _controller,
                        onCardChanged: (card) {
                          setState(() {
                            _cardDetails = card;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Card Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                        style: const TextStyle(fontSize: 16),
                        enablePostalCode: false,
                        cursorColor: Colors.blue,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: isValid ? _createPaymentMethod : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isValid ? Colors.blue : Colors.grey,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text("Submit"),
                      ),
        
                      UIHelper.verticalSpace(24.h),
        
                      CustomButton(text: "Go back ",onTap:(){
                        NavigationService.goBack;
                      } , context: context)
        
                    ],
                  ),
                ),
              ),
        
        
              SizedBox()
        
        
            ],
          ),
        ),
      ),
    );
  }
}
