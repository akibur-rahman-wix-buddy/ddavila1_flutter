import 'dart:convert';
import 'dart:developer';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/helpers/wab_view.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rxdart/streams.dart';

import 'api.dart';

final class BitPaymentRx extends RxResponseInt<Map<String, dynamic>> {
  final api = BitPaymentApi.instance;

  BitPaymentRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> bitPaymentInfo({required dynamic bitId}) async {
    try {
      Map<String, dynamic> data = await api.bitPaymentData(bitId: bitId);
      return await handleSuccessWithReturn(data);
    } catch (error) {
      // Handle error
      return await handleErrorWithReturn(error);
    }
  }

  @override
  Future<bool> handleSuccessWithReturn(Map<String, dynamic> data) async {
    try {
      dataFetcher.sink.add(data);

      // Check if the API response indicates success
      bool success = data['success'] ?? false;
      if (success) {
        if(data["data"]["checkout_url"].toString().isNotEmpty && data["data"]["checkout_url"] != null){
          Get.to(
              WebViewLink(link: data["data"]["checkout_url"])
          );
        }


        return true;
      } else {
        String errorMessage = data['message'] ?? "Payment failed";
        ToastUtil.showShortToast(errorMessage);
        return false;
      }
    } catch (e) {
      log("Error in handleSuccessWithReturn: $e");
      ToastUtil.showShortToast("Error processing payment");
      return false;
    }
  }

  @override
  Future<bool> handleErrorWithReturn(dynamic error) async {
    // Handle API error using DioException
    if (error is DioException) {
      if (error.response != null && error.response!.statusCode == 400) {
        String errorMessage = error.response!.data["message"] ?? "Payment failed!";
        ToastUtil.showShortToast(errorMessage);
        return false;
      } else if (error.response != null) {
        // Try to parse error message from response
        try {
          String errorMessage = error.response!.data["message"] ?? "An error occurred";
          if (error.response!.data is String) {
            // If response data is a string, try to parse it as JSON
            final parsedData = json.decode(error.response!.data);
            errorMessage = parsedData["message"] ?? "An error occurred";
          }
          ToastUtil.showShortToast(errorMessage);
        } catch (e) {
          ToastUtil.showShortToast("An error occurred");
        }
        return false;
      } else {
        ToastUtil.showShortToast("Network error occurred");
        return false;
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    ToastUtil.showShortToast("An unexpected error occurred");

    return false;
  }
}