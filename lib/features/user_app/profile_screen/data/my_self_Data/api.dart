





import 'dart:developer';

import 'package:ddavila/features/user_app/home_screen/model/home_category_data_model.dart';
import 'package:ddavila/features/user_app/profile_screen/model/my_self_model_data.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';



final class MySelfApi {
  static final MySelfApi _singleton = MySelfApi._internal();
  MySelfApi._internal();

  static MySelfApi get instance => _singleton;

  Future<MySelfModelData> mySelfInfo() async {



    try {
      final response = await getHttp(Endpoints.mySelfApiLink());
      if (response.statusCode == 200) {
        return MySelfModelData.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
