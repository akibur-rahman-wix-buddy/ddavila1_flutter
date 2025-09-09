import 'dart:convert';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';



final class StripeCardAddApi {

  static final  StripeCardAddApi _singleton = StripeCardAddApi._internal();

  StripeCardAddApi._internal();

  static  StripeCardAddApi get instance => _singleton;

  Future<Map<String, dynamic>> stripeCardAddInfo({required dynamic paymentMethodId}) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "payment_method_id": paymentMethodId,
      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.stripeCardAddApiLink(), data));

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
