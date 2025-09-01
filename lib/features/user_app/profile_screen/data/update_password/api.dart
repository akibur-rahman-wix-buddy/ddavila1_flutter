import 'dart:convert';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class UpdateProfileApi {
  static final UpdateProfileApi _singleton = UpdateProfileApi._internal();

  UpdateProfileApi._internal();

  static UpdateProfileApi get instance => _singleton;

  Future<Map<String, dynamic>> updatePasswordApi({
    required dynamic oldPassword,
    required dynamic newPassword,
    required dynamic newPasswordConfirmation,
  }) async {
    try {
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> old password ${oldPassword.toString()}");
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> new password ${newPassword.toString()}");
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> new confirmation password ${newPasswordConfirmation.toString()}");
      Map<String, dynamic> data = {
        "old_password": oldPassword,
        "new_password": newPassword,
        "new_password_confirmation": newPasswordConfirmation,
      };
      // Make the POST request
      Response response =
          (await postHttp(Endpoints.passwordUpdate(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('Password Update Success');
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error during signup: $error");
      rethrow;
    }
  }
}
