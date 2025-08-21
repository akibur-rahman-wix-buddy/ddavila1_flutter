import 'package:ddavila/features/admin_app/auction_screen/model/auction_model.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class AuctionCompleteApi {
  static final AuctionCompleteApi _singleton = AuctionCompleteApi._internal();
  AuctionCompleteApi._internal();

  static AuctionCompleteApi get instance => _singleton;

  Future<AuctionModel> getComplete(dynamic pageNum) async {
    try {
      Response response = await getHttp(Endpoints.auctionComplete(pageNum));
      if (response.statusCode == 200) {
        final data =  AuctionModel.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
