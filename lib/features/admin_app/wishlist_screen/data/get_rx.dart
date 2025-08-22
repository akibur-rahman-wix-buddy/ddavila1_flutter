import 'dart:developer';
import 'package:ddavila/features/admin_app/wishlist_screen/model/wishlist_model.dart';
import 'package:dio/dio.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';
import 'get_api.dart';

final class GetWishlistApiRx extends RxResponseInt<WishlistModel> {
  final api = GetWishlistApi.instance;

  GetWishlistApiRx({required super.empty, required super.dataFetcher});


  Future<WishlistModel?> getWishList() async {
    try {
      WishlistModel data = await api.getList();
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
      }
      else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return null;
  }
}
