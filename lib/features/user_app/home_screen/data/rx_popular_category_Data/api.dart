import 'dart:developer';
import 'package:ddavila/features/user_app/home_screen/model/popular_category_data_model.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';



final class GetPopularCategoryApi {
  static final GetPopularCategoryApi _singleton = GetPopularCategoryApi._internal();
  GetPopularCategoryApi._internal();

  static GetPopularCategoryApi get instance => _singleton;

  Future<PopularCategoryDataModel> getPopularCategoryInfo() async {



    try {
      final response = await getHttp(Endpoints.popularCategoryApiLink());
      if (response.statusCode == 200) {
        return PopularCategoryDataModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
