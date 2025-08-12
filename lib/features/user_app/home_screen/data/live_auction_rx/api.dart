





import 'dart:developer';

import 'package:ddavila/features/user_app/home_screen/model/home_category_data_model.dart';
import 'package:ddavila/features/user_app/home_screen/model/live_autction_data_model.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';



final class LiveAuctionApi {
  static final LiveAuctionApi _singleton = LiveAuctionApi._internal();
  LiveAuctionApi._internal();

  static LiveAuctionApi get instance => _singleton;

  Future<LiveAuctionApiDataModel> liveAuctionData() async {



    try {
      final response = await getHttp(Endpoints.liveAuctionDataApiLink());
      if (response.statusCode == 200) {
        return LiveAuctionApiDataModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
