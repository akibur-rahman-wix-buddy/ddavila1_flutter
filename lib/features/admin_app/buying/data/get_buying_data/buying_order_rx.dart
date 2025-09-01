import 'dart:developer';
import 'package:ddavila/features/admin_app/buying/model/buying_order_data_model.dart';
import 'package:ddavila/features/admin_app/dashboard_screen/data/admindash_api.dart';
import 'package:ddavila/features/admin_app/dashboard_screen/model/admin_dash_model.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:dio/dio.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';
import 'buying_order_api.dart';

// final class GetBuyingOrderRX extends RxResponseInt<BuyingOrderDataModel> {
//   final api = GetBuyingOrderAPI.instance;
//
//   GetBuyingOrderRX({required super.empty, required super.dataFetcher});
//
//   Future<BuyingOrderDataModel?> getBuyingOrderRX() async {
//     try {
//       BuyingOrderDataModel data = await api.getBuyingOrderAPIAPI();
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
//         // * NavigationService.navigateTo(Routes.loginScreen);
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



final class GetBuyingOrderRX extends RxResponseInt<BuyingOrderDataModel> {
  final api = GetBuyingOrderAPI.instance;

  GetBuyingOrderRX({required super.empty, required super.dataFetcher});

  Future<BuyingOrderDataModel?> getBuyingOrderRX() async {
    try {
      BuyingOrderDataModel data = await api.getBuyingOrderAPIAPI();
      print("API Response: $data");

      // Check if the response is empty or invalid
      if (data.data == null || data.data!.data == null || data.data!.data!.isEmpty) {
        print("Empty data received from API");
        dataFetcher.sink.add(BuyingOrderDataModel(
          success: false,
          message: "No data available",
          data: BuyingOrderData(data: []), // Empty data list
          code: 200,
        ));
        return null;
      }

      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      // Check if response exists before accessing its properties
      if (error.response != null) {
        final responseData = error.response!.data;
        if (error.response!.statusCode == 400) {
          final message = responseData is Map ? responseData["message"] : "Bad Request";
          ToastUtil.showShortToast(message.toString());
        } else if (error.response!.statusCode == 401) {
           NavigationService.navigateTo(Routes.loginScreen);
        } else if (error.response!.statusCode == 200 && responseData is Map && responseData.isEmpty) {
          // Handle empty response with 200 status
          dataFetcher.sink.add(BuyingOrderDataModel(
            success: false,
            message: "No data available",
            data: BuyingOrderData(data: []),
            code: 200,
          ));
          return null;
        } else {
          final message = responseData is Map ? responseData["message"] : "An error occurred";
          ToastUtil.showShortToast(message.toString());
        }
      } else {
        // Handle cases where error.response is null (e.g., network errors)
        ToastUtil.showShortToast("Network error occurred");
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return null;
  }
}