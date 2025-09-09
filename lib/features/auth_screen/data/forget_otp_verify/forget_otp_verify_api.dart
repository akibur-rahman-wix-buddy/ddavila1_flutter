import 'dart:convert';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class ForgetOTPVerifyAPI {
  static final ForgetOTPVerifyAPI _singleton = ForgetOTPVerifyAPI._internal();

  ForgetOTPVerifyAPI._internal();

  static ForgetOTPVerifyAPI get instance => _singleton;

  Future<Map<String, dynamic>> forgetOTPVerify({
    required dynamic email,
    required dynamic otp,
  }) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "email": email,
        "otp": otp,
      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.forgetOTPVerify(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));






        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error during signup: $error");
      rethrow;
    }
  }
}
