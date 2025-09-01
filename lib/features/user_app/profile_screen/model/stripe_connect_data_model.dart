
import 'dart:convert';

class StripeConnectDataModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  StripeConnectDataModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory StripeConnectDataModel.fromRawJson(String str) => StripeConnectDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StripeConnectDataModel.fromJson(Map<String, dynamic> json) => StripeConnectDataModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "code": code,
  };
}

class Data {
  String? dashboardUrl;

  Data({
    this.dashboardUrl,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dashboardUrl: json["dashboard_url"],
  );

  Map<String, dynamic> toJson() => {
    "dashboard_url": dashboardUrl,
  };
}
