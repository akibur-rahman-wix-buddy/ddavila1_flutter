import 'dart:convert';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';



final class BitPaymentApi {

  static final  BitPaymentApi _singleton = BitPaymentApi._internal();

  BitPaymentApi._internal();

  static  BitPaymentApi get instance => _singleton;

  Future<Map<String, dynamic>> bitPaymentData({required dynamic bitId}) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "bid_id":bitId ,
        "payment_method": "stripe",
      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.getStripeBitPaymentApiLink(), data));

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
