

// ########################################################
// * #### Authentication ####
// ########################################################


import 'package:ddavila/features/chat/data/rx_get_chat/rx.dart';
import 'package:ddavila/features/chat/data/rx_send_message/rx.dart';
import 'package:ddavila/features/chat/model/chat_list_data_model.dart';
import 'package:ddavila/features/chat/data/rx_Chat_list/rx.dart';
import 'package:ddavila/features/chat/model/chat_to_person.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ddavila/features/auth_screen/data/rx_sign_in/rx.dart';

SignInApiRx signInApiRx = SignInApiRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);


SendMessageRx sendMessageRx = SendMessageRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

GetAllChatListRx getAllChatListRx = GetAllChatListRx(
  empty: ChatListModelData(),
  dataFetcher: BehaviorSubject<ChatListModelData>(),
);

GetChatMessageRx getChatMessageRx = GetChatMessageRx(
  empty: PersonalChatScreenDataModel(),
  dataFetcher: BehaviorSubject<PersonalChatScreenDataModel>(),
);
