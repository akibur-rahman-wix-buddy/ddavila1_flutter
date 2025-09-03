// import 'dart:developer';
// import 'package:ddavila/features/admin_app/seling/model/selling_order_data_model.dart';
// import 'package:ddavila/helpers/all_routes.dart';
// import 'package:ddavila/helpers/navigation_service.dart';
// import 'package:dio/dio.dart';
// import '../../../../../helpers/toast.dart';
// import '../../../../../networks/rx_base.dart';
// import 'buying_order_api.dart';
//
// final class GetSellingOrderRX extends RxResponseInt<SellingOrderDataModel> {
//   final api = GetSellingOrderAPI.instance;
//
//   GetSellingOrderRX({required super.empty, required super.dataFetcher});
//
//   Future<SellingOrderDataModel?> getSellingOrderRX() async {
//     try {
//       SellingOrderDataModel data = await api.getSellingOrderAPIAPI();
//       print("$data");
//       return handleSuccessWithReturn(data);
//     } catch (error) {
//       return handleErrorWithReturn(error);
//     }
//   }
//
//   @override
//   handleErrorWithReturn(dynamic error) {
//     if (error is DioException) {
//       if (error.response!.statusCode == 400) {
//         ToastUtil.showShortToast(error.response!.data["message"]);
//       } else if (error.response!.statusCode == 401) {
//      NavigationService.navigateTo(Routes.loginScreen);
//       } else {
//         ToastUtil.showShortToast(error.response!.data["message"]);
//       }
//     }
//
//     log(error.toString());
//     dataFetcher.sink.addError(error);
//     // throw error;
//     return null;
//   }
// }


import 'dart:developer';
import 'package:ddavila/features/admin_app/seling/model/selling_order_data_model.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/rx_base.dart';
import 'buying_order_api.dart';

final class GetSellingOrderRX extends RxResponseInt<SellingOrderDataModel> {
  final api = GetSellingOrderAPI.instance;
  GetSellingOrderRX({required super.empty, required super.dataFetcher});

  Future<void> getSellingOrderRX() async {
    try {
      SellingOrderDataModel data = await api.getSellingOrderAPIAPI();
      log("Fetched data: $data");
      dataFetcher.sink.add(data); // Add data to stream
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["message"]);
      } else if (error.response?.statusCode == 401) {
        NavigationService.navigateTo(Routes.loginScreen);
      } else {
        ToastUtil.showShortToast(error.response?.data["message"] ?? "Unknown error");
      }
    }
    log("Error: $error");
    dataFetcher.sink.addError(error);
    return null;
  }
}