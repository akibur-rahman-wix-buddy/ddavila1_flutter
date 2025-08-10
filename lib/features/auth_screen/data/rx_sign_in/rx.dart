import 'dart:developer';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';

import 'api.dart';

final class SignInApiRx extends RxResponseInt<Map<String, dynamic>> {
  final api = SignInApi.instance;

  SignInApiRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> signIn({
    required String email,
    required dynamic password,
  }) async {
    try {
      // Call the sign-in API
      Map<String, dynamic> data =
          await api.signInApi(email: email, password: password);

      String token = data['data']['token']['original']['access_token'];
      log(">>>>>>>>>>>>>>> login token is : $token");
      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      // Handle error
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {
    // Extract the token from the response
    String token = data['data']['token']['original']['access_token'];
    // String userId = data['data']['user']['id'];

    print(">>>>>>>>>>>>>>>>>>>>>>> here is the token:${token}");
    // print(">>>>>>>>>>>>>>>>>>>>>>> here is the id:${userId}");

    // Save the token and login status using appData
    appData.write(kKeyAccessToken, token); // Storing the token

    // appData.write(kKeyUserID,userId );
    print(
        ">>>>>>>>>>>>>>>>>>>> here isthe access info rx :${appData.read(kKeyIsLoggedIn)}");
    print(
        ">>>>>>>>>>>>>>>>>>>> here is the user id :${appData.read(kKeyUserID)}");
    appData.write(kKeyIsLoggedIn, true);
    print(
        ">>>>>>>>>>>>>>>>>>>> here is the access info rx :${appData.read(kKeyIsLoggedIn)}");

    // Update DioSingleton with the new token
    DioSingleton.instance.update(token);
    // Add the data to the stream
    dataFetcher.sink.add(data);

    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    // Handle API error using DioException
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["error"]);
      } else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}
