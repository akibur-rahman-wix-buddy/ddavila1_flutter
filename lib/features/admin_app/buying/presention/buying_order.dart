import 'package:ddavila/common_widgets/custom_appbar.dart';
import 'package:ddavila/common_widgets/custom_textfiled.dart';
import 'package:ddavila/features/admin_app/buying/widget/buying_table.dart';
import 'package:ddavila/features/admin_app/seling/widget/selling_table.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';

class BuyingOrder extends StatefulWidget {
  const BuyingOrder({super.key});

  @override
  State<BuyingOrder> createState() => _BuyingOrderState();
}


class _BuyingOrderState extends State<BuyingOrder> {
  @override
  Widget  build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: 'Buying Order',isCenterTitle: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("25 Selling order",style: TextStyle(
                  color: Colors.black /* base-default-foreground */,
                  fontSize: 20,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  height: 1.40,
                ),),

                CustomTextField(hintText: "Search",fieldWidth: 200,borderRadius: 30,prefixIcon: Icon(Icons.search_sharp,size: 24,),)
              ],
            ),
            UIHelper.verticalSpace(12),
            BuyingTable(),

          ],

        ),
      ),
    );
  }
}
