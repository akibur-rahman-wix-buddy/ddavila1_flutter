// // import 'dart:convert';
// // import 'package:ddavila/networks/dio/dio.dart';
// // import 'package:ddavila/networks/endpoints.dart';
// // import 'package:ddavila/networks/exception_handler/data_source.dart';
// // import 'package:dio/dio.dart';
// //
// // class AddMessageApi {
// //   static final AddMessageApi _singleton = AddMessageApi._internal();
// //   AddMessageApi._internal();
// //
// //   static AddMessageApi get instance => _singleton;
// //
// //   Future<Map> addChat({
// //     required String message,
// //     dynamic rideId,
// //     XFile avatar
// //   }) async {
// //     Map<String, dynamic> data = {"to_user_id": rideId, "message": message};
// //     try {
// //       Response response = await postHttp(Endpoints.postSentMessage(), data);
// //
// //       if (response.statusCode == 200) {
// //         final data = json.decode(json.encode(response.data));
// //         return data;
// //       } else {
// //         // Handle non-200 status code errors
// //         throw DataSource.DEFAULT.getFailure();
// //       }
// //     } catch (error) {
// //       // Handle generic errors
// //       throw ErrorHandler.handle(error).failure.responseMessage;
// //     }
// //   }
// // }
//
//
//
//
//
// import 'package:ddavila/helpers/toast.dart';
// import 'package:ddavila/networks/dio/dio.dart';
// import 'package:ddavila/networks/endpoints.dart';
// import 'package:dio/dio.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../../networks/exception_handler/data_source.dart';
//
// final class AddMessageApi {
//   static final AddMessageApi _singleton = AddMessageApi._internal();
//
//   AddMessageApi._internal();
//
//   static AddMessageApi get instance => _singleton;
//
//   Future<Map<String, dynamic>> addChat({
//     required String message,
//     dynamic toUserId,
//     XFile? avatar,
//
//   }) async {
//     try {
//       // Prepare FormData
//       final FormData data = FormData.fromMap({
//         if (message != null) "message": message,
//         if (toUserId != null) "to_user_id": toUserId,
//
//       });
//
//       // Add avatar if provided
//       if (avatar != null) {
//         final MultipartFile avatarFile = await MultipartFile.fromFile(avatar.path);
//         data.files.add(MapEntry("files[]", avatarFile));
//       }
//
//       print("Request Data: ${data.fields}");
//
//       // Make API call
//       final Response response = await postHttp(Endpoints.postSentMessage(), data);
//
//       if (response.statusCode == 200) {
//         final responseData = response.data;
//         ToastUtil.showShortToast('Profile updated successfully.');
//         return responseData;
//       } else {
//         throw DataSource.DEFAULT.getFailure();
//       }
//     } catch (error) {
//       print("Error in createNetworkData: $error");
//       ToastUtil.showShortToast("Failed to update profile. Please try again.");
//       rethrow;
//     }
//   }
// }








import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class AddMessageApi {
  static final AddMessageApi _singleton = AddMessageApi._internal();

  AddMessageApi._internal();

  static AddMessageApi get instance => _singleton;

  Future<Map<String, dynamic>> addChat({
    required String message,
    dynamic toUserId,
    List<XFile>? avatars, // Changed from XFile? to List<XFile>?
  }) async {
    try {
      // Prepare FormData
      final FormData data = FormData.fromMap({
        if (message != null) "message": message,
        if (toUserId != null) "to_user_id": toUserId,
      });

      // Add avatars if provided
      if (avatars != null && avatars.isNotEmpty) {
        for (var avatar in avatars) {
          final MultipartFile avatarFile = await MultipartFile.fromFile(avatar.path);
          data.files.add(MapEntry("files[]", avatarFile));
        }
      }

      print("Request Data: ${data.fields}");

      // Make API call
      final Response response = await postHttp(Endpoints.postSentMessage(), data);

      if (response.statusCode == 200) {
        final responseData = response.data;
        ToastUtil.showShortToast('Message sent successfully.');
        return responseData;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error in createNetworkData: $error");
      ToastUtil.showShortToast("Failed to send message. Please try again.");
      rethrow;
    }
  }
}