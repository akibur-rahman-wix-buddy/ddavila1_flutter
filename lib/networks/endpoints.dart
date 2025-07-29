// ignore_for_file: constant_identifier_names
//const String url = "http://192.168.40.86:8000";
const String url = "https://digikode.co.uk";
// const String url = "https://1c66-103-174-189-33.ngrok-free.app";
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
  static String socialLogin() => "/api/socialLogin";
  static String breedInfo() => "/api/breeds";
  static String tipInfo() => "/api/tips-and-care";
  static String logout() => "/api/logout";
  static String userDataInfo() => "/api/profile";
  static String catInfo() => "/api/fetch-breeds/cat"; // get cat breed list
  static String dogInfo() => "/api/fetch-breeds/dog"; // get dog breed list
  static String createPet() => "/api/pet/store";
  static String getPetInfo() => "/api/my-pet";
  static String postAnalyzeApi() => "/api/analyze-food";
  static String postHealthAnalyzeApi() => "/api/analyze-pet-health";
  static String postAnalyzeDetailsApi() => "/api/food-info/date";
  // add to cart
  static String addToCart(dynamic id) => "/api/add-and-update/$id";
  static String analyzeFoodApi(dynamic date, id) => "/api/food-info/date";
  static String getFoodInfo() => "/api/food-info/date";
  static String getSubscriptionInfo() => "/api/subscription-plans";
  static String postSubscription() => "/api/create-subscription";
  static String postGoalWeight() => "/api/weight/store";

  // analysis screen
  static String getNutritionMonthly(dynamic id) =>
      "/api/food-weight/five-months/$id";
  static String getNutritionDaily(dynamic id) => "/api/food-weight/today/$id";
  static String getNutritionWeekly(dynamic id) =>
      "/api/food-weight/this-week/$id";
  static String getWeeklyGoalWeight(dynamic id) =>
      "/api/pet-weight/this-week/$id";
  static String getMonthlyGoalWeight(dynamic id) =>
      "/api/pet-weight/this-month/$id";
  static String getSixMonthGoalWeight(dynamic id) =>
      "/api/pet-weight/six-month/$id";
  static String postSeletePet() => "/api/select-pet";

  // FCM Token API
  static String storeFCM() => "/api/firebase/token/add";
  static String getNotification() => "/api/notification/all";

  // health pet image
  static String getHealthStatus(dynamic id) =>
      "/api/get-all-pet-health-data/$id";

  // update pet info
  static String updatePet(dynamic id) => "/api/pet/update/$id";

  //============= Subscription Status =======================
  static String getSubscriptionStatus() => "/api/is-subscribed";
}
