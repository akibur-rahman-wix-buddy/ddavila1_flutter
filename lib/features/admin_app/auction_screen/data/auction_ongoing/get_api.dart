import 'package:ddavila/features/admin_app/auction_screen/model/auction_model.dart';
import 'package:ddavila/features/admin_app/auction_screen/model/auction_running_model.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class AuctionOngoingApi {
  static final AuctionOngoingApi _singleton = AuctionOngoingApi._internal();
  AuctionOngoingApi._internal();

  static AuctionOngoingApi get instance => _singleton;

  Future<AuctionRunningModel> getOngoing(dynamic pageNum) async {
    try {
      Response response = await getHttp(Endpoints.auctionRunning(pageNum));
      if (response.statusCode == 200) {
        final data =  AuctionRunningModel.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
