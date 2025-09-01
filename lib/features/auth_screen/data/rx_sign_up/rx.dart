import 'dart:developer';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';

import 'api.dart';

final class SignUpApiRx extends RxResponseInt<Map<String, dynamic>> {
  final api = SignUpApi.instance;

  SignUpApiRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> signUp(
      {
        required dynamic email,
    required dynamic name,
    required dynamic confirmPassword,
    required bool terms,
    required dynamic password}
      ) async {
    try {
      // Call the sign-in API
      Map<String, dynamic> data =
          await api.signUpApi(email: email, password: password,name: name,confirmPassword: confirmPassword,terms: terms);

      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      // Handle error
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {

    print(
        ">>>>>>>>>>>>>>>>>>>> here isthe access info rx :${appData.read(kKeyIsLoggedIn)}");
    print(
        ">>>>>>>>>>>>>>>>>>>> here is the user id :${appData.read(kKeyUserID)}");
    appData.write(kKeyIsLoggedIn, true);
    print(
        ">>>>>>>>>>>>>>>>>>>> here is the access info rx :${appData.read(kKeyIsLoggedIn)}");


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
