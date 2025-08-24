import 'dart:developer';
import 'package:ddavila/features/user_app/home_screen/model/product_search_data_model.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'api.dart';

final class SearchResultRx extends RxResponseInt<ProductSearchApiDataModel> {
  final api = SearchResultApi.instance;

  SearchResultRx({required super.empty, required super.dataFetcher});

  ValueStream<ProductSearchApiDataModel> get getFileData => dataFetcher.stream;

  Future<bool> searchResultApiInfo({
    required String query,
    required String result,
  }) async {
    try {
      log('Searching for: $query');
      // Call the search API
      Map<String, dynamic> data = await api.searchResultApiInfo(
        query: query,
        result: result,
      );
      log('API Response received: ${data['success']}');

      // Check if API call was successful
      if (data['success'] == true) {
        // Parse the response into your model
        ProductSearchApiDataModel searchResult = ProductSearchApiDataModel.fromJson(data);
        log('Parsed model successfully: ${searchResult.data?.data?.length} items');
        await handleSuccessWithReturn(searchResult);
        return true;
      } else {
        // Handle API error (success: false)
        log('API returned success: false with message: ${data['message']}');
        throw Exception(data['message'] ?? 'Search failed');
      }
    } catch (error) {
      log('Search error: $error');
      // Handle error
      return await handleErrorWithReturn(error);
    }
  }

  @override
  ProductSearchApiDataModel handleSuccessWithReturn(ProductSearchApiDataModel data) {
    log('Adding data to stream: ${data.data?.data?.length} items');
    // Add the data to the stream
    dataFetcher.sink.add(data);
    return data;
  }

  @override
  bool handleErrorWithReturn(dynamic error) {
    log('Error in RX: $error');
    String errorMessage = 'Search failed';

    // Handle API error using DioException
    if (error is DioException) {
      if (error.response?.statusCode == 400) {
        errorMessage = error.response?.data["error"] ?? 'Invalid search parameters';
      } else if (error.response?.data != null && error.response?.data is Map) {
        errorMessage = error.response?.data["message"] ?? 'Search failed';
      } else if (error.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Request timed out. Please try again.';
      } else {
        errorMessage = 'Network error occurred';
      }
    } else if (error is Exception) {
      errorMessage = error.toString().replaceFirst('Exception: ', '');
    }

    ToastUtil.showShortToast(errorMessage);
    dataFetcher.sink.addError(error);
    return false;
  }
}