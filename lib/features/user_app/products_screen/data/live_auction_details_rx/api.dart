import 'dart:developer';
import 'package:ddavila/features/user_app/products_screen/model/live_action_details_model.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';



final class LiveAuctionDetailsApi {
  static final LiveAuctionDetailsApi _singleton = LiveAuctionDetailsApi._internal();
  LiveAuctionDetailsApi._internal();

  static LiveAuctionDetailsApi get instance => _singleton;

  Future<LiveAuctionDetailsApiDataModel> liveAuctionDetailsData({required dynamic slug}) async {



    try {
      final response = await getHttp(Endpoints.liveAuctionDetailsDataApiLink(slug:slug ));
      if (response.statusCode == 200) {
        return LiveAuctionDetailsApiDataModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
