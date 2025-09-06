


import 'dart:developer';

import 'package:ddavila/features/user_app/shop/data/shop_all_products/api.dart';
import 'package:ddavila/features/user_app/shop/model/shop_all_products.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';

final class GetShopRx extends RxResponseInt<ShopAllProductsDataModel> {
  final api = GetAllProductsApi.instance;

  GetShopRx({required super.empty, required super.dataFetcher});

  ValueStream get getAvailableItemsStream => dataFetcher.stream;

  Future<ShopAllProductsDataModel?> getShopData( {dynamic pageNumber}) async {
    try {
      final  data = await api.getShopApi(pageNumber: pageNumber);
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }


  @override
  ShopAllProductsDataModel? handleSuccessWithReturn(dynamic data) {

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

    } else {
      ToastUtil.showShortToast("An unexpected error occurred.");
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return null;
  }
}

