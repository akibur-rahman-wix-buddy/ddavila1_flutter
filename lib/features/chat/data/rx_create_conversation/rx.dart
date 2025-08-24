// import 'dart:developer';
// import 'package:ddavila/constants/app_constants.dart';
// import 'package:ddavila/features/chat/model/conversation_model_data.dart';
// import 'package:ddavila/features/chat/presentation/chat_to_person_screen.dart';
// import 'package:ddavila/helpers/all_routes.dart';
// import 'package:ddavila/helpers/di.dart';
// import 'package:ddavila/helpers/navigation_service.dart';
// import 'package:ddavila/helpers/toast.dart';
// import 'package:ddavila/networks/rx_base.dart';
// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:rxdart/rxdart.dart';
// import 'api.dart';
//
// final class CreateConversationRx extends RxResponseInt<ConversationCreateModelData> {
//   final api = CreateConversationApi.instance;
//
//   CreateConversationRx({required super.empty, required super.dataFetcher});
//
//   ValueStream<ConversationCreateModelData> get getFileData => dataFetcher.stream;
//
//   Future<ConversationCreateModelData> createConversations({required dynamic userId}) async {
//     try {
//       final Map<String, dynamic> response = await api.createConversationApi(userI: userId);
//       final data = ConversationCreateModelData.fromJson(response);
//       dataFetcher.sink.add(data);
//       return data; // Add this line
//     } catch (error) {
//       handleError(error);
//       rethrow; // Re-throw the error for handling in the UI
//     }
//   }
//
//   @override
//   handleSuccessWithReturn(ConversationCreateModelData data) {
//
//     Get.to(
//         ChatToPersonScreen(participantableId:data.data?.user?.id, name:data.data?.user?.name , image: data.data?.user?.avatar, conversationId: data.data?.conversation?.id)
//     );
//     print(">>>>>>>>>>>>> here is the hit");
//
//     dataFetcher.sink.add(data);
//
//     return data;
//   }
//
//   @override
//   handleErrorWithReturn(dynamic error) {
//     handleError(error);
//     return false;
//   }
//
//   void handleError(dynamic error) {
//     String errorMessage = 'An error occurred';
//     if (error is DioException) {
//       if (error.response != null) {
//         if (error.response!.statusCode == 400) {
//           errorMessage = error.response!.data["error"] ?? 'Bad request';
//         }if (error.response!.statusCode == 401) {
//
//           appData.write(kKeyIsLoggedIn, false);
//           NavigationService.navigateTo(Routes.loginScreen);
//         } else {
//           errorMessage = error.response!.data["message"] ?? 'Server error';
//         }
//       } else {
//         errorMessage = error.message ?? 'Network error';
//       }
//     }
//     log(error.toString());
//     ToastUtil.showShortToast(errorMessage);
//     dataFetcher.sink.addError(errorMessage);
//   }
// }


import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/features/chat/model/conversation_model_data.dart';
import 'package:ddavila/features/chat/presentation/chat_to_person_screen.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class CreateConversationRx extends RxResponseInt<ConversationCreateModelData> {
  final api = CreateConversationApi.instance;
  final BehaviorSubject<ConversationCreateModelData> _dataFetcher;

  CreateConversationRx({required ConversationCreateModelData empty})
      : _dataFetcher = BehaviorSubject<ConversationCreateModelData>.seeded(empty),
        super(empty: empty, dataFetcher: BehaviorSubject<ConversationCreateModelData>.seeded(empty));

  ValueStream<ConversationCreateModelData> get getFileData => _dataFetcher.stream;

  Future<ConversationCreateModelData> createConversations({required dynamic userId}) async {
    try {
      // loading.add(true); // Set loading state

      final Map<String, dynamic> response = await api.createConversationApi(userI: userId);
      final data = ConversationCreateModelData.fromJson(response);

      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      handleErrorWithReturn(error);
      rethrow;
    } finally {
      // loading.add(false); // Reset loading state
    }
  }

  @override
  ConversationCreateModelData handleSuccessWithReturn(ConversationCreateModelData data) {
    // Navigate to chat screen
    Get.to(
        ChatToPersonScreen(
            participantableId: data.data?.user?.id,
            name: data.data?.user?.name,
            image: data.data?.user?.avatar,
            conversationId: data.data?.conversation?.id
        )
    );

    print(">>>>>>>>>>>>> here is the hit");
    _dataFetcher.sink.add(data);

    return data;
  }

  @override
  bool handleErrorWithReturn(dynamic error) {
    handleError(error);
    return false;
  }

  void handleError(dynamic error) {
    String errorMessage = 'An error occurred';

    if (error is DioException) {
      if (error.response != null) {
        if (error.response!.statusCode == 400) {
          errorMessage = error.response!.data["error"] ?? 'Bad request';
        } else if (error.response!.statusCode == 401) {
          appData.write(kKeyIsLoggedIn, false);
          NavigationService.navigateTo(Routes.loginScreen);
          errorMessage = 'Unauthorized access';
        } else if (error.response!.statusCode == 500) {
          errorMessage = 'Internal server error';
        } else {
          errorMessage = error.response!.data["message"] ?? 'Server error';
        }
      } else {
        errorMessage = error.message ?? 'Network error';
      }
    } else if (error is FormatException) {
      errorMessage = 'Data format error';
    }

    // log(error.toString());
    ToastUtil.showShortToast(errorMessage);
    _dataFetcher.sink.addError(errorMessage);
  }

  @override
  void dispose() {
    _dataFetcher.close();
    super.dispose();
  }
}