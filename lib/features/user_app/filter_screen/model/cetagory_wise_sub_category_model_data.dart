import 'dart:convert';

class ProductFIlterModelData {
  bool? success;
  String? message;
  Data? data;
  int? code;

  ProductFIlterModelData({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory ProductFIlterModelData.fromRawJson(String str) => ProductFIlterModelData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductFIlterModelData.fromJson(Map<String, dynamic> json) => ProductFIlterModelData(
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
  List<String>? grade;
  List<String>? rarity;
  List<String>? stage;

  Data({
    this.grade,
    this.rarity,
    this.stage,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    grade: json["Grade"] == null ? [] : List<String>.from(json["Grade"]!.map((x) => x)),
    rarity: json["Rarity"] == null ? [] : List<String>.from(json["Rarity"]!.map((x) => x)),
    stage: json["Stage"] == null ? [] : List<String>.from(json["Stage"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Grade": grade == null ? [] : List<dynamic>.from(grade!.map((x) => x)),
    "Rarity": rarity == null ? [] : List<dynamic>.from(rarity!.map((x) => x)),
    "Stage": stage == null ? [] : List<dynamic>.from(stage!.map((x) => x)),
  };
}
