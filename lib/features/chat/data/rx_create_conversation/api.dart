import 'dart:convert';
import 'dart:developer';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class CreateConversationApi {
  static final CreateConversationApi _singleton =
      CreateConversationApi._internal();

  CreateConversationApi._internal();

  static CreateConversationApi get instance => _singleton;

  Future<Map<String, dynamic>> createConversationApi(
      {required dynamic userI,

      }) async {
    try {
      Map<String, dynamic> data = {
        "user_id": userI,

      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.createConversation(), data));

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
