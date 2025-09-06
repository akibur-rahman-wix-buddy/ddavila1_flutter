//
// import 'package:image_picker/image_picker.dart';
// import 'package:rxdart/rxdart.dart';
//
// import '../../../../networks/rx_base.dart';
// import 'api.dart';
//
//
// final class SendMessageRx extends RxResponseInt<Map> {
//   final api = AddMessageApi.instance;
//
//   SendMessageRx({required super.empty, required super.dataFetcher});
//
//   ValueStream get chatListStream => dataFetcher.stream;
//
//   Future<Map?> addChat({required String message,     dynamic toUserId,   XFile? avatar,}) async {
//     try {
//       final data = await api.addChat(
//         message: message,
//         avatar: avatar,
//         toUserId: toUserId
//       );
//       handleSuccessWithReturn(data);
//       return data;
//     } catch (error) {
//       handleErrorWithReturn(error);
//       return null;
//     }
//   }
// }



import 'dart:developer';

import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../constants/app_constants.dart' show kKeyIsLoggedIn;
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class SendMessageRx extends RxResponseInt<Map> {
  final api = AddMessageApi.instance;

  SendMessageRx({required super.empty, required super.dataFetcher});

  ValueStream get chatListStream => dataFetcher.stream;

  Future<Map?> addChat({
     dynamic message,
    dynamic toUserId,
    List<XFile>? avatars, // Changed from XFile? to List<XFile>?
  }) async {
    try {
      final data = await api.addChat(
        message: message,
        avatars: avatars, // Updated parameter name
        toUserId: toUserId,
      );
      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      handleErrorWithReturn(error);
      return null;
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