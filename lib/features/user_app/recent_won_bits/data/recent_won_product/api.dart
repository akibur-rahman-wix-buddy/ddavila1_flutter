import 'dart:developer';

import 'package:ddavila/features/user_app/recent_won_bits/model/recent_won_data_model.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';

final class GetRecentWonProductApi {
  static final GetRecentWonProductApi _singleton = GetRecentWonProductApi._internal();
  GetRecentWonProductApi._internal();

  static GetRecentWonProductApi get instance => _singleton;

  Future<RecentWonDataModel> getRecentWonApi({dynamic pageNumber}) async {



    try {
      final response = await getHttp(Endpoints.recentWonProductApi(pageNumber: pageNumber));
      if (response.statusCode == 200) {
        return RecentWonDataModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
