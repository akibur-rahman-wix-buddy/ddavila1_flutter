import 'dart:convert';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class DeleteProductAPI {
  static final DeleteProductAPI _singleton = DeleteProductAPI._internal();

  DeleteProductAPI._internal();

  static DeleteProductAPI get instance => _singleton;

  Future<Map<String, dynamic>> deleteProduct({
    required dynamic productID,
// List of dynamic for product properties
  }) async {
    try {
      // Create FormData for multipart request
      FormData formData = FormData.fromMap({
        "title": productID,
      });
      // Make the POST request with FormData
      Response response =
          await getHttp(Endpoints.deleteProduct(productID), formData);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('Product Deleted Successfully');
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error during product delete: $error");
      rethrow;
    }
  }
}
