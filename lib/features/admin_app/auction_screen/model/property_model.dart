import 'dart:convert';

class PropertyModel {
  final bool? success;
  final String? message;
  final List<Datums>? data;
  final int? code;

  PropertyModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory PropertyModel.fromRawJson(String str) =>
      PropertyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datums>.from(json["data"]!.map((x) => Datums.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
      };
}

class Datums {
  final int? id;
  final String? title;

  Datums({
    this.id,
    this.title,
  });

  factory Datums.fromRawJson(String str) => Datums.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datums.fromJson(Map<String, dynamic> json) => Datums(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
