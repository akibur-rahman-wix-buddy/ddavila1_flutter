import 'dart:convert';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class ForgetEmailAPI {
  static final ForgetEmailAPI _singleton = ForgetEmailAPI._internal();

  ForgetEmailAPI._internal();

  static ForgetEmailAPI get instance => _singleton;

  Future<Map<String, dynamic>> forgetEmailAPI({
    required dynamic email,
  }) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "email": email,
      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.forgetEmail(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('OTP sent to your email');
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
