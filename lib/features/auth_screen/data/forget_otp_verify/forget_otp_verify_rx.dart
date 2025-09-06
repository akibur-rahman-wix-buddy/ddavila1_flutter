import 'dart:developer';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/features/auth_screen/data/forget_otp_verify/forget_otp_verify_api.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';

final class ForgetOTPVerifyAPIRX extends RxResponseInt<Map<String, dynamic>> {
  final api = ForgetOTPVerifyAPI.instance;

  ForgetOTPVerifyAPIRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> forgetOTPVerifyRx({
    required dynamic email,
    required dynamic otp,
  }) async {
    try {
      // Call the sign-in API
      Map<String, dynamic> data = await api.forgetOTPVerify(
        email: email,
        otp: otp,
      );

      String token = data['token'];
      log(">>>>>>>>>>>>>>> login token is : $token");
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
    String token = data['token'];

    log(">>>>>>>>>>>>>>>>>>>>>>> here is the token:${token}");

    // Save the token and login status using appData
    appData.write(kKeyAccessToken, token);
    log(">>>>>> here is the access info rx :${appData.read(kKeyIsLoggedIn)}");

    // Update DioSingleton with the new token
    DioSingleton.instance.update(token);
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
