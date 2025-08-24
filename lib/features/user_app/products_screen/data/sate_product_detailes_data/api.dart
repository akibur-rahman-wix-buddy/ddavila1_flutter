import 'dart:developer';
import 'package:ddavila/features/user_app/home_screen/model/category_wise_data_model.dart';
import 'package:ddavila/features/user_app/products_screen/model/sale_product_details_data_model.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';



final class ProductDetailsApi {
  static final ProductDetailsApi _singleton = ProductDetailsApi._internal();
  ProductDetailsApi._internal();

  static ProductDetailsApi get instance => _singleton;

  Future<ProductDetailsDataModel> productDetailsApi({required dynamic slug }) async {



    try {
      final response = await getHttp(Endpoints.productDetails(slug: slug ));
      if (response.statusCode == 200) {
        return ProductDetailsDataModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
