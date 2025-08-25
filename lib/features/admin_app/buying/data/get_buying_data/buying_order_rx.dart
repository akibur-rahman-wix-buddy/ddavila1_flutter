import 'dart:developer';
import 'package:ddavila/features/admin_app/buying/model/buying_order_data_model.dart';
import 'package:dio/dio.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';
import 'buying_order_api.dart';

final class GetBuyingOrderRX extends RxResponseInt<BuyingOrderDataModel> {
  final api = GetBuyingOrderAPI.instance;

  GetBuyingOrderRX({required super.empty, required super.dataFetcher});

  Future<BuyingOrderDataModel?> getBuyingOrderRX() async {
    try {
      BuyingOrderDataModel data = await api.getBuyingOrderAPIAPI();
      print("$data");
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["message"]);
      } else if (error.response!.statusCode == 401) {
        // * NavigationService.navigateTo(Routes.loginScreen);
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
