import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/features/user_app/home_screen/model/category_wise_data_model.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helpers/navigation_service.dart' show NavigationService;

class CategoryProductsWidget extends StatefulWidget {
  const CategoryProductsWidget({super.key,required this.id, required this.screenName});
  final dynamic id;
  final dynamic screenName;

  @override
  State<CategoryProductsWidget> createState() => _CategoryProductsWidgetState();
}

class _CategoryProductsWidgetState extends State<CategoryProductsWidget> {


  @override
  void initState() {
    categoryWiseProductRx.categoryWiseProductData(id: widget.id);
    super.initState();
  }


  String formatDate(String isoDate) {
    try {
      DateTime date = DateTime.parse(isoDate);
      return "${date.month}/${date.day}/${date.year}";
    } catch (e) {
      return "Invalid date";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.screenName),
        backgroundColor: Colors.blueAccent,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            StreamBuilder<CategoryWiseProductDataModel>(
              stream: categoryWiseProductRx.dataFetcher,
              builder: (context, snapshot) {
                if (!snapshot.hasData || (snapshot.data?.data?.products?.data?.isEmpty ?? true)) {
                  return _buildErrorWidget("No data found.");
                }
                if(snapshot.connectionState == ConnectionState.waiting){
                  CircularProgressIndicator();
                }

                final data = snapshot.data?.data?.products?.data;
               return Expanded(
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 10,
                      childAspectRatio: .53,
                    ),
                    itemCount: data?.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: (){


                            print(" here is the data ${data[index].type}");

                            if( data[index].type.toString() == "sale"){
                              NavigationService.navigateToWithArgs(
                                  Routes.productDetailsScreen,
                                  {"slug": data[index].slug,});

                            }else{
                              NavigationService.navigateToWithArgs(
                                Routes.productsBidScreen,
                                {"slag": data[index].slug, "productId": data[index].id},
                              );
                            }

                          },
                          child: _buildProductItem(context, data![index]));
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(BuildContext context, ProductData product) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: .4, spreadRadius: .4)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(product),
            const SizedBox(height: 8),
            _buildProductTitle(product),
            const SizedBox(height: 8),
            _buildProductType(product),
            const SizedBox(height: 8),
            _buildProductPrice(product),
            const SizedBox(height: 8),
            _buildProductMetaInfo(product),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(ProductData product) {
    print(">>>>>>>>>>>>>>>>>> this is the image url ${"$image_url${product.images!.first}"}");
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        product.images?.isNotEmpty == true
            ? "$image_url${product.images!.first}" // Fixed: Added proper string concatenation
            : "",
        fit: BoxFit.cover,
        width: double.infinity,
        height: 200,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, color: Colors.grey, size: 50),
          );
        },
      ),
    );
  }

  Widget _buildProductTitle(ProductData product) {
    return SizedBox(
      height: 40,
      child: Text(
        product.title.toString() ?? "",
        style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildProductType(ProductData product) {
    return Text(
      product.type.toString() ?? "",
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.redAccent,
      ),
    );
  }

  Widget _buildProductPrice(ProductData product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${product.price.toString() ?? ""}',
          style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildProductMetaInfo(ProductData product) {
    return Row(
      children: [
        Text(
          '${product.bid ??0} bids',
          style: const TextStyle(fontSize: 10, color: Colors.red),
        ),
        UIHelper.horizontalSpace(12.h),
        Text(
          'Posted : ${formatDate(product.createdAt.toString() ?? "")}',
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}