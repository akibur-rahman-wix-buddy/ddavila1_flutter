import 'dart:io';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../networks/exception_handler/data_source.dart';

final class UpdatePersonalProfile {
  static final UpdatePersonalProfile _singleton = UpdatePersonalProfile._internal();
  UpdatePersonalProfile._internal();
  static UpdatePersonalProfile get instance => _singleton;

  Future<Map<String, dynamic>> updateProfileApi({
    String? name,
    XFile? avatar,
    String? address,
    String? city,
    String? state,
    String? zipCode,
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
        ToastUtil.showShortToast('Profile updated successfully.');
        return responseData;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errorData = e.response?.data;
        final errorMessage = errorData?['message'] ?? 'Failed to update profile';
        ToastUtil.showShortToast(errorMessage);
        throw Exception(errorMessage);
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
}