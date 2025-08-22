import 'package:ddavila/features/admin_app/buying/model/buying_order_data_model.dart';
import 'package:ddavila/features/admin_app/dashboard_screen/model/admin_dash_model.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetBuyingOrderAPI {
  static final GetBuyingOrderAPI _singleton = GetBuyingOrderAPI._internal();
  GetBuyingOrderAPI._internal();

  static GetBuyingOrderAPI get instance => _singleton;

  Future<BuyingOrderDataModel> getBuyingOrderAPIAPI() async {
    try {
      Response response = await getHttp(Endpoints.buyingOrderBoard());
      if (response.statusCode == 200) {
        final data = BuyingOrderDataModel.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
