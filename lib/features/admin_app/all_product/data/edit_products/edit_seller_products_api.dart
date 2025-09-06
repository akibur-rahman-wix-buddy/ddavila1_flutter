import 'dart:convert';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

final class EditSellerProductAPI {
  static final EditSellerProductAPI _singleton =
      EditSellerProductAPI._internal();

  EditSellerProductAPI._internal();

  static EditSellerProductAPI get instance => _singleton;

  Future<Map<String, dynamic>> updateSaleProducts({
    dynamic productId,
    dynamic title,
    dynamic description,
    dynamic categoryId,
    dynamic subcategoryId,
    dynamic type,
    // * sales data
    dynamic shippingCost,
    dynamic buyNowPrice,
    dynamic shipWithin,
    // * ##############
    List<XFile>? images, // List of XFile for images from image_picker
    List<dynamic>? propertyItem, // List of dynamic for product properties
    List<dynamic>? propertyValue, // List of dynamic for product properties
  }) async {
    try {
      // Create FormData for multipart request
      FormData formData = FormData.fromMap({
        "title": title,
        "description": description,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "type": type,
        "product_prop_title[]": propertyItem,
        "product_prop_value[]": propertyValue,
        // *  ===============> Sales data. <===============
        "shipping_cost": shippingCost,
        "price": buyNowPrice,
        "ship_within": shipWithin,
      });

      // Attach multiple images as MultipartFile under images[]
      if (images != null && images.isNotEmpty) {
        formData.files.addAll(
          await Future.wait(
            images.asMap().entries.map((entry) async {
              final index = entry.key;
              final xfile = entry.value;
              return MapEntry(
                'images[]',
                await MultipartFile.fromFile(
                  xfile.path,
                  filename: 'image_$index.${xfile.path.split('.').last}',
                ),
              );
            }).toList(),
          ),
        );
      }

      // Make the POST request with FormData
      Response response =
          await postHttp(Endpoints.editSaleProduct(productId), formData);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('Product Posted Successfully');
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error during product post: $error");
      rethrow;
    }
  }
}
