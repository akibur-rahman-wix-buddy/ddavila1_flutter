import 'dart:developer';
import 'package:ddavila/features/admin_app/all_product/data/edit_products/edit_seller_products_api.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:image_picker/image_picker.dart'; // For XFile class

final class EditSellerProductAPIRX extends RxResponseInt<Map<String, dynamic>> {
  final api = EditSellerProductAPI.instance;

  EditSellerProductAPIRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> updateSaleProductsRX({
    required dynamic productId,
    dynamic title,
    dynamic description,
    dynamic categoryId,
    dynamic subcategoryId,
    dynamic type,
    // * ########## sales data #########
    dynamic shippingCost,
    dynamic buyNowPrice,
    dynamic shipWithin,
    // * ###############################
    List<XFile>? images,
    List<dynamic>? propertyItem,
    List<dynamic>? propertyValue,
  }) async {
    try {
      // Call the updated updateSaleProducts API
      Map<String, dynamic> data = await api.updateSaleProducts(
        productId: productId,
        title: title,
        description: description,
        categoryId: categoryId,
        subcategoryId: subcategoryId,
        type: type,
        shippingCost: shippingCost,
        buyNowPrice: buyNowPrice,
        shipWithin: shipWithin,
        images: images,
        propertyItem: propertyItem,
        propertyValue: propertyValue,
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
