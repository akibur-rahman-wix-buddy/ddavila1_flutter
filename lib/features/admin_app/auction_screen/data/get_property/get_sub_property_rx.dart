import 'dart:developer';
import 'package:ddavila/features/admin_app/auction_screen/data/get_property/get_sub_property_api.dart';
import 'package:ddavila/features/admin_app/auction_screen/model/sub_property_model.dart';
import 'package:dio/dio.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';

final class GetSubPropertyAPIRX extends RxResponseInt<SubPropertyModel> {
  final api = GetSubPropertyAPI.instance;

  GetSubPropertyAPIRX({
    required super.empty,
    required super.dataFetcher,
  });

  Future<SubPropertyModel?> getSubPropertyRX(dynamic title) async {
    try {
      SubPropertyModel data = await api.getSubProperty(title);
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
