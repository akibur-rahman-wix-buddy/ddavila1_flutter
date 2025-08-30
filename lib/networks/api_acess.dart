// ########################################################
// * #### Authentication ####
// ########################################################

import 'package:ddavila/features/admin_app/auction_screen/data/get_category/get_category_rx.dart';
import 'package:ddavila/features/admin_app/auction_screen/data/get_property/get_property_rx.dart';
import 'package:ddavila/features/admin_app/auction_screen/data/get_property/get_sub_property_rx.dart';
import 'package:ddavila/features/admin_app/auction_screen/model/auction_model.dart';
import 'package:ddavila/features/admin_app/auction_screen/model/category_model.dart';
import 'package:ddavila/features/admin_app/auction_screen/model/property_model.dart';
import 'package:ddavila/features/admin_app/auction_screen/model/sub_property_model.dart';
import 'package:ddavila/features/admin_app/buying/data/get_buying_data/buying_order_rx.dart';
import 'package:ddavila/features/admin_app/buying/model/buying_order_data_model.dart';
import 'package:ddavila/features/admin_app/dashboard_screen/data/admindash_rx.dart';
import 'package:ddavila/features/admin_app/dashboard_screen/model/admin_dash_model.dart';
import 'package:ddavila/features/admin_app/seling/data/selling_order_data/buying_order_rx.dart';
import 'package:ddavila/features/admin_app/seling/model/selling_order_data_model.dart';
import 'package:ddavila/features/admin_app/wishlist_screen/model/wishlist_model.dart';
import 'package:ddavila/features/auth_screen/data/rx_sign_up/rx.dart';
import 'package:ddavila/features/auth_screen/data/stripe_card_add/rx.dart';
import 'package:ddavila/features/auth_screen/data/varify_otp/rx.dart';
import 'package:ddavila/features/chat/data/rx_create_conversation/rx.dart';
import 'package:ddavila/features/chat/data/rx_get_chat/rx.dart';
import 'package:ddavila/features/chat/data/rx_send_message/rx.dart';
import 'package:ddavila/features/chat/model/chat_list_data_model.dart';
import 'package:ddavila/features/chat/data/rx_Chat_list/rx.dart';
import 'package:ddavila/features/chat/model/chat_to_person.dart';
import 'package:ddavila/features/chat/model/conversation_model_data.dart';
import 'package:ddavila/features/user_app/filter_screen/data/product_filter_category_Data/rx.dart';
import 'package:ddavila/features/user_app/filter_screen/data/rx_post_filter/rx.dart';
import 'package:ddavila/features/user_app/filter_screen/model/cetagory_wise_sub_category_model_data.dart';
import 'package:ddavila/features/user_app/home_screen/data/category_wise_product_Data/rx.dart';
import 'package:ddavila/features/user_app/home_screen/data/live_auction_rx/rx.dart';
import 'package:ddavila/features/user_app/home_screen/data/rx_popular_category_Data/rx.dart';
import 'package:ddavila/features/user_app/home_screen/model/category_wise_data_model.dart';
import 'package:ddavila/features/user_app/home_screen/model/home_category_data_model.dart';
import 'package:ddavila/features/user_app/home_screen/model/live_autction_data_model.dart';
import 'package:ddavila/features/user_app/home_screen/model/popular_category_data_model.dart';
import 'package:ddavila/features/user_app/products_screen/data/bit_payment_data/rx.dart';
import 'package:ddavila/features/user_app/products_screen/data/get_state_api/rx.dart';
import 'package:ddavila/features/user_app/products_screen/data/live_auction_details_rx/rx.dart';
import 'package:ddavila/features/user_app/products_screen/data/post_bit_price/rx.dart';
import 'package:ddavila/features/user_app/products_screen/data/post_white_list_data/rx.dart';
import 'package:ddavila/features/user_app/products_screen/data/sale_product_payment_data/rx.dart';
import 'package:ddavila/features/user_app/products_screen/data/sate_product_detailes_data/rx.dart';
import 'package:ddavila/features/user_app/products_screen/model/live_action_details_model.dart';
import 'package:ddavila/features/user_app/profile_screen/data/my_self_Data/rx.dart';
import 'package:ddavila/features/user_app/profile_screen/data/post_update_profile_data/rx.dart';
import 'package:ddavila/features/user_app/profile_screen/data/rx_logout/rx.dart';
import 'package:ddavila/features/user_app/products_screen/model/sale_product_details_data_model.dart';
import 'package:ddavila/features/user_app/profile_screen/model/my_self_model_data.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ddavila/features/auth_screen/data/rx_sign_in/rx.dart';

import '../features/admin_app/auction_screen/data/auction_complete/get_rx.dart';
import '../features/admin_app/auction_screen/data/auction_ongoing/get_rx.dart';
import '../features/admin_app/auction_screen/model/auction_running_model.dart';
import '../features/admin_app/wishlist_screen/data/get_rx.dart';
import '../features/auth_screen/complete_account_info/data/get_states/get_states_rx.dart';
import '../features/auth_screen/complete_account_info/data/post_create_profile/rx.dart';
import '../features/auth_screen/complete_account_info/model/state_model.dart';
import '../features/user_app/home_screen/data/rx_home_category_Data/rx.dart';
import '../features/user_app/products_screen/model/state_data_model.dart';
import '../features/user_app/profile_screen/data/update_password/rx.dart' show UpdatePasswordRx;

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

