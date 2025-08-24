import 'dart:developer';
import 'package:ddavila/features/admin_app/auction_screen/data/get_property/get_property_api.dart';
import 'package:ddavila/features/admin_app/auction_screen/model/property_model.dart';
import 'package:dio/dio.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';

final class GetPropertyAPIRX extends RxResponseInt<PropertyModel> {
  final api = GetPropertyAPI.instance;

  GetPropertyAPIRX({
    required super.empty,
    required super.dataFetcher,
  });

  Future<PropertyModel?> getPropertyRX() async {
    try {
      PropertyModel data = await api.getPropertyAPI();
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
        //NavigationService.navigateTo(Routes.loginScreen);
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
