import 'dart:developer';

import 'package:ddavila/features/user_app/shop/model/shop_all_products.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';

final class GetAllProductsApi {
  static final GetAllProductsApi _singleton = GetAllProductsApi._internal();
  GetAllProductsApi._internal();

  static GetAllProductsApi get instance => _singleton;

  Future<ShopAllProductsDataModel> getShopApi({dynamic pageNumber}) async {



    try {
      final response = await getHttp(Endpoints.shopApiLink(pageNumber: pageNumber));
      if (response.statusCode == 200) {
        return ShopAllProductsDataModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
