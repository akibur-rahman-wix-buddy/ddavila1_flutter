import 'dart:developer';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';

import 'api.dart';

final class UpdatePasswordRx extends RxResponseInt<Map<String, dynamic>> {
  final api = UpdateProfileApi.instance;

  UpdatePasswordRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> updatePassword({
    required dynamic oldPassword,
    required dynamic newPassword,
    required dynamic newPasswordConfirmation,
  }) async {
    try {



      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> old password${oldPassword.toString()}");
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> new password${newPassword.toString()}");
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> new confirmation password${newPasswordConfirmation.toString()}");







      Map<String, dynamic> data = await api.updatePasswordApi(
          newPassword: newPassword,
          newPasswordConfirmation: newPasswordConfirmation,
          oldPassword: oldPassword);

      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      // Handle error
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {
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
