import 'dart:convert';

class StateDataModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  StateDataModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory StateDataModel.fromRawJson(String str) => StateDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StateDataModel.fromJson(Map<String, dynamic> json) => StateDataModel(
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
  double? percentage;
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
    percentage: _parsePercentage(json["percentage"]), // Use helper function
    stripeTaxRateId: json["stripe_tax_rate_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  // Helper function to handle different percentage formats
  static double? _parsePercentage(dynamic value) {
    if (value == null) return null;

    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        print("Warning: Could not parse percentage string: '$value'");
        return null;
      }
    }
    return null;
  }

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