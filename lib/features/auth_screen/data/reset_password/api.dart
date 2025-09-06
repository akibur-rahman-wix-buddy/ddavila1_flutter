import 'dart:convert';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:dio/dio.dart';

import '../../../../../networks/exception_handler/data_source.dart';



final class ResetPasswordApi {

  static final  ResetPasswordApi _singleton = ResetPasswordApi._internal();

  ResetPasswordApi._internal();

  static  ResetPasswordApi get instance => _singleton;

  Future<Map<String, dynamic>> resetPasswordApi({required String email,required dynamic password,required dynamic password_confirmation,}) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "email": email,
        "password": password,
        "password_confirmation": password_confirmation,
      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.forgetPasswordChangeApiLink(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('password changes');
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
