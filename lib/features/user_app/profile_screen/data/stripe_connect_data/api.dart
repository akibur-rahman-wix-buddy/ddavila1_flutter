import 'dart:developer';
import 'package:ddavila/features/user_app/profile_screen/model/stripe_connect_data_model.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';



final class StripeConnectApi {
  static final StripeConnectApi _singleton = StripeConnectApi._internal();
  StripeConnectApi._internal();

  static StripeConnectApi get instance => _singleton;

  Future<StripeConnectDataModel> stripeConnectInfo() async {



    try {
      final response = await getHttp(Endpoints.stripeConnectApiLink());
      if (response.statusCode == 200) {
        return StripeConnectDataModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
