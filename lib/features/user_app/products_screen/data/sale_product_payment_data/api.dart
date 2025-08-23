import 'dart:convert';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';



final class PostSaleProductPaymentApi {

  static final  PostSaleProductPaymentApi _singleton = PostSaleProductPaymentApi._internal();

  PostSaleProductPaymentApi._internal();

  static  PostSaleProductPaymentApi get instance => _singleton;

  Future<Map<String, dynamic>> saleProductStripePaymentInfo({required dynamic productId}) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "payment_method": "stripe",
        "items": [
          {
            "product_id": productId,
            "quantity": 1
          }
        ]
      }
      ;
      // Make the POST request
      Response response = (await postHttp(Endpoints.saleProductStripePayment(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        return data;

      } else {
        throw DataSource.DEFAULT.getFailure();
      }

    } catch (error) {
      print("Error during signup: $error");
      rethrow;
    }
  }
}
