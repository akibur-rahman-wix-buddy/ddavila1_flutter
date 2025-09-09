import 'dart:developer';
import 'dart:io';

import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/dio/dio.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class AddMessageApi {
  static final AddMessageApi _singleton = AddMessageApi._internal();

  AddMessageApi._internal();

  static AddMessageApi get instance => _singleton;

  Future<Map<String, dynamic>> addChat({
    dynamic message,
    dynamic toUserId,
    XFile? avatar, // Changed from List<XFile>? to single XFile?
  }) async {
    try {
      MultipartFile? imageFile;

      // Handle single image upload
      if (avatar != null) {
        final fileExists = await File(avatar.path).exists();
        log("📸 Checking image: ${avatar.path} => exists: $fileExists");

        if (fileExists) {
          imageFile = await MultipartFile.fromFile(
            avatar.path,
            filename: avatar.name,
          );
        } else {
          log("⚠️ Skipping non-existent image: ${avatar.path}");
          throw Exception("Selected image file does not exist");
        }
      }

      log(">>>>>>>>>>>>>>>>> this is the message value: $message");
      log(">>>>>>>>>>>>>>>>> this is the image file: ${imageFile?.filename}");

      FormData data;

      if (message.toString().isEmpty && imageFile != null) {
        data = FormData.fromMap({
          "to_user_id": toUserId,
          "files[]": imageFile, // Changed from "files[]" to "file"
        });
      } else if (avatar == null) {
        data = FormData.fromMap({
          "message": message,
          if (toUserId != null) "to_user_id": toUserId,
        });
      } else {
        data = FormData.fromMap({
          if (message != null) "message": message,
          if (toUserId != null) "to_user_id": toUserId,
          "files[]": imageFile, // Changed from "files[]" to "file"
        });
      }

      print("Request Data: ${data.fields}");

      // Make API call
      final Response response =
      await postHttp(Endpoints.postSentMessage(), data);

      if (response.statusCode == 200) {
        final responseData = response.data;
        return responseData;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error in createNetworkData: $error");
      ToastUtil.showShortToast("Failed to send message. Please try again.");
      rethrow;
    }
  }
}