





import 'dart:developer';

import 'package:ddavila/features/user_app/home_screen/model/home_category_data_model.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';



final class GetHomeCategoryApi {
  static final GetHomeCategoryApi _singleton = GetHomeCategoryApi._internal();
  GetHomeCategoryApi._internal();

  static GetHomeCategoryApi get instance => _singleton;

  Future<HomeCategoryApiDataModel> getHomeCategoryInfo() async {



    try {
      final response = await getHttp(Endpoints.homeCategoryApiLink());
      if (response.statusCode == 200) {
        return HomeCategoryApiDataModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
