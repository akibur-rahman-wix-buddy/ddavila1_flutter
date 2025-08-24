import 'package:ddavila/common_widgets/custom_appbar.dart';
import 'package:ddavila/common_widgets/custom_textfiled.dart';
import 'package:ddavila/features/admin_app/auction_screen/widget/my_auction_table.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';

class MyActionHistory extends StatefulWidget {
  const MyActionHistory({super.key});

  @override
  State<MyActionHistory> createState() => _MyActionHistoryState();
}

class _MyActionHistoryState extends State<MyActionHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: 'My Auction History',isCenterTitle: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("34 Auction",style: TextStyle(
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
            MyAuctionTable(),


          ],

        ),
      ),
    );
  }
}
