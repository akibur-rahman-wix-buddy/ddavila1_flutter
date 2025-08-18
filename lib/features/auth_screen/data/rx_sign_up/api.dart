import 'dart:convert';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class SignUpApi {
  static final SignUpApi _singleton = SignUpApi._internal();

  SignUpApi._internal();

  static SignUpApi get instance => _singleton;

  Future<Map<String, dynamic>> signUpApi(
      {required dynamic email,
      required dynamic name,
      required dynamic confirmPassword,
      required bool terms,
      required dynamic password}) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "email": email,
        "name": name,
        "password": password,
        "password_confirmation": confirmPassword,
        "terms": terms,
      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.signUpUrl(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('Sing Up Successfully');
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
