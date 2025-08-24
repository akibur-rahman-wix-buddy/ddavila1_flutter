
import 'package:ddavila/features/admin_app/auction_screen/model/property_model.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetPropertyAPI {
  static final GetPropertyAPI _singleton = GetPropertyAPI._internal();
  GetPropertyAPI._internal();

  static GetPropertyAPI get instance => _singleton;

  Future<PropertyModel> getPropertyAPI() async {
    try {
      Response response = await getHttp(Endpoints.propertyAPI());
      if (response.statusCode == 200) {
        final data = PropertyModel.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
