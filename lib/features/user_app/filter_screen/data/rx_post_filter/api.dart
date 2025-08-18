import 'dart:convert';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class RxFilterPostApi {
  static final RxFilterPostApi _singleton = RxFilterPostApi._internal();

  RxFilterPostApi._internal();

  static RxFilterPostApi get instance => _singleton;

  Future<Map<String, dynamic>> rxFilterPostApi({
    required dynamic max,
    required dynamic min,
    required List<dynamic> subCat,
    required List<dynamic> value,
  }) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "subcat[]": subCat,
        "values[]": value,
        "max": max,
        "min": max,
      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.postFilterApiLink(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('Login Successfully');
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
