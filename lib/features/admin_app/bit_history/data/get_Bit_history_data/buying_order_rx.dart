import 'dart:developer';
import 'package:ddavila/features/admin_app/bit_history/model/bit_history_data_model.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/rx_base.dart';
import 'buying_order_api.dart';

final class GetBidHistoryRX extends RxResponseInt<BidHistoryDataModel> {
  final api = GetBidHistoryAPI.instance;

  GetBidHistoryRX({required super.empty, required super.dataFetcher});

  Future<BidHistoryDataModel?> getBidHistoryRX() async {
    try {
      BidHistoryDataModel data = await api.getBidHistoryAPI();
      print("API Response: $data");

      // Check if the response has data
      if (data.data == null || data.data == null || data.data!.isEmpty) {
        print("Empty data received from API");
        dataFetcher.sink.add(BidHistoryDataModel(
          success: false,
          message: "No data available",
          data: null,
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
          dataFetcher.sink.add(BidHistoryDataModel(
            success: false,
            message: "No data available",
            data: null,
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