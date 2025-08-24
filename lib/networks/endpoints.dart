// ignore_for_file: constant_identifier_names
//const String url = "http://192.168.40.86:8000";
const String url = "https://ddvila.softvencefsd.xyz/api";
const String image_url = "https://ddvila.softvencefsd.xyz/";
const String imageUrls = "$url/";

final class NetworkConstants {
  NetworkConstants._();

  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class Endpoints {
  Endpoints._();

// Authentication API
  static String logInUrl() => "/login";
  static String signUpUrl() => "/register";
  static String chatterListUrl() => "/messages";
  static String getChatList({dynamic participantableId}) =>
      "/messages/$participantableId";
  static String postSentMessage() => "/api//messages";
  static String homeCategoryApiLink() => "/categories";
  static String popularCategoryApiLink() => "/categories/popular";
  static String liveAuctionDataApiLink() => "/auctions/popular";
  static String liveAuctionDetailsDataApiLink({required dynamic slug}) =>
      "/products/$slug";
  static String postBitPriceApiLink({required dynamic id}) =>
      "/auction/bid/$id";
  static String categoryWiseProductDataLink({required dynamic id}) =>
      "/categories/$id/products";
  static String logoutApiLink() => "/logout";
  static String getFilterApiLink() => "/products/filter/items";
  static String postFilterApiLink() => "/all/products/auction/filter";

  static String wishList() => "/bookmark";
  static String auctionComplete(dynamic pageNum) =>
      "/auctions/completed?page=$pageNum";
  static String auctionRunning(dynamic pageNum) =>
      "/auctions/running?page=$pageNum";
  static String adminDashboard() => "/seller/dashboard/index";
  static String buyingOrderBoard() => "/auth_buying_orders";
  static String sellingOrderBoard() => "/auth_selling_orders";


  // * category API
  static String categoryAPI() => "/categories";
  static String propertyAPI() => "/seller/product/all/propertys";
  static String subPropertyAPI(dynamic title) =>
      "/seller/product/propertys/$title";

  static String productDetails({dynamic slug}) => "/products/$slug";
  static String saleProductStripePayment() => "/stripe/checkout";
  static String createConversation()=> "/messages/create";
  static String whiteListApiLink()=> "/bookmark";
  static String searchResultApiLink()=> "/products/search";
  static String getStates()=> "/states";
  static String completeProfile()=> "/profile/complete";
}
