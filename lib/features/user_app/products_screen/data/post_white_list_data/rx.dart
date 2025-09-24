
import 'dart:developer';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'api.dart';

final class PostWhiteListRx extends RxResponseInt<Map<String, dynamic>> {
  final api = PostWhiteListApi.instance;

  PostWhiteListRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> postWhiteListApiInfo({
    required dynamic productId,
  }) async {
    try {
      // FIXED: Pass productId directly instead of recursive call
      Map<String, dynamic> data = await api.postWhiteListApi(productId: productId);

      await handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      // Handle error
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
      if (error.response?.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["error"]);
      } else {
        ToastUtil.showShortToast(error.response?.data["message"] ?? "An error occurred");
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}