


import 'dart:developer';

import 'package:ddavila/features/user_app/recent_won_bits/data/recent_won_product/api.dart';
import 'package:ddavila/features/user_app/recent_won_bits/model/recent_won_data_model.dart';
import 'package:ddavila/features/user_app/shop/data/shop_all_products/api.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';

final class GetRecentWonProductRx extends RxResponseInt<RecentWonDataModel> {
  final api = GetRecentWonProductApi.instance;

  GetRecentWonProductRx({required super.empty, required super.dataFetcher});

  ValueStream get getAvailableItemsStream => dataFetcher.stream;

  Future<RecentWonDataModel?> getRecentWonProductData( {dynamic pageNumber}) async {
    try {
      final  data = await api.getRecentWonApi(pageNumber: pageNumber);
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }


  @override
  RecentWonDataModel? handleSuccessWithReturn(dynamic data) {

    print("Input data value: $data");

    try {
      final result = super.handleSuccessWithReturn(data);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["message"]);
      } else if (error.response!.statusCode == 401) {
        NavigationService.navigateTo(Routes.loginScreen);
      } else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return null;
  }
}

