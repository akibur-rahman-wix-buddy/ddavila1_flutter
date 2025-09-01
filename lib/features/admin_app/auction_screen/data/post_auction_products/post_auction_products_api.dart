import 'dart:convert';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:ddavila/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

final class PostAuctionProductAPI {
  static final PostAuctionProductAPI _singleton = PostAuctionProductAPI._internal();

  PostAuctionProductAPI._internal();

  static PostAuctionProductAPI get instance => _singleton;

  Future<Map<String, dynamic>> postProductAuction({
    required dynamic title,
    required dynamic description,
    required dynamic categoryId,
    required dynamic subcategoryId,
    required dynamic type,
    required dynamic shippingCost,
    required dynamic price,
    required dynamic shipWithin,
    required dynamic auction_end_at,
    required List<XFile> images,
    required List<String>
    propertyItem,
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
      });

      // Attach multiple images as MultipartFile under images[]
      if (images.isNotEmpty) {
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
      await postHttp(Endpoints.postProductsAuction(), formData);

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
