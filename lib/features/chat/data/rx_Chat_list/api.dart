

import 'dart:developer';

import 'package:ddavila/features/chat/model/chat_list_data_model.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';



final class GetAllChatLIstApi {
  static final GetAllChatLIstApi _singleton = GetAllChatLIstApi._internal();
  GetAllChatLIstApi._internal();

  static GetAllChatLIstApi get instance => _singleton;




  Future<ChatListModelData> getChatListApi({required dynamic chatType}) async {
    try {



      final response = await getHttp(Endpoints.chatterListUrl());
      if (response.statusCode == 200) {
        return ChatListModelData.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }



    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }





}
