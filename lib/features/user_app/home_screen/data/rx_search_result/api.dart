import 'dart:convert';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';



final class SearchResultApi {

  static final  SearchResultApi _singleton = SearchResultApi._internal();

  SearchResultApi._internal();

  static  SearchResultApi get instance => _singleton;

  Future<Map<String, dynamic>> searchResultApiInfo({required dynamic query, required dynamic result}) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "q": query,
        "cat": result,
      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.searchResultApiLink(), data));

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
