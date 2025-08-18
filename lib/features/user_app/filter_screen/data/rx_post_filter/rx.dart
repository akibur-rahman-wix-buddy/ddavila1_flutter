import 'dart:developer';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';

import 'api.dart';

final class RxFilterPostRx extends RxResponseInt<Map<String, dynamic>> {
  final api = RxFilterPostApi.instance;

  RxFilterPostRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> rxFilterPostInfo({
    required dynamic max,
    required dynamic min,
    required List<dynamic> subCat,
    required List<dynamic> value,
  }) async {
    try {
      // Call the sign-in API
      Map<String, dynamic> data =
          await api.rxFilterPostApi(
            value: value,
            max: max,
            min: max,
            subCat: subCat
          );

      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      // Handle error
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {
    // Extract the token from the response



    print(
        ">>>>>>>>>>>>>>>>>>>> here is the user id :${appData.read(kKeyUserID)}");
    appData.write(kKeyIsLoggedIn, true);
    print(
        ">>>>>>>>>>>>>>>>>>>> here is the access info rx :${appData.read(kKeyIsLoggedIn)}");

    // Update DioSingleton with the new token
    // Add the data to the stream
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
