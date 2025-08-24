
import 'dart:convert';

class ProductDetailsDataModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  ProductDetailsDataModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory ProductDetailsDataModel.fromRawJson(String str) => ProductDetailsDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDetailsDataModel.fromJson(Map<String, dynamic> json) => ProductDetailsDataModel(
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
  int? id;
  String? title;
  String? slug;
  List<String>? productDetailsImages;
  String? description;
  int? price;
  String? type;
  int? bid;
  String? shippingCost;
  int? startingPrice;
  DateTime? auctionEndAt;
  int? userId;
  int? categoryId;
  int? subCategoryId;
  bool? bookmark;
  int? highestBid;
  String? firstImage;
  List<dynamic>? bids;
  List<Property>? properties;

  Data({
    this.id,
    this.title,
    this.slug,
    this.productDetailsImages,
    this.description,
    this.price,
    this.type,
    this.bid,
    this.shippingCost,
    this.startingPrice,
    this.auctionEndAt,
    this.userId,
    this.categoryId,
    this.subCategoryId,
    this.bookmark,
    this.highestBid,
    this.firstImage,
    this.bids,
    this.properties,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    productDetailsImages: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    description: json["description"],
    price: json["price"],
    type: json["type"],
    bid: json["bid"],
    shippingCost: json["shipping_cost"],
    startingPrice: json["starting_price"],
    auctionEndAt: json["auction_end_at"] == null ? null : DateTime.parse(json["auction_end_at"]),
    userId: json["user_id"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    bookmark: json["bookmark"],
    highestBid: json["highest_bid"],
    firstImage: json["first_image"],
    bids: json["bids"] == null ? [] : List<dynamic>.from(json["bids"]!.map((x) => x)),
    properties: json["properties"] == null ? [] : List<Property>.from(json["properties"]!.map((x) => Property.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "images": productDetailsImages == null ? [] : List<dynamic>.from(productDetailsImages!.map((x) => x)),
    "description": description,
    "price": price,
    "type": type,
    "bid": bid,
    "shipping_cost": shippingCost,
    "starting_price": startingPrice,
    "auction_end_at": auctionEndAt?.toIso8601String(),
    "user_id": userId,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "bookmark": bookmark,
    "highest_bid": highestBid,
    "first_image": firstImage,
    "bids": bids == null ? [] : List<dynamic>.from(bids!.map((x) => x)),
    "properties": properties == null ? [] : List<dynamic>.from(properties!.map((x) => x.toJson())),
  };
}

class Property {
  int? id;
  int? productId;
  String? title;
  String? value;
  DateTime? createdAt;
  DateTime? updatedAt;

  Property({
    this.id,
    this.productId,
    this.title,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  factory Property.fromRawJson(String str) => Property.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Property.fromJson(Map<String, dynamic> json) => Property(
    id: json["id"],
    productId: json["product_id"],
    title: json["title"],
    value: json["value"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "title": title,
    "value": value,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
