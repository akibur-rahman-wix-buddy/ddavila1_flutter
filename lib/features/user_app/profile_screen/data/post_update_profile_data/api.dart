import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

final class UpdatePersonalProfile {
  static final UpdatePersonalProfile _singleton = UpdatePersonalProfile._internal();
  UpdatePersonalProfile._internal();
  static UpdatePersonalProfile get instance => _singleton;

  Future<Map<String, dynamic>> updateProfileApi({
    dynamic name,
    XFile? avatar,
    dynamic address,
    dynamic city,
    dynamic state,
    dynamic zipCode,
  }) async {
    try {
      // Create the FormData with only non-null values
      final data = FormData.fromMap({
        if (name != null && name.isNotEmpty) 'name': name,
        if (address != null && address.isNotEmpty) 'address': address,
        if (city != null && city.isNotEmpty) 'city': city,
        if (state != null && state.isNotEmpty) 'state': state,
        if (zipCode != null && zipCode.isNotEmpty) 'zip_code': zipCode,
        if (avatar != null) 'avatar': await MultipartFile.fromFile(avatar.path),
      });

      // Make the API call
      final response = await postHttp(Endpoints.updateProfileUrl(), data);

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['success'] == true) {
          ToastUtil.showShortToast('Profile updated successfully.');
          return responseData;
        } else {
          // Handle server-side validation errors (success: false but status 200)
          final errorMessage = _extractErrorMessage(responseData);
          ToastUtil.showShortToast(errorMessage);
          throw Exception(errorMessage);
        }
      } else {
        // Handle non-200 status codes
        final errorMessage = _extractErrorMessage(response.data);
        ToastUtil.showShortToast(errorMessage);
        throw Exception(errorMessage);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errorMessage = _extractErrorMessage(e.response!.data);
        ToastUtil.showShortToast(errorMessage);
        throw Exception();
      } else {
        ToastUtil.showShortToast('Network error occurred');
        throw Exception('Network error: ${e.message}');
      }
    } catch (error) {
      print("Unexpected error: $error");
      ToastUtil.showShortToast("An unexpected error occurred.");
      rethrow;
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

    return 'Failed to update profile';
  }
}