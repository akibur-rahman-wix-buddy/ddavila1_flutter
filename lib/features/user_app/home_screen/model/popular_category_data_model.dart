
import 'dart:convert';

class PopularCategoryDataModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  PopularCategoryDataModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory PopularCategoryDataModel.fromRawJson(String str) => PopularCategoryDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PopularCategoryDataModel.fromJson(Map<String, dynamic> json) => PopularCategoryDataModel(
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
  String? image;

  Datum({
    this.id,
    this.title,
    this.slug,
    this.image,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "image": image,
  };
}
