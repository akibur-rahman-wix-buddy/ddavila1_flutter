// // import 'dart:developer';
// // import 'package:ddavila/helpers/toast.dart';
// // import 'package:dio/dio.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:rxdart/rxdart.dart';
// // import 'api.dart';
// //
// // final class UpdateProfileApiRx {
// //   final _api = UpdatePersonalProfile.instance;
// //   final _dataFetcher = BehaviorSubject<Map<String, dynamic>>();
// //
// //   ValueStream<Map<String, dynamic>> get getFileData => _dataFetcher.stream;
// //
// //   Future<bool> updateProfileApiInformation({
// //     String? name,
// //     XFile? avatar,
// //     String? address,
// //     String? city,
// //     String? state,
// //     String? zipCode,
// //   }) async {
// //     try {
// //       final data = await _api.updateProfileApi(
// //         name: name,
// //         avatar: avatar,
// // address: address,
// //         city: city,
// //         state: state,
// //         zipCode: zipCode
// //       );
// //
// //       _dataFetcher.add(data);
// //       return true;
// //     }  catch (error, stackTrace) {
// //       log("Error in updateProfileApiInformation: $error", stackTrace: stackTrace);
// //       ToastUtil.showShortToast("An unexpected error occurred");
// //       _dataFetcher.addError(error);
// //       return false;
// //     }
// //   }
// //
// //   void _handleDioError(DioException e) {
// //     if (e.response != null) {
// //       final statusCode = e.response!.statusCode;
// //       final errorData = e.response!.data["data"];
// //       final errorMessage = errorData['message'] ?? 'Failed to update profile';
// //
// //       ToastUtil.showShortToast(errorMessage);
// //       _dataFetcher.addError(Exception(errorMessage));
// //     } else {
// //       ToastUtil.showShortToast('Network error occurred');
// //       _dataFetcher.addError(Exception('Network error: ${e.message}'));
// //     }
// //   }
// //
// //   void dispose() {
// //     _dataFetcher.close();
// //   }
// // }
// //
// //
//
//
//
//
//
// import 'dart:developer';
// import 'package:ddavila/helpers/toast.dart';
// import 'package:dio/dio.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:rxdart/rxdart.dart';
// import 'api.dart';
//
// final class UpdateProfileApiRx {
//   final _api = UpdatePersonalProfile.instance;
//   final _dataFetcher = BehaviorSubject<Map<String, dynamic>>();
//
//   ValueStream<Map<String, dynamic>> get getFileData => _dataFetcher.stream;
//
//   Future<bool> updateProfileApiInformation({
//     dynamic name,
//     XFile? avatar,
//     dynamic address,
//     dynamic city,
//     dynamic state,
//     dynamic zipCode,
//   }) async {
//     try {
//       final data = await _api.updateProfileApi(
//           name: name,
//           avatar: avatar,
//           address: address,
//           city: city,
//           state: state,
//           zipCode: zipCode
//       );
//
//       _dataFetcher.add(data);
//       return true;
//     } on DioException catch (e) {
//       // Handle Dio errors specifically
//       _handleDioError(e);
//       return false;
//     } catch (error, stackTrace) {
//       log("Error in updateProfileApiInformation: $error", stackTrace: stackTrace);
//       ToastUtil.showShortToast("An unexpected error occurred");
//       _dataFetcher.addError(error);
//       return false;
//     }
//   }
//
//   void _handleDioError(DioException e) {
//     if (e.response != null) {
//       final responseData = e.response!.data;
//       final statusCode = e.response!.statusCode;
//
//       // Extract error message based on the response structure
//       String errorMessage;
//
//       if (responseData is Map<String, dynamic>) {
//         // Handle the specific response structure: {"success":false,"message":{"name":["The name has already been taken."]},"data":[],"code":500}
//         if (responseData['message'] is Map<String, dynamic>) {
//           // Extract the first error message from the nested map
//           final messageMap = responseData['message'] as Map<String, dynamic>;
//           if (messageMap.isNotEmpty) {
//             final firstErrorKey = messageMap.keys.first;
//             final firstErrorValue = messageMap[firstErrorKey];
//
//             if (firstErrorValue is List && firstErrorValue.isNotEmpty) {
//               errorMessage = firstErrorValue.first.toString();
//             } else {
//               errorMessage = firstErrorValue.toString();
//             }
//           } else {
//             errorMessage = 'Failed to update profile';
//           }
//         } else if (responseData['message'] is String) {
//           errorMessage = responseData['message'] as String;
//         } else {
//           errorMessage = 'Failed to update profile';
//         }
//       } else {
//         errorMessage = 'Failed to update profile';
//       }
//
//       ToastUtil.showShortToast(errorMessage);
//       _dataFetcher.addError(Exception(errorMessage));
//     } else {
//       ToastUtil.showShortToast('Network error occurred');
//       _dataFetcher.addError(Exception('Network error: ${e.message}'));
//     }
//   }
//
//   void dispose() {
//     _dataFetcher.close();
//   }
// }


import 'dart:developer';

import 'package:ddavila/helpers/toast.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class UpdateProfileApiRx {
  final _api = UpdatePersonalProfile.instance;
  final _dataFetcher = BehaviorSubject<Map<String, dynamic>>();

  ValueStream<Map<String, dynamic>> get getFileData => _dataFetcher.stream;

  Future<bool> updateProfileApiInformation({
    dynamic name,
    XFile? avatar,
    dynamic address,
    dynamic city,
    dynamic state,
    dynamic zipCode,
  }) async {
    try {
      final data = await _api.updateProfileApi(
          name: name,
          avatar: avatar,
          address: address,
          city: city,
          state: state,
          zipCode: zipCode
      );

      _dataFetcher.add(data);
      return true;
    } on DioException catch (e) {
      // Handle Dio errors specifically
      _handleDioError(e);
      return false;
    } catch (error, stackTrace) {

      // Check if it's already an Exception with a message
      if (error is Exception) {
        ToastUtil.showShortToast(error.toString());
      } else {
        ToastUtil.showShortToast("An unexpected error occurred");
      }

      _dataFetcher.addError(error);
      return false;
    }
  }

  void _handleDioError(DioException e) {
    if (e.response != null) {
      final responseData = e.response!.data;
      final errorMessage = _extractErrorMessage(responseData);

      ToastUtil.showShortToast(errorMessage);
      _dataFetcher.addError(Exception(errorMessage));
    } else {
      ToastUtil.showShortToast('Network error occurred');
      _dataFetcher.addError(Exception('Network error: ${e.message}'));
    }
  }

  String _extractErrorMessage(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      // Handle different response structures
      if (responseData['message'] is Map<String, dynamic>) {
        // Structure: {"message":{"name":["The name has already been taken."]}}
        final messageMap = responseData['message'] as Map<String, dynamic>;
        if (messageMap.isNotEmpty) {
          final firstErrorKey = messageMap.keys.first;
          final firstErrorValue = messageMap[firstErrorKey];

          if (firstErrorValue is List && firstErrorValue.isNotEmpty) {
            return firstErrorValue.first.toString();
          } else if (firstErrorValue is String) {
            return firstErrorValue;
          } else {
            return firstErrorValue.toString();
          }
        }
      } else if (responseData['message'] is String) {
        return responseData['message'] as String;
      } else if (responseData['error'] is String) {
        return responseData['error'] as String;
      }
    }
    return "";
  }

  void dispose() {
    _dataFetcher.close();
  }
}