import 'dart:developer';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';

import 'api.dart';

final class StripeCardAddRx extends RxResponseInt<Map<String, dynamic>> {
  final api = StripeCardAddApi.instance;

  StripeCardAddRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> stripeCardAddInfo({
    required dynamic paymentMethodId
  }) async {
    try {
      // Call the sign-in API
      Map<String, dynamic> data =
          await api.stripeCardAddInfo(paymentMethodId:paymentMethodId);

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
      } else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}
