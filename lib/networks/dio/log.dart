// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:uditmediallc_app/constants/app_constants.dart';
// import 'package:uditmediallc_app/helpers/di.dart';
// import 'package:uditmediallc_app/networks/endpoints.dart';
// import 'package:uditmediallc_app/networks/exception_handler/data_source.dart';
//
// import 'dio.dart';
//
// final class Logger extends Interceptor {
//   List<Map<dynamic, dynamic>> failedRequests = [];
//   bool isRefreshing = false;
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     log("= = = Dio Request = = =");
//     log("${options.headers}");
//     log("${options.data}");
//     log("${options.contentType}");
//     log("${options.extra}");
//     log("${options.baseUrl}${options.path}");
//     return super.onRequest(options, handler);
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     log("= = = Dio Success Response = = =");
//     log(json.encode(response.data));
//     log("${response.requestOptions}");
//     log("${response.statusCode}");
//     log("${response.statusMessage}");
//     log("${response.headers}");
//     log("${response.extra}");
//
//     return super.onResponse(response, handler);
//   }
//
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     if (kDebugMode) {
//       log("= = = Dio Error Response = = =");
//       log('Error Response: ${err.response}');
//       log('Error Message: ${err.message}');
//       log('Error Type: ${err.type}');
//       log('Error: ${err.error}');
//       log('Error Req option: ${err.requestOptions}');
//     }
//     if (err.response?.statusCode == 401) {
//       if (!isRefreshing) {
//         debugPrint("ACCESS TOKEN EXPIRED, GETTING NEW TOKEN PAIR");
//         isRefreshing = true;
//         await refreshToken(err, handler);
//       } else {
//         debugPrint("ADDING ERRRORED REQUEST TO FAILED QUEUE");
//         failedRequests.add({'err': err, 'handler': handler});
//       }
//     } else {
//       ErrorHandler.handle(err).failure;
//     }
//     ErrorHandler.handle(err).failure;
//     return super.onError(err, handler);
//   }
//
//   FutureOr refreshToken(
//       DioException err, ErrorInterceptorHandler handler) async {
//     // handle refresh token
//
//     var response = await DioSingleton.instance.dio.post(
//       Endpoints.refreshUrl(),
//     );
//     var parsedResponse = response.data;
//     if (response.statusCode == 401 || response.statusCode == 403) {
//       // handle logout
//       debugPrint("LOGGING OUT: EXPIRED REFRESH TOKEN");
//       return handler.reject(err);
//     }
//     RefreshModel refreshModel = RefreshModel.fromJson(parsedResponse);
//
//     // handle setting tokens in your store for future requests
//     isRefreshing = false;
//     failedRequests.add({'err': err, 'handler': handler});
//     debugPrint("RETRYING ${failedRequests.length} FAILED REQUEST(s)");
//     await appData.write(kKeyAccessToken, refreshModel.accessToken);
//     retryRequests(parsedResponse['access_token']);
//   }
//
//   Future retryRequests(token) async {
//     for (var i = 0; i < failedRequests.length; i++) {
//       debugPrint(
//           'RETRYING[$i] => PATH: ${failedRequests[i]['err'].requestOptions.path}');
//       RequestOptions requestOptions =
//           failedRequests[i]['err'].requestOptions as RequestOptions;
//       requestOptions.headers = {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json'
//       };
//       DioSingleton.instance.update(token);
//       await DioSingleton.instance.dio.fetch(requestOptions).then(
//             failedRequests[i]['handler'].resolve,
//             onError: (error) =>
//                 failedRequests[i]['handler'].reject(error as DioException),
//           );
//     }
//     isRefreshing = false;
//     failedRequests = [];
//   }
// }
//
// // To parse this JSON data, do
// //
// //     final refreshModel = refreshModelFromJson(jsonString);
//
//
// RefreshModel refreshModelFromJson(String str) => RefreshModel.fromJson(json.decode(str));
//
// String refreshModelToJson(RefreshModel data) => json.encode(data.toJson());
//
// class RefreshModel {
//     bool? status;
//     String? accessToken;
//     String? refreshToken;
//     String? type;
//     String? message;
//
//     RefreshModel({
//         this.status,
//         this.accessToken,
//         this.refreshToken,
//         this.type,
//         this.message,
//     });
//
//     factory RefreshModel.fromJson(Map<String, dynamic> json) => RefreshModel(
//         status: json["status"],
//         accessToken: json["access_token"],
//         refreshToken: json["refresh_token"],
//         type: json["type"],
//         message: json["message"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "access_token": accessToken,
//         "refresh_token": refreshToken,
//         "type": type,
//         "message": message,
//     };
// }
//
//
//
// class Data {
//   String? accessToken;
//   String? refreshToken;
//   String? tokenType;
//   String? message;
//   int? expiresIn;
//
//   Data({this.accessToken, this.refreshToken, this.tokenType, this.message, this.expiresIn});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     accessToken = json['access_token'];
//     refreshToken = json['refresh_token'];
//     tokenType = json['type']; // Change from 'token_type' to 'type' based on your JSON
//     message = json['message'];
//     expiresIn = json['expires_in'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['access_token'] = accessToken;
//     data['refresh_token'] = refreshToken;
//     data['type'] = tokenType;
//     data['message'] = message;
//     data['expires_in'] = expiresIn;
//     return data;
//   }
// }
//


import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

import '../exception_handler/data_source.dart';

final class Logger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("= = = Dio Request = = =");
    log("${options.headers}");
    log("${options.data}");
    log("${options.contentType}");
    log("${options.extra}");
    log("${options.baseUrl}${options.path}");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("= = = Dio Success Response = = =");
    log(json.encode(response.data));
    log("${response.requestOptions}");
    log("${response.statusCode}");
    log("${response.statusMessage}");
    log("${response.headers}");
    log("${response.extra}");

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      log("= = = Dio Error Response = = =");
      log('Error Response: ${err.response}');
      log('Error Message: ${err.message}');
      log('Error Type: ${err.type}');
      log('Error: ${err.error}');
      log('Error Req option: ${err.requestOptions}');
    }
    ErrorHandler.handle(err).failure;
    return super.onError(err, handler);
  }
}
