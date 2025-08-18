





import 'dart:developer';

import 'package:ddavila/features/user_app/filter_screen/model/cetagory_wise_sub_category_model_data.dart';
import 'package:ddavila/features/user_app/home_screen/model/home_category_data_model.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';



final class FilterCategoryApi {
  static final FilterCategoryApi _singleton = FilterCategoryApi._internal();
  FilterCategoryApi._internal();

  static FilterCategoryApi get instance => _singleton;

  Future<ProductFIlterModelData> filterCategoryInfo() async {



    try {
      final response = await getHttp(Endpoints.getFilterApiLink());
      if (response.statusCode == 200) {
        return ProductFIlterModelData.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
