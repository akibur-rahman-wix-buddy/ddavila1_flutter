//
// import 'package:image_picker/image_picker.dart';
// import 'package:rxdart/rxdart.dart';
//
// import '../../../../networks/rx_base.dart';
// import 'api.dart';
//
//
// final class SendMessageRx extends RxResponseInt<Map> {
//   final api = AddMessageApi.instance;
//
//   SendMessageRx({required super.empty, required super.dataFetcher});
//
//   ValueStream get chatListStream => dataFetcher.stream;
//
//   Future<Map?> addChat({required String message,     dynamic toUserId,   XFile? avatar,}) async {
//     try {
//       final data = await api.addChat(
//         message: message,
//         avatar: avatar,
//         toUserId: toUserId
//       );
//       handleSuccessWithReturn(data);
//       return data;
//     } catch (error) {
//       handleErrorWithReturn(error);
//       return null;
//     }
//   }
// }



import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../networks/rx_base.dart';
import 'api.dart';

final class SendMessageRx extends RxResponseInt<Map> {
  final api = AddMessageApi.instance;

  SendMessageRx({required super.empty, required super.dataFetcher});

  ValueStream get chatListStream => dataFetcher.stream;

  Future<Map?> addChat({
    required String message,
    dynamic toUserId,
    List<XFile>? avatars, // Changed from XFile? to List<XFile>?
  }) async {
    try {
      final data = await api.addChat(
        message: message,
        avatars: avatars, // Updated parameter name
        toUserId: toUserId,
      );
      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      handleErrorWithReturn(error);
      return null;
    }
  }
}