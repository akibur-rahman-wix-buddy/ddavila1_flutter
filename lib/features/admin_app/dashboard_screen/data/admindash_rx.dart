import 'dart:developer';
import 'package:ddavila/features/admin_app/dashboard_screen/data/admindash_api.dart';
import 'package:ddavila/features/admin_app/dashboard_screen/model/admin_dash_model.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:dio/dio.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../helpers/all_routes.dart';

final class AdminDashAPIRX extends RxResponseInt<AdminDashModel> {
  final api = GetAdminDashAPI.instance;

  AdminDashAPIRX({required super.empty, required super.dataFetcher});

  Future<AdminDashModel?> getAdminDashRX() async {
    try {
      AdminDashModel data = await api.adminDashAPI();
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
      } else if(error.response?.statusCode == 401) {
        ToastUtil.showShortToast(error.response!.data["status"]);
        NavigationService.navigateToRemoveuntil(Routes.loginScreen);

      }else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }
    
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return null;
  }
}
