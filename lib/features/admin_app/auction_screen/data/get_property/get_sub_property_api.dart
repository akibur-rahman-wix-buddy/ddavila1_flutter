import 'package:ddavila/features/admin_app/auction_screen/model/sub_property_model.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetSubPropertyAPI {
  static final GetSubPropertyAPI _singleton = GetSubPropertyAPI._internal();
  GetSubPropertyAPI._internal();

  static GetSubPropertyAPI get instance => _singleton;

  Future<SubPropertyModel> getSubProperty(dynamic title) async {
    try {
      Response response = await getHttp(Endpoints.subPropertyAPI(title));
      if (response.statusCode == 200) {
        final data = SubPropertyModel.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
