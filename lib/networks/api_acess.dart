

// ########################################################
// * #### Authentication ####
// ########################################################


import 'package:ddavila/features/chat/data/rx_get_chat/rx.dart';
import 'package:ddavila/features/chat/data/rx_send_message/rx.dart';
import 'package:ddavila/features/chat/model/chat_list_data_model.dart';
import 'package:ddavila/features/chat/data/rx_Chat_list/rx.dart';
import 'package:ddavila/features/chat/model/chat_to_person.dart';
import 'package:ddavila/features/user_app/home_screen/data/category_wise_product_Data/rx.dart';
import 'package:ddavila/features/user_app/home_screen/data/live_auction_rx/rx.dart';
import 'package:ddavila/features/user_app/home_screen/data/rx_popular_category_Data/rx.dart';
import 'package:ddavila/features/user_app/home_screen/model/category_wise_data_model.dart';
import 'package:ddavila/features/user_app/home_screen/model/home_category_data_model.dart';
import 'package:ddavila/features/user_app/home_screen/model/live_autction_data_model.dart';
import 'package:ddavila/features/user_app/home_screen/model/popular_category_data_model.dart';
import 'package:ddavila/features/user_app/products_screen/data/live_auction_details_rx/rx.dart';
import 'package:ddavila/features/user_app/products_screen/data/post_bit_price/rx.dart';
import 'package:ddavila/features/user_app/products_screen/model/live_action_details_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ddavila/features/auth_screen/data/rx_sign_in/rx.dart';

import '../features/user_app/home_screen/data/rx_home_category_Data/rx.dart';

SignInApiRx signInApiRx = SignInApiRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);


SendMessageRx sendMessageRx = SendMessageRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);


PostBitRx postBitRx = PostBitRx(
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

GetPopularCategoryRx getPopularCategoryRx = GetPopularCategoryRx(
  empty: PopularCategoryDataModel(),
  dataFetcher: BehaviorSubject<PopularCategoryDataModel>(),
);

GetHomeCategoryRx getHomeCategoryRx = GetHomeCategoryRx(
  empty: HomeCategoryApiDataModel(),
  dataFetcher: BehaviorSubject<HomeCategoryApiDataModel>(),
);

LiveAuctionDataRx liveAuctionDataRx = LiveAuctionDataRx(
  empty: LiveAuctionApiDataModel(),
  dataFetcher: BehaviorSubject<LiveAuctionApiDataModel>(),
);

CategoryWiseProductRx categoryWiseProductRx = CategoryWiseProductRx(
  empty: CategoryWiseProductDataModel(),
  dataFetcher: BehaviorSubject<CategoryWiseProductDataModel>(),
);

final liveAuctionDetailsDataRx = LiveAuctionDetailsDataRx(
  empty: LiveAuctionDetailsApiDataModel(),
  dataFetcher: BehaviorSubject<LiveAuctionDetailsApiDataModel>(),
);