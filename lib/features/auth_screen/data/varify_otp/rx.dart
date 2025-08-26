import 'dart:developer';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';

import 'api.dart';

final class VerificationOtpRx extends RxResponseInt<Map<String, dynamic>> {
  final api = VerifyOtpApi.instance;

  VerificationOtpRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> verificationInfo({
    required dynamic email,
    required dynamic otp,
  }) async {
    try {
      Map<String, dynamic> data = await api.verifyOtpApi(email: email, otp: otp);
      return await handleSuccessWithReturn(data);
    } catch (error) {
      // Handle error
      return await handleErrorWithReturn(error);
    }
  }

  @override
  Future<bool> handleSuccessWithReturn(Map<String, dynamic> data) async {
    try {
      // Check if the response indicates success
      if (data['status'] == true && data['message']?.toString().toLowerCase().contains('success') == true) {
        // Extract the token from the response
        String token = data['token'] ?? '';

        if (token.isNotEmpty) {
          print(">>>>>>>>>>>>>>>>>>>>>>> here is the token:${token}");

          // Save the token and login status using appData
          appData.write(kKeyAccessToken, token); // Storing the token
          print(">>>>>>>>>>>>>>>>>>>> here is the access info rx :${appData.read(kKeyIsLoggedIn)}");
          appData.write(kKeyIsLoggedIn, true);
          print(">>>>>>>>>>>>>>>>>>>> here is the access info rx :${appData.read(kKeyIsLoggedIn)}");

          // Update DioSingleton with the new token
          DioSingleton.instance.update(token);
        }

        // Add the data to the stream
        dataFetcher.sink.add(data);

        // Show success message
        ToastUtil.showShortToast(data['message'] ?? "OTP verified successfully!");

        return true;
      } else {
        // If the response doesn't indicate success, treat it as an error
        ToastUtil.showShortToast(data['message'] ?? "Verification failed");
        return false;
      }
    } catch (e) {
      log("Error in handleSuccessWithReturn: $e");
      ToastUtil.showShortToast("Error processing verification");
      return false;
    }
  }

  @override
  Future<bool> handleErrorWithReturn(dynamic error) async {
    // Handle API error using DioException
    if (error is DioException) {
      if (error.response != null && error.response!.statusCode == 400) {
        String errorMessage = error.response!.data["message"] ?? "Invalid OTP!";
        ToastUtil.showShortToast(errorMessage);

        // Still return false to indicate failure, but the toast will show the message
        return false;
      } else if (error.response != null) {
        String errorMessage = error.response!.data["message"] ?? "An error occurred";
        ToastUtil.showShortToast(errorMessage);
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