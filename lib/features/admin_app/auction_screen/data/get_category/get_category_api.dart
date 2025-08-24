import 'package:ddavila/features/admin_app/auction_screen/model/category_model.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetCategoryAPI {
  static final GetCategoryAPI _singleton = GetCategoryAPI._internal();
  GetCategoryAPI._internal();

  static GetCategoryAPI get instance => _singleton;

  Future<CategoryModel> getCategoryAPI() async {
    try {
      Response response = await getHttp(Endpoints.categoryAPI());
      if (response.statusCode == 200) {
        final data =  CategoryModel.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
