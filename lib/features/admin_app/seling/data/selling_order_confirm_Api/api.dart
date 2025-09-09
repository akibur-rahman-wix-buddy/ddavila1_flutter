import 'dart:convert';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';



final class SellingOrderConfirmApi {

  static final  SellingOrderConfirmApi _singleton = SellingOrderConfirmApi._internal();

  SellingOrderConfirmApi._internal();

  static  SellingOrderConfirmApi get instance => _singleton;

  Future<Map<String, dynamic>> sellingOrderConfirmInfo({
    required dynamic companyName,
    required dynamic trackingNumber ,
    required dynamic productId, }) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "company_name": companyName,
        "tracking_number": trackingNumber,
      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.sellingOrderConfirmApiLink(productId: productId), data));

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
