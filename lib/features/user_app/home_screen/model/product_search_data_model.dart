import 'dart:convert';

class ProductSearchApiDataModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  ProductSearchApiDataModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory ProductSearchApiDataModel.fromRawJson(String str) => ProductSearchApiDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductSearchApiDataModel.fromJson(Map<String, dynamic> json) => ProductSearchApiDataModel(
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
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  int? id;
  String? title;
  String? slug;
  List<String>? images;
  String? description;
  int? userId;
  int? categoryId;
  int? subCategoryId;
  int? stock;
  Type? type;
  int? bid;
  String? shippingCost;
  int? shipWithin;
  double? price;
  int? startingPrice;
  DateTime? auctionEndAt;
  dynamic winnerId;
  Status? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  bool? bookmark;
  int? highestBid;
  String? firstImage;
  List<Bid>? bids;

  Datum({
    this.id,
    this.title,
    this.slug,
    this.images,
    this.description,
    this.userId,
    this.categoryId,
    this.subCategoryId,
    this.stock,
    this.type,
    this.bid,
    this.shippingCost,
    this.shipWithin,
    this.price,
    this.startingPrice,
    this.auctionEndAt,
    this.winnerId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.bookmark,
    this.highestBid,
    this.firstImage,
    this.bids,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    description: json["description"],
    userId: json["user_id"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    stock: json["stock"],
    type: typeValues.map[json["type"]]!,
    bid: json["bid"],
    shippingCost: json["shipping_cost"],
    shipWithin: json["ship_within"],
    price: json["price"]?.toDouble(),
    startingPrice: json["starting_price"],
    auctionEndAt: json["auction_end_at"] == null ? null : DateTime.parse(json["auction_end_at"]),
    winnerId: json["winner_id"],
    status: statusValues.map[json["status"]]!,
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    bookmark: json["bookmark"],
    highestBid: json["highest_bid"],
    firstImage: json["first_image"],
    bids: json["bids"] == null ? [] : List<Bid>.from(json["bids"]!.map((x) => Bid.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "description": description,
    "user_id": userId,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "stock": stock,
    "type": typeValues.reverse[type],
    "bid": bid,
    "shipping_cost": shippingCost,
    "ship_within": shipWithin,
    "price": price,
    "starting_price": startingPrice,
    "auction_end_at": auctionEndAt?.toIso8601String(),
    "winner_id": winnerId,
    "status": statusValues.reverse[status],
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
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
  Avatar? avatar;
  DateTime? emailVerifiedAt;
  String? stripeAccountId;
  int? onboardComplete;
  String? country;
  City? city;
  State? state;
  Address? address;
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
    avatar: avatarValues.map[json["avatar"]]!,
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    stripeAccountId: json["stripe_account_id"],
    onboardComplete: json["onboard_complete"],
    country: json["country"],
    city: cityValues.map[json["city"]]!,
    state: stateValues.map[json["state"]]!,
    address: addressValues.map[json["address"]]!,
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
    "avatar": avatarValues.reverse[avatar],
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "stripe_account_id": stripeAccountId,
    "onboard_complete": onboardComplete,
    "country": country,
    "city": cityValues.reverse[city],
    "state": stateValues.reverse[state],
    "address": addressValues.reverse[address],
    "phone": phone,
    "is_banned": isBanned,
    "zip_code": zipCode,
    "deleted_at": deletedAt,
    "card_attributes": cardAttributes,
  };
}

enum Address {
  ASPERIORES_MAXIME_QU,
  FUGIAT_SIT_ET_QUO,
  MOOHAKHALI_425_KF,
  NEMO_ET_AUT_QUIS_ASS,
  THE_10365_CAMILLA_VALLEYS
}

final addressValues = EnumValues({
  "Asperiores maxime qu": Address.ASPERIORES_MAXIME_QU,
  "Fugiat sit et quo": Address.FUGIAT_SIT_ET_QUO,
  "Moohakhali 425, kf": Address.MOOHAKHALI_425_KF,
  "Nemo et aut quis ass": Address.NEMO_ET_AUT_QUIS_ASS,
  "10365 Camilla Valleys": Address.THE_10365_CAMILLA_VALLEYS
});

enum Avatar {
  UPLOADS_USERS_ETU_1753755842_WEBP,
  UPLOADS_USERS_HANSEN_1754448404_JPG,
  UPLOADS_USERS_RITURAZ_1754028676_WEBP,
  UPLOADS_USERS_RONJON_1753764742_WEBP,
  UPLOADS_USERS_SELLER_1753350714_PNG
}

final avatarValues = EnumValues({
  "uploads/users/etu-1753755842.webp": Avatar.UPLOADS_USERS_ETU_1753755842_WEBP,
  "uploads/users/hansen-1754448404.jpg": Avatar.UPLOADS_USERS_HANSEN_1754448404_JPG,
  "uploads/users/rituraz-1754028676.webp": Avatar.UPLOADS_USERS_RITURAZ_1754028676_WEBP,
  "uploads/users/ronjon-1753764742.webp": Avatar.UPLOADS_USERS_RONJON_1753764742_WEBP,
  "uploads/users/seller-1753350714.png": Avatar.UPLOADS_USERS_SELLER_1753350714_PNG
});

enum City {
  EST_QUOD_VOLUPTATEM,
  NEW_YORK,
  NUMQUAM_DEBITIS_SAEP,
  RECUSANDAE_PLACEAT,
  RERUM_VOLUPTATES_QUO,
  SCHUPPETON
}

final cityValues = EnumValues({
  "Est quod voluptatem": City.EST_QUOD_VOLUPTATEM,
  "New york": City.NEW_YORK,
  "Numquam debitis saep": City.NUMQUAM_DEBITIS_SAEP,
  "Recusandae Placeat": City.RECUSANDAE_PLACEAT,
  "Rerum voluptates quo": City.RERUM_VOLUPTATES_QUO,
  "Schuppeton": City.SCHUPPETON
});

enum State {
  COLORADO,
  CONNECTICUT,
  LOUISIANA
}

final stateValues = EnumValues({
  "colorado": State.COLORADO,
  "connecticut": State.CONNECTICUT,
  "louisiana": State.LOUISIANA
});

enum Status {
  ACTIVE
}

final statusValues = EnumValues({
  "active": Status.ACTIVE
});

enum Type {
  AUCTION,
  SALE
}

final typeValues = EnumValues({
  "auction": Type.AUCTION,
  "sale": Type.SALE
});

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
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
