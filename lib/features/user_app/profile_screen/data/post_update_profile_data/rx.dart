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
    String? name,
    XFile? avatar,
    String? address,
    String? city,
    String? state,
    String? zipCode,
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
    }  catch (error, stackTrace) {
      log("Error in updateProfileApiInformation: $error", stackTrace: stackTrace);
      ToastUtil.showShortToast("An unexpected error occurred");
      _dataFetcher.addError(error);
      return false;
    }
  }

  void _handleDioError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final errorData = e.response!.data["data"];
      final errorMessage = errorData['message'] ?? 'Failed to update profile';

      ToastUtil.showShortToast(errorMessage);
      _dataFetcher.addError(Exception(errorMessage));
    } else {
      ToastUtil.showShortToast('Network error occurred');
      _dataFetcher.addError(Exception('Network error: ${e.message}'));
    }
  }

  void dispose() {
    _dataFetcher.close();
  }
}