PostLogOutRX postLogOutRX = PostLogOutRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

SignUpApiRx signUpApiRx = SignUpApiRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

RxFilterPostRx rxFilterPostRx = RxFilterPostRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

PostSaleProductPaymentRx postSaleProductPaymentRx = PostSaleProductPaymentRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

PostWhiteListRx postWhiteListRx = PostWhiteListRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

StripeCardAddRx stripeCardAddRx = StripeCardAddRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

VerificationOtpRx verificationOtpRx = VerificationOtpRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);



GetAllChatListRx getAllChatListRx = GetAllChatListRx(
  empty: ChatListModelData(),
  dataFetcher: BehaviorSubject<ChatListModelData>(),
);


MySelfRx mySelfRx = MySelfRx(
  empty: MySelfModelData(),
  dataFetcher: BehaviorSubject<MySelfModelData>(),
);

GetChatMessageRx getChatMessageRx = GetChatMessageRx(
  empty: PersonalChatScreenDataModel(),
  dataFetcher: BehaviorSubject<PersonalChatScreenDataModel>(),
);

GetBuyingOrderRX getBuyingOrderRX = GetBuyingOrderRX(
  empty: BuyingOrderDataModel(),
  dataFetcher: BehaviorSubject<BuyingOrderDataModel>(),
);

GetSellingOrderRX getSellingOrderRX = GetSellingOrderRX(
  empty: SellingOrderDataModel(),
  dataFetcher: BehaviorSubject<SellingOrderDataModel>(),
);

GetPopularCategoryRx getPopularCategoryRx = GetPopularCategoryRx(
  empty: PopularCategoryDataModel(),
  dataFetcher: BehaviorSubject<PopularCategoryDataModel>(),
);

ProductViewDetailsRx productViewDetailsRx = ProductViewDetailsRx(
  empty: ProductDetailsDataModel(),
  dataFetcher: BehaviorSubject<ProductDetailsDataModel>(),
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

GetStateRx getStateRx = GetStateRx(
  empty: StateDataModel(),
  dataFetcher: BehaviorSubject<StateDataModel>(),
);

final liveAuctionDetailsDataRx = LiveAuctionDetailsDataRx(
  empty: LiveAuctionDetailsApiDataModel(),
  dataFetcher: BehaviorSubject<LiveAuctionDetailsApiDataModel>(),
);
FilterCategoryRx filterCategoryRx = FilterCategoryRx(
  empty: ProductFIlterModelData(),
  dataFetcher: BehaviorSubject<ProductFIlterModelData>(),
);

GetWishlistApiRx getWishlistApiRxObj = GetWishlistApiRx(
  empty: WishlistModel(),
  dataFetcher: BehaviorSubject<WishlistModel>(),
);

AuctionCompleteApiRx auctionCompleteApiRxObj = AuctionCompleteApiRx(
  empty: AuctionModel(),
  dataFetcher: BehaviorSubject<AuctionModel>(),
);

AuctionOngoingApiRx auctionOngoingApiRxObj = AuctionOngoingApiRx(
  empty: AuctionRunningModel(),
  dataFetcher: BehaviorSubject<AuctionRunningModel>(),
);

AdminDashAPIRX adminDashAPIRXObj = AdminDashAPIRX(
  empty: AdminDashModel(),
  dataFetcher: BehaviorSubject<AdminDashModel>(),
);

GetCategoryAPIRX getCategoryAPIRXObj = GetCategoryAPIRX(
  empty: CategoryModel(),
  dataFetcher: BehaviorSubject<CategoryModel>(),
);

GetPropertyAPIRX getPropertyAPIRXObj = GetPropertyAPIRX(
  empty: PropertyModel(),
  dataFetcher: BehaviorSubject<PropertyModel>(),
);

GetSubPropertyAPIRX getSubPropertyAPIRXObj = GetSubPropertyAPIRX(
  empty: SubPropertyModel(),
  dataFetcher: BehaviorSubject<SubPropertyModel>(),
);
    CreateConversationRx createConversationRx = CreateConversationRx(
    empty: ConversationCreateModelData(),
// dataFetcher: BehaviorSubject<ConversationCreateModelData>(),
);

CompleteProfileApiRx completeProfileApiRxObj = CompleteProfileApiRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);


BitPaymentRx bitPaymentRx = BitPaymentRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);


UpdatePasswordRx updatePasswordRx = UpdatePasswordRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

UpdateProfileApiRx  updateProfileApiRx = UpdateProfileApiRx(

);


GetStateApiRX getStateApiRXObj = GetStateApiRX(
  empty: StatesModel(),
  dataFetcher: BehaviorSubject<StatesModel>(),
);