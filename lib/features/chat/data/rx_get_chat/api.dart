import 'dart:developer';

import 'package:ddavila/features/chat/model/chat_to_person.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';



final class GetChatMessageApi {
  static final GetChatMessageApi _singleton = GetChatMessageApi._internal();
  GetChatMessageApi._internal();

  static GetChatMessageApi get instance => _singleton;

  Future<PersonalChatScreenDataModel> getChatListInfo({required dynamic participantableId}) async {



    log(">>>>>>>>>>>>>>>>>>>> converstional id is  $participantableId");


    try {
      final response = await getHttp(Endpoints.getChatList(participantableId: participantableId));
      if (response.statusCode == 200) {
        return PersonalChatScreenDataModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
