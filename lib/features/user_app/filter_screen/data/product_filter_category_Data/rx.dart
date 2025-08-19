// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:ddavila/features/user_app/filter_screen/model/cetagory_wise_sub_category_model_data.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';


final class FilterCategoryRx extends RxResponseInt<ProductFIlterModelData> {
  final api = FilterCategoryApi.instance;

  FilterCategoryRx({required super.empty, required super.dataFetcher});

  ValueStream get getAvailableItemsStream => dataFetcher.stream;

  Future<ProductFIlterModelData?> filterCategoryData() async {
    try {
      final  data = await api.filterCategoryInfo();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final errorMessage = error.response?.data?["error"] ??
          error.response?.data?["message"] ??
          "An unknown error occurred.";

      // if (statusCode == 401) {
      //
      //   appData.write(kKeyIsLoggedIn, false);
      //   NavigationService.navigateToReplacement(Routes.loginScreen);
      // } else {
      //   ToastUtil.showShortToast(errorMessage);
      // }
    } else {
      ToastUtil.showShortToast("An unexpected error occurred.");
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return null;
  }
}

