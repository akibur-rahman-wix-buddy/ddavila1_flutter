import 'dart:convert';

class LiveAuctionApiDataModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  LiveAuctionApiDataModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory LiveAuctionApiDataModel.fromRawJson(String str) => LiveAuctionApiDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LiveAuctionApiDataModel.fromJson(Map<String, dynamic> json) => LiveAuctionApiDataModel(
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
  int? categoryId;
  int? subCategoryId;
  String? title;
  List<String>? images;
  DateTime? auctionEndAt;
  int? price;
  String? type;
  int? bid;
  String? slug;
  int? shipWithin;
  int? startingPrice;
  int? bidsCount;
  bool? bookmark;
  int? highestBid;
  String? firstImage;
  List<Bid>? bids;

  Datum({
    this.id,
    this.categoryId,
    this.subCategoryId,
    this.title,
    this.images,
    this.auctionEndAt,
    this.price,
    this.type,
    this.bid,
    this.slug,
    this.shipWithin,
    this.startingPrice,
    this.bidsCount,
    this.bookmark,
    this.highestBid,
    this.firstImage,
    this.bids,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    title: json["title"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    auctionEndAt: json["auction_end_at"] == null ? null : DateTime.parse(json["auction_end_at"]),
    price: json["price"],
    type: json["type"],
    bid: json["bid"],
    slug: json["slug"],
    shipWithin: json["ship_within"],
    startingPrice: json["starting_price"],
    bidsCount: json["bids_count"],
    bookmark: json["bookmark"],
    highestBid: json["highest_bid"],
    firstImage: json["first_image"],
    bids: json["bids"] == null ? [] : List<Bid>.from(json["bids"]!.map((x) => Bid.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "title": title,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "auction_end_at": auctionEndAt?.toIso8601String(),
    "price": price,
    "type": type,
    "bid": bid,
    "slug": slug,
    "ship_within": shipWithin,
    "starting_price": startingPrice,
    "bids_count": bidsCount,
    "bookmark": bookmark,
    "highest_bid": highestBid,
    "first_image": firstImage,
    "bids": bids == null ? [] : List<dynamic>.from(bids!.map((x) => x.toJson())),
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
  String? country;
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
