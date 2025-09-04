import 'dart:developer';

import 'package:ddavila/features/admin_app/all_product/model/all_product_data_model.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';

import 'buying_order_api.dart';

final class GetAllProductRX extends RxResponseInt<AllProductDataModel> {
  final api = GetAllProductAPI.instance;

  GetAllProductRX({required super.empty, required super.dataFetcher});

  Future<AllProductDataModel?> getBuyingOrderRX() async {
    try {
      AllProductDataModel data = await api.getAllProductApi();
      print("API Response: $data");
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  AllProductDataModel? handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        final responseData = error.response!.data;
        if (error.response!.statusCode == 400) {
          final message = responseData is Map ? responseData["message"] : "Bad Request";
          ToastUtil.showShortToast(message.toString());
        } else if (error.response!.statusCode == 401) {
          NavigationService.navigateTo(Routes.loginScreen);
        } else if (error.response!.statusCode == 200 && responseData is Map && responseData.isEmpty) {
          dataFetcher.sink.add(AllProductDataModel(
            success: false,
            message: "No data available",
            data: ProductData(data: []),
            code: 200,
          ));
          return null;
        } else {
          final message = responseData is Map ? responseData["message"] : "An error occurred";
          ToastUtil.showShortToast(message.toString());
        }
      } else {
        ToastUtil.showShortToast("Network error occurred");
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return null;
  }
}

