import 'package:ddavila/features/user_app/products_screen/presentation/bidding_people_list.dart';
import 'package:flutter/material.dart';
import '../model/live_action_details_model.dart';

class ActiveAuctionSection extends StatelessWidget {
  final ProductData product;

  const ActiveAuctionSection({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: product.bids?.length ?? 0,
        itemBuilder: (context, index) {
          return BiddingPeopleList(
            type: product.bids?[index].user?.email.toString() ?? "",
            image: product.bids![index].user?.avatar.toString() ?? "",
            name: product.bids![index].user?.name ?? "",
            value: product.bids![index].amount?.toString() ?? "0",
          );
        },
      ),
    );
  }
}