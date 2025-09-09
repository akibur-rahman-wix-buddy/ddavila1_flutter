// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

final class EditAuctionProductAPI {
  static final EditAuctionProductAPI _singleton =
      EditAuctionProductAPI._internal();

  EditAuctionProductAPI._internal();

  static EditAuctionProductAPI get instance => _singleton;

  Future<Map<String, dynamic>> updateProductAuction({
    dynamic productId,
    dynamic title,
    dynamic description,
    dynamic categoryId,
    dynamic subcategoryId,
    dynamic type,
    dynamic shippingCost,
    dynamic price,
    dynamic shipWithin,
    dynamic auction_end_at,
    List<XFile>? images,
    List<dynamic>? propertyItem,
    List<dynamic>? propertyValue,
  }) async {
    try {
      // Create FormData for multipart request
      FormData formData = FormData.fromMap({
        "title": title,
        "description": description,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "type": type,
        "shipping_cost": shippingCost,
        "auction_end_at": auction_end_at,
        "starting_price": price,
        "ship_within": shipWithin,
        "product_prop_title[]": propertyItem,
        "product_prop_value[]": propertyValue,
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
          await postHttp(Endpoints.editAuctionProduct(productId), formData);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('Product Update Successfully');
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
