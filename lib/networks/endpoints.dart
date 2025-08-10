// ignore_for_file: constant_identifier_names
//const String url = "http://192.168.40.86:8000";
const String url = "https://app.thehobbynexus.com";
const String image_url = "https://app.thehobbynexus.com/";
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
  static String logInUrl() => "/api/login";
  static String chatterListUrl() => "/api/messages";
  static String getChatList({dynamic participantableId}) => "/api//messages/$participantableId";
  static String postSentMessage() => "/api//messages";

}
