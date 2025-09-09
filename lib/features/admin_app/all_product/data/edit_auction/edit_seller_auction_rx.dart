// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'package:ddavila/features/admin_app/all_product/data/edit_auction/edit_seller_auction_api.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:image_picker/image_picker.dart'; // For XFile class

final class EditAuctionProductRX extends RxResponseInt<Map<String, dynamic>> {
  final api = EditAuctionProductAPI.instance;

  EditAuctionProductRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> updateProductAuctionRX({
    required dynamic productId,
    dynamic title,
    dynamic description,
    dynamic categoryId,
    dynamic subcategoryId,
    dynamic type,
    dynamic shippingCost,
    dynamic price,
    dynamic shipWithin,
    dynamic auction_end_at,
    List<XFile>? images,
    List<dynamic>? propertyItem,
    List<dynamic>? propertyValue,
  }) async {
    try {
      // Call the updated postProductSale API
      Map<String, dynamic> data = await api.updateProductAuction(
        productId: productId,
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
        propertyValue: propertyValue,
        auction_end_at: auction_end_at,
      );

      log(">>>>>>>>>>>>>>> Auction Product post response: $data");
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
