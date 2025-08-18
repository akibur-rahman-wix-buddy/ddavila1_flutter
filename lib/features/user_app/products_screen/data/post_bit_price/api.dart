import 'dart:convert';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';



final class PostBitApi {

  static final  PostBitApi _singleton = PostBitApi._internal();

  PostBitApi._internal();

  static  PostBitApi get instance => _singleton;

  Future<Map<String, dynamic>> postBitPriceApi({required dynamic price, required dynamic id}) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "amount": price,
      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.postBitPriceApiLink(id: id), data));

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
