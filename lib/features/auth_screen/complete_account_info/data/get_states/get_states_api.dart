
import 'package:ddavila/features/auth_screen/complete_account_info/model/state_model.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetStateAPI {
  static final GetStateAPI _singleton = GetStateAPI._internal();
  GetStateAPI._internal();

  static GetStateAPI get instance => _singleton;

  Future<StatesModel> getStateApi() async {
    try {
      Response response = await getHttp(Endpoints.getStates());
      if (response.statusCode == 200) {
        final data = StatesModel.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
