// ignore_for_file: avoid_print, deprecated_member_use

import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/features/user_app/products_screen/model/sale_product_details_data_model.dart';
import 'package:ddavila/helpers/html_text_viewer.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, required this.slug});

  final String slug;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  bool isWhiteListing = false;
  bool _isProcessing = false;


  bool isLoading= false;

  @override
  void initState() {
    productViewDetailsRx.categoryWiseProductData(slug: widget.slug);
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:StreamBuilder<ProductDetailsDataModel>(
          stream: productViewDetailsRx.dataFetcher,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  UIHelper.verticalSpace(10.h),
                  const Text(
                    "Loading...",
                    style: TextStyle(color: Colors.red),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong!"));
            } else if (!snapshot.hasData || snapshot.data?.data == null) {
              return const Center(child: Text("No data found."));
            } else {


              final data = snapshot.data?.data;

              return  SingleChildScrollView(
                child: Column(
                  children: [
                    ProductImageSlider(
                      image: data?.productDetailsImages ??[],
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.6,
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
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Name and Rating
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data?.title.toString()??"",
                                        style: TextFontStyle
                                            .textLine7w400cFFFFFFDmSans
                                            .copyWith(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),

                                      SizedBox(height: 16.0),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.0),
                              // Availability
                              Text(
                                'Description',
                                style:
                                TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              // Description


                              HtmlToWidgetRenderer(
                                htmlData: data?.description.toString()??"",
                              ),



                              // Text(
                              //   data?.description.toString()??"",
                              //   style: TextFontStyle.textLine7w400cFFFFFFDmSans
                              //       .copyWith(
                              //       fontSize: 12.0,
                              //       color: Colors.black.withOpacity(0.7)),
                              // ),
                              SizedBox(height: 16.0),
                              // Price
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Price:',
                                        style: TextFontStyle
                                            .textLine7w400cFFFFFFDmSans
                                            .copyWith(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        "\$${data?.price.toString()??""}",
                                        style: TextFontStyle
                                            .textLine7w400cFFFFFFDmSans
                                            .copyWith(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                isLoading? CircularProgressIndicator(color: Colors.blueAccent,):  CustomButton(

                                    onTap: (){

                                      setState(() {
                                        isLoading =true;
                                      });

                                      postSaleProductPaymentRx.saleProductStripePayment(productId: data?.id);
                                      setState(() {
                                        isLoading =false;
                                      });

                                    },
                                    text: 'Buy Now',
                                    context: context,
                                    minWidth: 200,
                                  ),
                                ],
                              ),
                              UIHelper.verticalSpace(24.h),


                        CustomButton(
                          // text: "white list",
                        text: isWhiteListing
                        ? "Whitelisting..."
                            : data?.bookmark.toString() == "true"
                            ? "Added to whitelist"
                            : "Add to whitelist",
                        minWidth: double.infinity,
                        color: Colors.white,
                        onTap: () async {
                          setState(() {
                            isWhiteListing = true;
                          });

                          bool success = await postWhiteListRx.postWhiteListApiInfo(productId: data?.id);

                          if (success) {
                            await productViewDetailsRx.categoryWiseProductData(slug: widget.slug);
                            setState(() {
                              isWhiteListing = false;
                            });
                          }

                          setState(() {
                            isWhiteListing = false;
                          });
                        },
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        borderColor: Colors.black,
                        context: context,
                      ),

                              // Buy Now Button
                              UIHelper.verticalSpace(24.h),
                              CustomButton(text: "Contact Seller",minWidth: double.infinity,
                                  textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18),

                                  onTap: ()  {

                                   createConversationRx.createConversations(userId: data?.userId);
                                  },
                                  context: context)
                              // Buy Now Button
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

// class ProductsScreen extends StatefulWidget {
//   const ProductsScreen({super.key, required this.slug});
//
//   final String slug;
//
//   @override
//   State<ProductsScreen> createState() => _ProductsScreenState();
// }

class ProductImageSlider extends StatefulWidget {

  const ProductImageSlider({super.key, required this.image});


 final  List image;

  @override
  _ProductImageSliderState createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int _currentIndex = 0;

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.image.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  widget.image[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          Positioned(
            top: 10.0,
            left: 16.0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(AppIcons.arrowBack),
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            right: 16.0,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 9.9,
                      offset: Offset(0, 0.1),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(
                  AppIcons.cartIcon,
                  height: 44.0,
                  width: 44.0,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.image.length,
                (index) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1.5,
                      color: _currentIndex == index
                          ? Colors.red
                          : Colors.transparent,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 1.0),
                      height: _currentIndex == index ? 10.0 : 6.0,
                      width: _currentIndex == index ? 10.0 : 6.0,
                      decoration: BoxDecoration(
                        color:
                            _currentIndex == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
