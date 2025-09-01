import 'dart:developer';
import 'package:ddavila/features/user_app/home_screen/model/category_wise_data_model.dart';
import 'package:ddavila/features/user_app/products_screen/model/state_data_model.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';



final class GetStateApi {
  static final GetStateApi _singleton = GetStateApi._internal();
  GetStateApi._internal();

  static GetStateApi get instance => _singleton;

  Future<StateDataModel> getStateApi() async {



    try {
      final response = await getHttp(Endpoints.getStateApiLink());
      if (response.statusCode == 200) {
        return StateDataModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
