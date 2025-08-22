import 'package:ddavila/features/admin_app/buying/model/buying_order_data_model.dart';
import 'package:ddavila/features/admin_app/seling/model/selling_order_data_model.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetSellingOrderAPI {
  static final GetSellingOrderAPI _singleton = GetSellingOrderAPI._internal();
  GetSellingOrderAPI._internal();

  static GetSellingOrderAPI get instance => _singleton;

  Future<SellingOrderDataModel> getSellingOrderAPIAPI() async {
    try {
      Response response = await getHttp(Endpoints.sellingOrderBoard());
      if (response.statusCode == 200) {
        final data = SellingOrderDataModel.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
