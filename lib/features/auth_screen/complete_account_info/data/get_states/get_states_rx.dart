import 'dart:developer';
import 'package:ddavila/features/auth_screen/complete_account_info/data/get_states/get_states_api.dart';
import 'package:ddavila/features/auth_screen/complete_account_info/model/state_model.dart';
import 'package:dio/dio.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';

final class GetStateApiRX extends RxResponseInt<StatesModel> {
  final api = GetStateAPI.instance;

  GetStateApiRX({required super.empty, required super.dataFetcher});

  Future<StatesModel?> states() async {
    try {
      StatesModel data = await api.getStateApi();
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
