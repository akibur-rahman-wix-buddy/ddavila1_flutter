import 'dart:developer';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';

import 'api.dart';

final class BuyingOrderConfirmRx extends RxResponseInt<Map<String, dynamic>> {
  final api = BuyingOrderConfirmApi.instance;

  BuyingOrderConfirmRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> buyingOrderConfirmInfo({
    required dynamic productId,
  }) async {
    try {
      Map<String, dynamic> data =
          await api.buyingOrderConfirmInfo(productId: productId);

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
