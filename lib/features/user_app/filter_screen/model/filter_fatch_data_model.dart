import 'dart:convert';

class FilterProductDataModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  FilterProductDataModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory FilterProductDataModel.fromRawJson(String str) => FilterProductDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FilterProductDataModel.fromJson(Map<String, dynamic> json) => FilterProductDataModel(
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
  List<FilterDatum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
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
    data: json["data"] == null ? [] : List<FilterDatum>.from(json["data"]!.map((x) => FilterDatum.fromJson(x))),
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

class FilterDatum {
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
  int? winnerId;
  Status? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  bool? bookmark;
  List<Property>? properties;

  FilterDatum({
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
    this.properties,
  });

  factory FilterDatum.fromRawJson(String str) => FilterDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FilterDatum.fromJson(Map<String, dynamic> json) => FilterDatum(
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
    properties: json["properties"] == null ? [] : List<Property>.from(json["properties"]!.map((x) => Property.fromJson(x))),
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
    "properties": properties == null ? [] : List<dynamic>.from(properties!.map((x) => x.toJson())),
  };
}

class Property {
  int? id;
  int? productId;
  Title? title;
  Value? value;
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
    title: titleValues.map[json["title"]]!,
    value: valueValues.map[json["value"]]!,
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "title": titleValues.reverse[title],
    "value": valueValues.reverse[value],
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

enum Title {
  GRADE,
  RARITY,
  STAGE
}

final titleValues = EnumValues({
  "Grade": Title.GRADE,
  "Rarity": Title.RARITY,
  "Stage": Title.STAGE
});

enum Value {
  BASIC,
  COMMON,
  YES
}

final valueValues = EnumValues({
  "Basic": Value.BASIC,
  "Common": Value.COMMON,
  "Yes": Value.YES
});

enum Status {
  ACTIVE
}

final statusValues = EnumValues({
  "active": Status.ACTIVE
});

enum Type {
  AUCTION
}

final typeValues = EnumValues({
  "auction": Type.AUCTION
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
