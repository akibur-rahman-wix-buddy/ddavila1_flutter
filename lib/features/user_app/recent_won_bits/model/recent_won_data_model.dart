import 'dart:convert';

// Top-level model for recent won data
class RecentWonDataModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  RecentWonDataModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory RecentWonDataModel.fromRawJson(String str) =>
      RecentWonDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecentWonDataModel.fromJson(Map<String, dynamic> json) =>
      RecentWonDataModel(
        success: json["success"] as bool?,
        message: json["message"] as String?,
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        code: json["code"] as int?,
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "code": code,
  };
}

// Data class for pagination and list of Datum
class Data {
  int? currentPage;
  List<RecentWonDatum>? data;
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
    currentPage: json["current_page"] as int?,
    data: json["data"] == null
        ? []
        : List<RecentWonDatum>.from(json["data"]!.map((x) => RecentWonDatum.fromJson(x))),
    firstPageUrl: json["first_page_url"] as String?,
    from: json["from"] as int?,
    lastPage: json["last_page"] as int?,
    lastPageUrl: json["last_page_url"] as String?,
    links: json["links"] == null
        ? []
        : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"] as String?,
    path: json["path"] as String?,
    perPage: json["per_page"] as int?,
    prevPageUrl: json["prev_page_url"],
    to: json["to"] as int?,
    total: json["total"] as int?,
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

// Datum class for individual order details
class RecentWonDatum {
  int? id;
  int? userId;
  int? paymentId;
  dynamic cartId;
  String? orderNumber;
  String? totalAmount;
  Currency? currency;
  DatumStatus? status;
  dynamic shippingAddress;
  Notes? notes;
  DateTime? orderedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Type? productType;
  String? taxAmount;
  String? shippingAmount;
  String? platformFee;
  String? sellerAmount;
  String? companyName;
  String? trackingNumber;
  User? user;
  List<RecentWonProduct>? products;

  RecentWonDatum({
    this.id,
    this.userId,
    this.paymentId,
    this.cartId,
    this.orderNumber,
    this.totalAmount,
    this.currency,
    this.status,
    this.shippingAddress,
    this.notes,
    this.orderedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.productType,
    this.taxAmount,
    this.shippingAmount,
    this.platformFee,
    this.sellerAmount,
    this.companyName,
    this.trackingNumber,
    this.user,
    this.products,
  });

