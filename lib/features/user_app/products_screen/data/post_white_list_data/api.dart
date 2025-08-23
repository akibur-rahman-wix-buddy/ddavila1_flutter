// import 'dart:convert';
// import 'package:ddavila/networks/dio/dio.dart';
// import 'package:ddavila/networks/endpoints.dart';
// import 'package:ddavila/networks/exception_handler/data_source.dart';
// import 'package:dio/dio.dart';
//
//
//
// final class PostWhiteListApi {
//
//   static final  PostWhiteListApi _singleton = PostWhiteListApi._internal();
//
//   PostWhiteListApi._internal();
//
//   static  PostWhiteListApi get instance => _singleton;
//
//   Future<Map<String, dynamic>> postWhiteListApi({required dynamic productId,}) async {
//     try {
//       // Create the request data map
//       Map<String, dynamic> data = {
//         "product_id": productId,
//       };
//       // Make the POST request
//       Response response = (await postHttp(Endpoints.whiteListApiLink(), data));
//
//       if (response.statusCode == 200) {
//         final data = json.decode(json.encode(response.data));
//         return data;
//
//       } else {
//         throw DataSource.DEFAULT.getFailure();
//       }
//
//     } catch (error) {
//       print("Error during signup: $error");
//       rethrow;
//     }
//   }
// }


import 'dart:convert';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class PostWhiteListApi {
  static final PostWhiteListApi _singleton = PostWhiteListApi._internal();

  PostWhiteListApi._internal();

  static PostWhiteListApi get instance => _singleton;

  Future<Map<String, dynamic>> postWhiteListApi({required dynamic productId}) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "product_id": productId,
      };

      // Make the POST request
      Response response = (await postHttp(Endpoints.whiteListApiLink(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } on DioException catch (error) {
      print("Dio error during whitelist: $error");
      rethrow;
    } catch (error) {
      print("Error during whitelist: $error");
      rethrow;
    }
  }
}