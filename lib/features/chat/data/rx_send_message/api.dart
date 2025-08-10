
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
    List<XFile>? avatars, // Changed from XFile? to List<XFile>?
  }) async {
    try {


      List<MultipartFile> imageFiles = [];

      for (var img in avatars!) {
        final fileExists = await File(img.path).exists();
        log("📸 Checking image: ${img.path} => exists: $fileExists");

        if (fileExists) {
          MultipartFile file = await MultipartFile.fromFile(
            img.path,
            filename: img.name,
          );
          imageFiles.add(file);
        } else {
          log("⚠️ Skipping non-existent image: ${img.path}");
        }
      }


      log(">>>>>>>>>>>>>>>>> this is the message value: $message");
      log(">>>>>>>>>>>>>>>>> this is the message value: $imageFiles");

      FormData data;

      if (message.toString().isEmpty) {
        data = FormData.fromMap({
          "to_user_id": toUserId,
          "files[]": imageFiles,
        });
      } else if (avatars.isEmpty) {
        data = FormData.fromMap({
          "message": message,
          if (toUserId != null) "to_user_id": toUserId,
        });
      } else {
        data = FormData.fromMap({
          if (message != null) "message": message,
          if (toUserId != null) "to_user_id": toUserId,
          "files[]": imageFiles,
        });
      }

      // // Prepare FormData
      // final FormData data = FormData.fromMap({
      //   if (message != null)"message": message,
      //   if (toUserId != null) "to_user_id": toUserId,
      //   "files[]": imageFiles,
      // });

      print("Request Data: ${data.fields}");

      // Make API call
      final Response response =
          await postHttp(Endpoints.postSentMessage(), data);

      if (response.statusCode == 200) {
        final responseData = response.data;
        ToastUtil.showShortToast('Message sent successfully.');
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
