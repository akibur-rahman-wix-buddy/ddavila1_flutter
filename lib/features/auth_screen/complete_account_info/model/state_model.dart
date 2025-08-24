import 'dart:convert';

class StatesModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  StatesModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory StatesModel.fromRawJson(String str) => StatesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StatesModel.fromJson(Map<String, dynamic> json) => StatesModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "code": code,
  };
}

class Datum {
  int? id;
  String? title;
  String? slug;
  String? percentage;
  String? stripeTaxRateId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.title,
    this.slug,
    this.percentage,
    this.stripeTaxRateId,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    percentage: json["percentage"],
    stripeTaxRateId: json["stripe_tax_rate_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "percentage": percentage,
    "stripe_tax_rate_id": stripeTaxRateId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
