import 'dart:developer';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';

import 'api.dart';

final class SellingOrderConfirmRx extends RxResponseInt<Map<String, dynamic>> {
  final api = SellingOrderConfirmApi.instance;

  SellingOrderConfirmRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> sellingOrderConfirmInfo({
    required dynamic companyName,
    required dynamic trackingNumber ,
    required dynamic productId,
  }) async {
    try {
      Map<String, dynamic> data =
          await api.sellingOrderConfirmInfo(productId: productId,
          companyName: companyName,
          trackingNumber: trackingNumber);

      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {

    dataFetcher.sink.add(data);

    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    // Handle API error using DioException
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["error"]);
      }  if (error.response!.statusCode == 401) {

        NavigationService.navigateToRemoveuntil(Routes.loginScreen);

      } else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}
