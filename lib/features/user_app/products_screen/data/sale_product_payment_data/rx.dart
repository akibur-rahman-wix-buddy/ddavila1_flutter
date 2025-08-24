import 'dart:developer';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/helpers/wab_view.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rxdart/streams.dart';

import 'api.dart';

final class PostSaleProductPaymentRx extends RxResponseInt<Map<String, dynamic>> {
  final api = PostSaleProductPaymentApi.instance;

  PostSaleProductPaymentRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> saleProductStripePayment({
    required dynamic productId,
  }) async {
    try {
      // Call the sign-in API
      Map<String, dynamic> data =
          await api.saleProductStripePaymentInfo(productId: productId);

      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      // Handle error
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {




    print(">>>>>>>> stripe link is ${data["data"]["checkout_url"]}");


    if(data["data"]["checkout_url"].toString().isNotEmpty && data["data"]["checkout_url"] != null){
      Get.to(
          WebViewLink(link: data["data"]["checkout_url"])
      );
    }



    dataFetcher.sink.add(data);

    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    // Handle API error using DioException
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["error"]);
      } else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}
