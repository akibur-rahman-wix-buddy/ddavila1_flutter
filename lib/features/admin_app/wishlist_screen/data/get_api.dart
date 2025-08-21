import 'package:ddavila/features/admin_app/wishlist_screen/model/wishlist_model.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetWishlistApi {
  static final GetWishlistApi _singleton = GetWishlistApi._internal();
  GetWishlistApi._internal();

  static GetWishlistApi get instance => _singleton;

  Future<WishlistModel> getList() async {
    try {
      Response response = await getHttp(Endpoints.wishList());
      if (response.statusCode == 200) {
        final data =  WishlistModel.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
