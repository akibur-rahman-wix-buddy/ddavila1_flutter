
// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:ddavila/features/user_app/home_screen/model/category_wise_data_model.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class PopularCategoryWiseProductRx extends RxResponseInt<CategoryWiseProductDataModel> {
  final api = PopularCategoryWiseProductApi.instance;

  PopularCategoryWiseProductRx({required super.empty, required super.dataFetcher});

  // Add a BehaviorSubject to track loading state
  final BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>.seeded(false);

  ValueStream<bool> get isLoadingStream => _isLoading.stream;
  bool get isLoading => _isLoading.value;

  ValueStream<CategoryWiseProductDataModel?> get getAvailableItemsStream => dataFetcher.stream;

  Future<CategoryWiseProductDataModel?> popularCategoryWiseProductData({required dynamic id}) async {
    try {
      // Clear previous data and set loading to true
      _clearPreviousData();
      _isLoading.add(true);

      final data = await api.popularCategoryWiseProductApi(id: id);
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    } finally {
      _isLoading.add(false);
    }
  }

  // Method to clear previous data
  void _clearPreviousData() {
    dataFetcher.add(empty);
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final errorMessage = error.response?.data?["error"] ??
          error.response?.data?["message"] ??
          "An unknown error occurred.";
    } else {
      ToastUtil.showShortToast("An unexpected error occurred.");
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return null;
  }

  @override
  void dispose() {
    _isLoading.close();
    super.dispose();
  }
}