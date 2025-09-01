import 'dart:developer';
import 'package:ddavila/features/user_app/products_screen/model/state_data_model.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';



final class GetStateRx extends RxResponseInt<StateDataModel> {
  final api = GetStateApi.instance;

  GetStateRx({required super.empty, required super.dataFetcher});

  ValueStream get getAvailableItemsStream => dataFetcher.stream;

  Future<StateDataModel?> getStateInfo() async {
    try {
      final  data = await api.getStateApi();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }


  @override
  StateDataModel? handleSuccessWithReturn(dynamic data) {
    print("🔄 handleSuccessWithReturn called");
    print("Input data type: ${data.runtimeType}");
    print("Input data value: $data");

    try {
      // Add this to see what's happening during processing
      final result = super.handleSuccessWithReturn(data);
      print("✅ handleSuccessWithReturn completed");
      print("Result type: ${result.runtimeType}");
      print("Result value: $result");
      return result;
    } catch (e) {
      print("❌ Error in handleSuccessWithReturn: $e");
      print("Stack trace: ${StackTrace.current}");
      rethrow;
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final errorMessage = error.response?.data?["error"] ??
          error.response?.data?["message"] ??
          "An unknown error occurred.";

      // if (statusCode == 401) {
      //
      //   appData.write(kKeyIsLoggedIn, false);
      //   NavigationService.navigateToReplacement(Routes.loginScreen);
      // } else {
      //   ToastUtil.showShortToast(errorMessage);
      // }
    } else {
      ToastUtil.showShortToast("An unexpected error occurred.");
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return null;
  }
}

