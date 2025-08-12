
import 'dart:convert';

class HomeCategoryApiDataModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  HomeCategoryApiDataModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory HomeCategoryApiDataModel.fromRawJson(String str) => HomeCategoryApiDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeCategoryApiDataModel.fromJson(Map<String, dynamic> json) => HomeCategoryApiDataModel(
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
  int? trending;
  int? popular;
  Status? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  List<Subcategory>? subcategories;

  Datum({
    this.id,
    this.title,
    this.slug,
    this.image,
    this.trending,
    this.popular,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.subcategories,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    image: json["image"],
    trending: json["trending"],
    popular: json["popular"],
    status: statusValues.map[json["status"]]!,
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    subcategories: json["subcategories"] == null ? [] : List<Subcategory>.from(json["subcategories"]!.map((x) => Subcategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "image": image,
    "trending": trending,
    "popular": popular,
    "status": statusValues.reverse[status],
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
  };
}

enum Status {
  ACTIVE
}

final statusValues = EnumValues({
  "active": Status.ACTIVE
});

class Subcategory {
  int? id;
  int? categoryId;
  String? title;
  String? slug;
  String? image;
  int? trending;
  int? popular;
  DateTime? createdAt;
  DateTime? updatedAt;

  Subcategory({
    this.id,
    this.categoryId,
    this.title,
    this.slug,
    this.image,
    this.trending,
    this.popular,
    this.createdAt,
    this.updatedAt,
  });

  factory Subcategory.fromRawJson(String str) => Subcategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json["id"],
    categoryId: json["category_id"],
    title: json["title"],
    slug: json["slug"],
    image: json["image"],
    trending: json["trending"],
    popular: json["popular"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "title": title,
    "slug": slug,
    "image": image,
    "trending": trending,
    "popular": popular,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
