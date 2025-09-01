import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class CompleteProfileApi {
  static final CompleteProfileApi _singleton = CompleteProfileApi._internal();

  CompleteProfileApi._internal();

  static CompleteProfileApi get instance => _singleton;

  Future<Map<String, dynamic>> completeApi({
    required dynamic terms,
    required dynamic phone,
    required dynamic address,
    required dynamic zip_code,
    required dynamic state,
    required dynamic city,
    required dynamic country,
  }) async {
    try {
      FormData data = FormData.fromMap({
        "terms": terms,
        "phone": phone,
        "address": address,
        "zip_code": zip_code,
        "state": state,
        "city": city,
        "country": country,
      });

      Response response = await postHttp(Endpoints.completeProfile(), data);





      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error in auctionApi: $error");
      rethrow;
    }
  }
}