  factory RecentWonDatum.fromRawJson(String str) => RecentWonDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecentWonDatum.fromJson(Map<String, dynamic> json) => RecentWonDatum(
    id: json["id"] as int?,
    userId: json["user_id"] as int?,
    paymentId: json["payment_id"] as int?,
    cartId: json["cart_id"],
    orderNumber: json["order_number"] as String?,
    totalAmount: json["total_amount"] as String?,
    currency: json["currency"] == null
        ? null
        : currencyValues.map[json["currency"]],
    status: json["status"] == null
        ? null
        : datumStatusValues.map[json["status"]],
    shippingAddress: json["shipping_address"],
    notes: json["notes"] == null ? null : notesValues.map[json["notes"]],
    orderedAt: json["ordered_at"] == null
        ? null
        : DateTime.parse(json["ordered_at"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    productType: json["product_type"] == null
        ? null
        : typeValues.map[json["product_type"]],
    taxAmount: json["tax_amount"] as String?,
    shippingAmount: json["shipping_amount"] as String?,
    platformFee: json["platform_fee"] as String?,
    sellerAmount: json["seller_amount"] as String?,
    companyName: json["company_name"] as String?,
    trackingNumber: json["tracking_number"] as String?,
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    products: json["products"] == null
        ? []
        : List<RecentWonProduct>.from(json["products"]!.map((x) => RecentWonProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "payment_id": paymentId,
    "cart_id": cartId,
    "order_number": orderNumber,
    "total_amount": totalAmount,
    "currency": currencyValues.reverse[currency],
    "status": datumStatusValues.reverse[status],
    "shipping_address": shippingAddress,
    "notes": notesValues.reverse[notes],
    "ordered_at": orderedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "product_type": typeValues.reverse[productType],
    "tax_amount": taxAmount,
    "shipping_amount": shippingAmount,
    "platform_fee": platformFee,
    "seller_amount": sellerAmount,
    "company_name": companyName,
    "tracking_number": trackingNumber,
    "user": user?.toJson(),
    "products": products == null
        ? []
        : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

// Enum for currency
enum Currency { USD }

final currencyValues = EnumValues({
  "USD": Currency.USD,
});

// Enum for notes
enum Notes {
  AUCTION_PAYMENT_FOR_BID_ID_90,
  STANDARD_SALE_ORDER,
}

final notesValues = EnumValues({
  "Auction payment for Bid ID: 90": Notes.AUCTION_PAYMENT_FOR_BID_ID_90,
  "Standard sale order": Notes.STANDARD_SALE_ORDER,
});

// Enum for product type
enum Type { AUCTION, SALE }

final typeValues = EnumValues({
  "auction": Type.AUCTION,
  "sale": Type.SALE,
});

// Product class
class RecentWonProduct {
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
  dynamic shippingCost;
  int? shipWithin;
  int? price;
  int? startingPrice;
  DateTime? auctionEndAt;
  dynamic winnerId;
  ProductStatus? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? laravelThroughKey;

  RecentWonProduct({
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
    this.laravelThroughKey,
  });

  factory RecentWonProduct.fromRawJson(String str) => RecentWonProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecentWonProduct.fromJson(Map<String, dynamic> json) => RecentWonProduct(
    id: json["id"] as int?,
    title: json["title"] as String?,
    slug: json["slug"] as String?,
    images: json["images"] == null
        ? []
        : List<String>.from(json["images"]!.map((x) => x as String)),
    description: json["description"] as String?,
    userId: json["user_id"] as int?,
    categoryId: json["category_id"] as int?,
    subCategoryId: json["sub_category_id"] as int?,
    stock: json["stock"] as int?,
    type: json["type"] == null ? null : typeValues.map[json["type"]],
    bid: json["bid"] as int?,
    shippingCost: json["shipping_cost"],
    shipWithin: json["ship_within"] as int?,
    price: json["price"] as int?,
    startingPrice: json["starting_price"] as int?,
    auctionEndAt: json["auction_end_at"] == null
        ? null
        : DateTime.parse(json["auction_end_at"]),
    winnerId: json["winner_id"],
    status: json["status"] == null
        ? null
        : productStatusValues.map[json["status"]],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    laravelThroughKey: json["laravel_through_key"] as int?,
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
    "status": productStatusValues.reverse[status],
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "laravel_through_key": laravelThroughKey,
  };
}

// Enum for product status
enum ProductStatus { INACTIVE }

final productStatusValues = EnumValues({
  "inactive": ProductStatus.INACTIVE,
});

// Enum for datum status
enum DatumStatus { COMPLETED, CONFIRMED, SHIPPING }

final datumStatusValues = EnumValues({
  "completed": DatumStatus.COMPLETED,
  "confirmed": DatumStatus.CONFIRMED,
  "shipping": DatumStatus.SHIPPING,
});

// User class
class User {
  int? id;
  Name? name;
  Email? email;
  Avatar? avatar;
  DateTime? emailVerifiedAt;
  StripeAccountId? stripeAccountId;
  int? onboardComplete;
  Country? country;
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
    id: json["id"] as int?,
    name: json["name"] == null ? null : nameValues.map[json["name"]],
    email: json["email"] == null ? null : emailValues.map[json["email"]],
    avatar: json["avatar"] == null ? null : avatarValues.map[json["avatar"]],
    emailVerifiedAt: json["email_verified_at"] == null
        ? null
        : DateTime.parse(json["email_verified_at"]),
    stripeAccountId: json["stripe_account_id"] == null
        ? null
        : stripeAccountIdValues.map[json["stripe_account_id"]],
    onboardComplete: json["onboard_complete"] as int?,
    country: json["country"] == null
        ? null
        : countryValues.map[json["country"]],
    city: json["city"] == null ? null : cityValues.map[json["city"]],
    state: json["state"] == null ? null : stateValues.map[json["state"]],
    address: json["address"] == null
        ? null
        : addressValues.map[json["address"]],
    phone: json["phone"] as String?,
    isBanned: json["is_banned"] as bool?,
    zipCode: json["zip_code"] as String?,
    deletedAt: json["deleted_at"],
    cardAttributes: json["card_attributes"] as bool?,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "email": emailValues.reverse[email],
    "avatar": avatarValues.reverse[avatar],
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "stripe_account_id": stripeAccountIdValues.reverse[stripeAccountId],
    "onboard_complete": onboardComplete,
    "country": countryValues.reverse[country],
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

// Enums for user-related fields
enum Address { DHAKA }

final addressValues = EnumValues({
  "dhaka": Address.DHAKA,
});

enum Avatar { UPLOADS_USERS_DAVID_1756961183_JPG }

final avatarValues = EnumValues({
  "uploads/users/david-1756961183.jpg": Avatar.UPLOADS_USERS_DAVID_1756961183_JPG,
});

enum City { BANGLADESH }

final cityValues = EnumValues({
  "bangladesh": City.BANGLADESH,
});

enum Country { USA }

final countryValues = EnumValues({
  "USA": Country.USA,
});

enum Email { SELLER_SELLER_COM }

final emailValues = EnumValues({
  "seller@seller.com": Email.SELLER_SELLER_COM,
});

enum Name { DAVID }

final nameValues = EnumValues({
  "David": Name.DAVID,
});

enum State { ALASKA }

final stateValues = EnumValues({
  "alaska": State.ALASKA,
});

enum StripeAccountId { ACCT_1_S0_FN_P9_QSNJ_FNX_V0 }

final stripeAccountIdValues = EnumValues({
  "acct_1S0FnP9qsnjFnxV0": StripeAccountId.ACCT_1_S0_FN_P9_QSNJ_FNX_V0,
});

// Link class for pagination links
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
    url: json["url"] as String?,
    label: json["label"] as String?,
    active: json["active"] as bool?,
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

// Utility class for enum mapping
class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}