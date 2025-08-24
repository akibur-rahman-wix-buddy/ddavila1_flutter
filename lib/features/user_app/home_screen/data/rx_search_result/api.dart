import 'dart:convert';
import 'dart:developer';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class SearchResultApi {
  static final SearchResultApi _singleton = SearchResultApi._internal();

  SearchResultApi._internal();

  static SearchResultApi get instance => _singleton;

  Future<Map<String, dynamic>> searchResultApiInfo({required dynamic query, required dynamic result}) async {
    try {
      log('Making API call with query: $query, result: $result');

      // Create the request data map
      Map<String, dynamic> data = {
        "q": query,
        "cat": result,
      };

      log('Request data: $data');

      // Make the POST request
      Response response = (await postHttp(Endpoints.searchResultApiLink(), data));

      log('API Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        // Check if response.data is already a Map
        if (response.data is Map<String, dynamic>) {
          log('Response is already a Map');
          return response.data;
        } else if (response.data is String) {
          log('Response is String, parsing JSON');
          return json.decode(response.data);
        } else {
          log('Unknown response type: ${response.data.runtimeType}');
          return {'success': false, 'message': 'Invalid response format'};
        }
      } else {
        log('API Error: ${response.statusCode} - ${response.statusMessage}');
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Error during search API call: $error");

      // Handle Dio errors
      if (error is DioException) {
        log('DioError: ${error.response?.statusCode} - ${error.response?.data}');
        if (error.response?.statusCode == 400) {
          ToastUtil.showShortToast(error.response?.data["error"] ?? 'Search failed');
        } else {
          ToastUtil.showShortToast(error.response?.data["message"] ?? 'Search failed');
        }
      }

      rethrow;
    }
  }
}
