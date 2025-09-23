import 'dart:developer';
import 'package:ddavila/features/user_app/home_screen/model/category_wise_data_model.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';



final class PopularCategoryWiseProductApi {
  static final PopularCategoryWiseProductApi _singleton = PopularCategoryWiseProductApi._internal();
  PopularCategoryWiseProductApi._internal();

  static PopularCategoryWiseProductApi get instance => _singleton;

  Future<CategoryWiseProductDataModel> popularCategoryWiseProductApi({required dynamic id }) async {



    try {
      final response = await getHttp(Endpoints.categoryWiseProductDataLink(id: id));
      if (response.statusCode == 200) {
        return CategoryWiseProductDataModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
