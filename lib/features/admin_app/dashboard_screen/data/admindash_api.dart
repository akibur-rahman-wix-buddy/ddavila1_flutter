import 'package:ddavila/features/admin_app/dashboard_screen/model/admin_dash_model.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetAdminDashAPI {
  static final GetAdminDashAPI _singleton = GetAdminDashAPI._internal();
  GetAdminDashAPI._internal();

  static GetAdminDashAPI get instance => _singleton;

  Future<AdminDashModel> adminDashAPI() async {
    try {
      Response response = await getHttp(Endpoints.adminDashboard());
      if (response.statusCode == 200) {
        final data = AdminDashModel.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
