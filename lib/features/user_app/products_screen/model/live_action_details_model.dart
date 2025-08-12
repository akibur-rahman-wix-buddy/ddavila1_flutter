
import 'dart:convert';

class LiveAuctionDetailsApiDataModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  LiveAuctionDetailsApiDataModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory LiveAuctionDetailsApiDataModel.fromRawJson(String str) => LiveAuctionDetailsApiDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LiveAuctionDetailsApiDataModel.fromJson(Map<String, dynamic> json) => LiveAuctionDetailsApiDataModel(
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
  List<String>? images;
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
  List<Bid>? bids;
  List<Property>? properties;

  Data({
    this.id,
    this.title,
    this.slug,
    this.images,
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
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
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
    bids: json["bids"] == null ? [] : List<Bid>.from(json["bids"]!.map((x) => Bid.fromJson(x))),
    properties: json["properties"] == null ? [] : List<Property>.from(json["properties"]!.map((x) => Property.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
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
    "bids": bids == null ? [] : List<dynamic>.from(bids!.map((x) => x.toJson())),
    "properties": properties == null ? [] : List<dynamic>.from(properties!.map((x) => x.toJson())),
  };
}

class Bid {
  int? id;
  int? productId;
  int? userId;
  int? amount;
  int? isWinner;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  User? user;

  Bid({
    this.id,
    this.productId,
    this.userId,
    this.amount,
    this.isWinner,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.user,
  });

  factory Bid.fromRawJson(String str) => Bid.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bid.fromJson(Map<String, dynamic> json) => Bid(
    id: json["id"],
    productId: json["product_id"],
    userId: json["user_id"],
    amount: json["amount"],
    isWinner: json["is_winner"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "user_id": userId,
    "amount": amount,
    "is_winner": isWinner,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? name;
  String? email;
  String? avatar;
  DateTime? emailVerifiedAt;
  String? stripeAccountId;
  int? onboardComplete;
  dynamic country;
  String? city;
  String? state;
  String? address;
  String? phone;
  bool? isBanned;
  String? zipCode;
  dynamic deletedAt;
  bool? cardAttributes;

  User({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.emailVerifiedAt,
    this.stripeAccountId,
    this.onboardComplete,
    this.country,
    this.city,
    this.state,
    this.address,
    this.phone,
    this.isBanned,
    this.zipCode,
    this.deletedAt,
    this.cardAttributes,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    avatar: json["avatar"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    stripeAccountId: json["stripe_account_id"],
    onboardComplete: json["onboard_complete"],
    country: json["country"],
    city: json["city"],
    state: json["state"],
    address: json["address"],
    phone: json["phone"],
    isBanned: json["is_banned"],
    zipCode: json["zip_code"],
    deletedAt: json["deleted_at"],
    cardAttributes: json["card_attributes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "avatar": avatar,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "stripe_account_id": stripeAccountId,
    "onboard_complete": onboardComplete,
    "country": country,
    "city": city,
    "state": state,
    "address": address,
    "phone": phone,
    "is_banned": isBanned,
    "zip_code": zipCode,
    "deleted_at": deletedAt,
    "card_attributes": cardAttributes,
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
