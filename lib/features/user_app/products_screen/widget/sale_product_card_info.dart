import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/features/user_app/products_screen/model/sale_product_details_data_model.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/html_text_viewer.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductInfoCard extends StatefulWidget {
  final SaleData data;
  final String? stateName;
  final double productPercentage;
  final double myShippingCost;
  final double totalAmount;
  final bool isWhiteListing;
  final bool isProcessing;
  final dynamic myId;
  final String slug;
  final ValueChanged<bool> onToggleProcessing;
  final ValueChanged<bool> onToggleWhiteListing;

  const ProductInfoCard({
    super.key,
    required this.data,
    required this.stateName,
    required this.productPercentage,
    required this.myShippingCost,
    required this.totalAmount,
    required this.isWhiteListing,
    required this.isProcessing,
    required this.myId,
    required this.slug,
    required this.onToggleProcessing,
    required this.onToggleWhiteListing,
  });

  @override
  State<ProductInfoCard> createState() => _ProductInfoCardState();
}

class _ProductInfoCardState extends State<ProductInfoCard> {
  bool _isCoreFeaturesExpanded = false;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    double taxAmount =
        (double.tryParse(data.price?.toString() ?? '0') ?? 0.0) * widget.productPercentage / 100;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.cDCE4E6,
            blurRadius: 9.9,
            offset: Offset(0, 0.1),
          ),
        ],
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Name
            Text(
              data.title.toString(),
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16.0),

            /// Description
            Text(
              'Description',
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            HtmlToWidgetRenderer(htmlData: data.description.toString()),
            const SizedBox(height: 16.0),

            /// Core Features
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Core Feature',
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isCoreFeaturesExpanded = !_isCoreFeaturesExpanded;
                    });
                  },
                  icon: Icon(
                    _isCoreFeaturesExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            if (_isCoreFeaturesExpanded && data.properties != null && data.properties!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data.properties!
                    .map(
                      (property) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(property.title ?? "Feature",
                            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey[700])),
                        Text(property.value ?? "",
                            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black)),
                      ],
                    ),
                  ),
                )
                    .toList(),
              )
            else if (_isCoreFeaturesExpanded)
              const Text("No core features available",
                  style: TextStyle(fontSize: 14.0, color: Colors.grey)),

            Divider(color: Colors.black, thickness: 1.0),

            /// Tax
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tax: ${widget.stateName ?? "N/A"} (${widget.productPercentage.toStringAsFixed(2)}%)',
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '\$${taxAmount.toStringAsFixed(2)}',
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            /// Shipping
            UIHelper.verticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Shipping Price:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("\$${widget.myShippingCost.toStringAsFixed(2)}"),
              ],
            ),

            /// Product Price
            UIHelper.verticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Product Price:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("\$${data.price?.toString() ?? "0.00"}"),
              ],
            ),
            Divider(color: Colors.grey.withOpacity(0.5)),

            /// Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("Total Price:", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text("\$${widget.totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black)),
                ]),
                widget.isProcessing
                    ? const CircularProgressIndicator(color: Colors.blueAccent)
                    : CustomButton(
                  onTap: () {
                    widget.onToggleProcessing(true);
                    postSaleProductPaymentRx.saleProductStripePayment(productId: data.id);
                    widget.onToggleProcessing(false);
                  },
                  text: widget.isProcessing ? "Buying..." : 'Buy Now',
                  context: context,
                  minWidth: 150,
                ),
              ],
            ),
            UIHelper.verticalSpace(24.h),

            /// Whitelist Button
            CustomButton(
              text: widget.isWhiteListing
                  ? "Whitelisting..."
                  : data.bookmark.toString() == "true"
                  ? "Added to whitelist"
                  : "Add to whitelist",
              minWidth: double.infinity,
              color: Colors.white,
              onTap: () async {
                widget.onToggleWhiteListing(true);
                bool success = await postWhiteListRx.postWhiteListApiInfo(productId: data.id);
                if (success) {
                  await productViewDetailsRx.categoryWiseProductData(slug: widget.slug);
                }
                widget.onToggleWhiteListing(false);
              },
              textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
              borderColor: Colors.black,
              context: context,
            ),

            UIHelper.verticalSpace(24.h),

            /// Contact Seller
            widget.myId != data.userId
                ? CustomButton(
              text: "Contact Seller",
              minWidth: double.infinity,
              onTap: () {
                createConversationRx.createConversations(userId: data.userId);
              },
              context: context,
            )
                : CustomButton(
              text: "It's your product",
              minWidth: double.infinity,
              onTap: () {
                ToastUtil.showLongToast("It's your product");
              },
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
