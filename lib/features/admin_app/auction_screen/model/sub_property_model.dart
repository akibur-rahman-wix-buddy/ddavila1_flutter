import 'dart:convert';

class SubPropertyModel {
    final bool? success;
    final String? message;
    final List<Datem>? data;
    final int? code;

    SubPropertyModel({
        this.success,
        this.message,
        this.data,
        this.code,
    });

    factory SubPropertyModel.fromRawJson(String str) => SubPropertyModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SubPropertyModel.fromJson(Map<String, dynamic> json) => SubPropertyModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datem>.from(json["data"]!.map((x) => Datem.fromJson(x))),
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
    };
}

class Datem {
    final String? value;

    Datem({
        this.value,
    });

    factory Datem.fromRawJson(String str) => Datem.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datem.fromJson(Map<String, dynamic> json) => Datem(
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
    };
}
