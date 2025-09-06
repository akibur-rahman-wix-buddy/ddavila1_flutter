import 'package:ddavila/features/admin_app/bit_history/model/bit_history_data_model.dart';
import 'package:ddavila/features/admin_app/buying/model/buying_order_data_model.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetBidHistoryAPI {
  static final GetBidHistoryAPI _singleton = GetBidHistoryAPI._internal();
  GetBidHistoryAPI._internal();

  static GetBidHistoryAPI get instance => _singleton;

  Future<BidHistoryDataModel> getBidHistoryAPI() async {
    try {
      Response response = await getHttp(Endpoints.bidHistoryApiLink());
      if (response.statusCode == 200) {
        final data = BidHistoryDataModel.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
