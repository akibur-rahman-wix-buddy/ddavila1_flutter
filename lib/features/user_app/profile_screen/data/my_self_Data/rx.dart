// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/features/user_app/profile_screen/model/my_self_model_data.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';


final class MySelfRx extends RxResponseInt<MySelfModelData> {
  final api = MySelfApi.instance;

  MySelfRx({required super.empty, required super.dataFetcher});

  ValueStream get getAvailableItemsStream => dataFetcher.stream;

  Future<MySelfModelData?> mySelfData() async {
    try {
      final  data = await api.mySelfInfo();


      bool onBoardingIsTrue = true;

      if (data.data?.user?.state == null) {
        // String state = data.data!.user!.state.toString();
        onBoardingIsTrue = false ;
      }


      bool isStripeConnectIsTrue = data.data?.user?.cardAttributes == true ? true : false;
      dynamic myState = data.data?.user?.state;



      if(myState != null){

        print(">>>>>>>>>>>>>>>>>>>>>>>>>>> my state is ok ${myState} ");

        appData.write(kKeyMyState , myState);

        print(">>>>>>>>>>>>>>>>>>>>>>>>>>> my state is ok and data ${appData.read(kKeyMyState)} ");
      }else{
        appData.write(kKeyMyState , null);
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>> my state is not ok ");
      }







      if(onBoardingIsTrue == true){

        print(">>>>>>>>>>>>>>>>>>>>>>>>>>> onboading is ok ");

        appData.write(kKeyOnboarding, true);
      }else{
        appData.write(kKeyOnboarding, false);
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>> onboading is not ok ");
      }

      if(isStripeConnectIsTrue == true ){
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>> card attributes is ok ");

        appData.write(kKeyCardAttributes, true);
      }else{
        appData.write(kKeyCardAttributes, false);
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>> card attributes is not ok ");
      }


      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
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

