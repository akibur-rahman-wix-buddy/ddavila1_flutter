//
// import 'package:rxdart/rxdart.dart';
// import 'package:saint_app/features/chatting/model/personal_chat_screen_data_model.dart';
// import '../../../../networks/rx_base.dart';
// import 'api.dart';
//
// final class GetChatMessageRx extends RxResponseInt<PersonalChatScreenDataModel> {
//   final api = GetChatMessageApi.instance;
//
//   GetChatMessageRx({required super.empty, required super.dataFetcher});
//
//   ValueStream get chatListStream => dataFetcher.stream;
//
//   Future<PersonalChatScreenDataModel> getChatList({required dynamic conversationId}) async {
//     try {
//       final data = await api.getChatListInfo(conversationId: conversationId);
//       return handleSuccessWithReturn(data);
//     } catch (error) {
//       print('Rx Error: $error'); // Debug log
//       return handleErrorWithReturn(error);
//     }
//   }
// }
//


import 'dart:developer';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/features/chat/model/chat_to_person.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';


final class GetChatMessageRx extends RxResponseInt<PersonalChatScreenDataModel> {
  final api = GetChatMessageApi.instance;

  GetChatMessageRx({required super.empty, required super.dataFetcher});

  ValueStream get getAvailableItemsStream => dataFetcher.stream;

  Future<PersonalChatScreenDataModel?> getChatList({required dynamic participantableId}) async {
    try {
      final  data = await api.getChatListInfo(participantableId: participantableId);
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final errorMessage = error.response?.data?["error"] ??
          error.response?.data?["message"] ??
          "An unknown error occurred.";

      if (statusCode == 401) {

        appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateToReplacement(Routes.loginScreen);
      } else {
        ToastUtil.showShortToast(errorMessage);
      }
    } else {
      ToastUtil.showShortToast("An unexpected error occurred.");
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return null;
  }
}

