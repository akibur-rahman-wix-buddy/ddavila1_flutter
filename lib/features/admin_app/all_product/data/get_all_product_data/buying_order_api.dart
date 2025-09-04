


import 'package:dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import 'package:ddavila/features/admin_app/all_product/model/all_product_data_model.dart';

final class GetAllProductAPI {
  static final GetAllProductAPI _singleton = GetAllProductAPI._internal();
  GetAllProductAPI._internal();

  static GetAllProductAPI get instance => _singleton;

  Future<AllProductDataModel> getAllProductApi() async {
    try {
      Response response = await getHttp(Endpoints.getAllProductDataBoard());
      if (response.statusCode == 200) {
        final data = AllProductDataModel.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
