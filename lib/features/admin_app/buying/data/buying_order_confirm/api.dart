import 'dart:convert';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';



final class BuyingOrderConfirmApi {

  static final  BuyingOrderConfirmApi _singleton = BuyingOrderConfirmApi._internal();

  BuyingOrderConfirmApi._internal();

  static  BuyingOrderConfirmApi get instance => _singleton;

  Future<Map<String, dynamic>> buyingOrderConfirmInfo({
    required dynamic productId, }) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.busyingOrderConfirmApiLink(productId: productId), data));

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
