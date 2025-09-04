import 'dart:developer';
import 'package:ddavila/features/admin_app/auction_screen/data/get_category/get_category_api.dart';
import 'package:ddavila/features/admin_app/auction_screen/model/category_model.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:dio/dio.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';

final class GetCategoryAPIRX extends RxResponseInt<CategoryModel> {
  final api = GetCategoryAPI.instance;

  GetCategoryAPIRX({
    required super.empty,
    required super.dataFetcher,
  });

  Future<CategoryModel?> getCategoryRX() async {
    try {
      CategoryModel data = await api.getCategoryAPI();
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
        NavigationService.navigateTo(Routes.loginScreen);
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
