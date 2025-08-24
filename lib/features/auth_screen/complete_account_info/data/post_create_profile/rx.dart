import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class CompleteProfileApiRx
    extends RxResponseInt<Map<String, dynamic>> {
  final api = CompleteProfileApi.instance;

  CompleteProfileApiRx(
      {required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> completeProfileApi({
    required dynamic terms,
    required dynamic phone,
    required dynamic address,
    required dynamic zip_code,
    required dynamic state,
    required dynamic city,
    required dynamic country,
  }) async {
    try {
      // Call the sign-in API
      Map<String, dynamic> data = await api.completeApi(
          terms: terms,
        phone: phone,
        address: address,
        zip_code: zip_code,
        state: state,
        city: city,
        country: country
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
        // Show error message from the response
        //ToastUtil.showShortToast(error.response!.data["error"]);
      } else {
        // Show general message for other status codes
        //ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }
    // Log the error and add it to the stream
    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}