import 'dart:developer';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:dio/dio.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';
import '../../model/auction_running_model.dart';
import 'get_api.dart';

final class AuctionOngoingApiRx extends RxResponseInt<AuctionRunningModel> {
  final api = AuctionOngoingApi.instance;

  AuctionOngoingApiRx({required super.empty, required super.dataFetcher});


  Future<AuctionRunningModel?> getAuctionOngoing(dynamic pageNum) async {
    try {
      AuctionRunningModel data = await api.getOngoing(pageNum);
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
