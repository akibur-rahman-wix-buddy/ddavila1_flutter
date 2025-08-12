
import 'dart:developer';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/features/user_app/home_screen/model/home_category_data_model.dart';
import 'package:ddavila/features/user_app/home_screen/model/live_autction_data_model.dart';
import 'package:ddavila/features/user_app/products_screen/model/live_action_details_model.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';


final class LiveAuctionDetailsDataRx extends RxResponseInt<LiveAuctionDetailsApiDataModel> {
  final api = LiveAuctionDetailsApi.instance;

  LiveAuctionDetailsDataRx({required super.empty, required super.dataFetcher});

  ValueStream get getAvailableItemsStream => dataFetcher.stream;

  Future<LiveAuctionDetailsApiDataModel?> liveAuctionDetailsDataInfo({required dynamic slug}) async {
    try {
      final  data = await api.liveAuctionDetailsData(slug: slug);
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final errorMessage = error.response?.data?["error"] ??
          error.response?.data?["message"] ??
          "An unknown error occurred.";

      // if (statusCode == 401) {
      //
      //   appData.write(kKeyIsLoggedIn, false);
      //   NavigationService.navigateToReplacement(Routes.loginScreen);
      // } else {
      //   ToastUtil.showShortToast(errorMessage);
      // }
    } else {
      ToastUtil.showShortToast("An unexpected error occurred.");
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return null;
  }
}

