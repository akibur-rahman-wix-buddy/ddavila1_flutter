import 'dart:developer';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/features/admin_app/auction_screen/data/post_products/post_products_api.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:image_picker/image_picker.dart'; // For XFile class

final class PostProductsAPIRx extends RxResponseInt<Map<String, dynamic>> {
  final api = PostProductsAPI.instance;

  PostProductsAPIRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> postProductSaleRX({
    required dynamic title,
    required dynamic description,
    required dynamic categoryId,
    required dynamic subcategoryId,
    required dynamic type,
    required dynamic shippingCost,
    required dynamic price,
    required dynamic shipWithin,
    required List<XFile>
        images, // Changed to List<XFile> to match PostProductsAPI
    required List<String>
        propertyItem, // List of strings for product properties
  }) async {
    try {
      // Call the updated postProductSale API
      Map<String, dynamic> data = await api.postProductSale(
        title: title,
        description: description,
        categoryId: categoryId,
        subcategoryId: subcategoryId,
        type: type,
        shippingCost: shippingCost,
        price: price,
        shipWithin: shipWithin,
        images: images,
        propertyItem: propertyItem,
      );

      log(">>>>>>>>>>>>>>> Product post response: $data");
      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  Future<Map<String, dynamic>> handleSuccessWithReturn(
      Map<String, dynamic> data) async {
    log(">>>>>>>>>>>>>>>>>>>>>>> Product post data: $data");

    // Handle token and user ID if present in the response (unlikely for product post)
    String? token;
    dynamic userId;
    if (data['data'] != null && data['data']['token'] != null) {
      token = data['data']['token']['original']['access_token'];
      userId = data['data']['user']?['id'];
      log(">>>>>>>>>>>>>>>>>>>>>>> Token: $token, User ID: $userId");

      // Save the token and login status using appData
      if (token != null) {
        appData.write(kKeyAccessToken, token);
        appData.write(kKeyIsLoggedIn, true);
        DioSingleton.instance.update(token);
      }
      if (userId != null) {
        appData.write(kKeyUserID, userId);
      }
      log(">>>>>>>>>>>>>>>>>>>>>>> Login status: ${appData.read(kKeyIsLoggedIn)}");
      log(">>>>>>>>>>>>>>>>>>>>>>> User ID: ${appData.read(kKeyUserID)}");
    } else {
      // Log product-specific data if no token/user ID
      log(">>>>>>>>>>>>>>>>>>>>>>> Product ID: ${data['data']?['product_id'] ?? 'N/A'}");
    }

    // Add the data to the stream
    dataFetcher.sink.add(data);

    return data;
  }

  @override
  Future<bool> handleErrorWithReturn(dynamic error) async {
    if (error is DioException) {
      if (error.response?.statusCode == 400) {
        ToastUtil.showShortToast(
            error.response?.data["error"] ?? "Invalid request");
      } else {
        ToastUtil.showShortToast(
            error.response?.data["message"] ?? "An error occurred");
      }
    } else {
      ToastUtil.showShortToast("An unexpected error occurred");
    }

    log("Error in postProductSaleRX: $error");
    dataFetcher.sink.addError(error);

    return false;
  }
}
