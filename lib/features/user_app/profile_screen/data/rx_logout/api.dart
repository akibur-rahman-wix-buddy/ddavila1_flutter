import 'dart:convert';

import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';


final class LogOutApi {
  static final LogOutApi _singleton = LogOutApi._internal();

  LogOutApi._internal();

  static LogOutApi get instance => _singleton;

  Future<Map> logOut() async {
    try {
      Response response = await postHttp(
        Endpoints.logoutApiLink(),
      );
      if (response.statusCode == 200) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
    }
  }
}
