// import 'dart:convert';
//
// class BuyingOrderDataModel {
//   bool? success;
//   String? message;
//   BuyingOrderData? data;
//   int? code;
//
//   BuyingOrderDataModel({
//     this.success,
//     this.message,
//     this.data,
//     this.code,
//   });
//
//   factory BuyingOrderDataModel.fromRawJson(String str) => BuyingOrderDataModel.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory BuyingOrderDataModel.fromJson(Map<String, dynamic> json) => BuyingOrderDataModel(
//     success: json["success"],
//     message: json["message"],
//     data: json["data"] == null ? null : BuyingOrderData.fromJson(json["data"]),
//     code: json["code"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "message": message,
//     "data": data?.toJson(),
//     "code": code,
//   };
// }
//
// class BuyingOrderData {
//   int? currentPage;
//   List<BuyingOrderDatum>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   List<Link>? links;
//   dynamic nextPageUrl;
//   String? path;
//   int? perPage;
//   dynamic prevPageUrl;
//   int? to;
//   int? total;
//
//   BuyingOrderData({
//     this.currentPage,
//     this.data,
//     this.firstPageUrl,
//     this.from,
//     this.lastPage,
//     this.lastPageUrl,
//     this.links,
//     this.nextPageUrl,
//     this.path,
//     this.perPage,
//     this.prevPageUrl,
//     this.to,
//     this.total,
//   });
//
//   factory BuyingOrderData.fromRawJson(String str) => BuyingOrderData.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory BuyingOrderData.fromJson(Map<String, dynamic> json) => BuyingOrderData(
//     currentPage: json["current_page"],
//     data: json["data"] == null ? [] : List<BuyingOrderDatum>.from(json["data"]!.map((x) => BuyingOrderDatum.fromJson(x))),
//     firstPageUrl: json["first_page_url"],
//     from: json["from"],
//     lastPage: json["last_page"],
//     lastPageUrl: json["last_page_url"],
//     links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
//     nextPageUrl: json["next_page_url"],
//     path: json["path"],
//     perPage: json["per_page"],
//     prevPageUrl: json["prev_page_url"],
//     to: json["to"],
//     total: json["total"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "current_page": currentPage,
//     "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//     "first_page_url": firstPageUrl,
//     "from": from,
//     "last_page": lastPage,
//     "last_page_url": lastPageUrl,
//     "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
//     "next_page_url": nextPageUrl,
//     "path": path,
//     "per_page": perPage,
//     "prev_page_url": prevPageUrl,
//     "to": to,
//     "total": total,
//   };
// }
//
// class BuyingOrderDatum {
//   int? id;
//   int? userId;
//   int? paymentId;
//   int? cartId;
//   String? orderNumber;
//   String? totalAmount;
//   Currency? currency;
//   DatumStatus? status;
//   ShippingAddress? shippingAddress;
//   String? notes;
//   DateTime? orderedAt;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   dynamic deletedAt;
//   Type? productType;
//   String? taxAmount;
//   String? shippingAmount;
//   String? platformFee;
//   String? sellerAmount;
//   String? companyName;
//   String? trackingNumber;
//   List<OrderItem>? orderItems;
//   User? user;
//
//   BuyingOrderDatum({
//     this.id,
//     this.userId,
//     this.paymentId,
//     this.cartId,
//     this.orderNumber,
//     this.totalAmount,
//     this.currency,
//     this.status,
//     this.shippingAddress,
//     this.notes,
//     this.orderedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.productType,
//     this.taxAmount,
//     this.shippingAmount,
//     this.platformFee,
//     this.sellerAmount,
//     this.companyName,
//     this.trackingNumber,
//     this.orderItems,
//     this.user,
//   });
//
//   factory BuyingOrderDatum.fromRawJson(String str) => BuyingOrderDatum.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory BuyingOrderDatum.fromJson(Map<String, dynamic> json) => BuyingOrderDatum(
//     id: json["id"],
//     userId: json["user_id"],
//     paymentId: json["payment_id"],
//     cartId: json["cart_id"],
//     orderNumber: json["order_number"],
//     totalAmount: json["total_amount"],
//     currency: currencyValues.map[json["currency"]]!,
//     status: datumStatusValues.map[json["status"]]!,
//     shippingAddress: json["shipping_address"] == null ? null : ShippingAddress.fromJson(json["shipping_address"]),
//     notes: json["notes"],
//     orderedAt: json["ordered_at"] == null ? null : DateTime.parse(json["ordered_at"]),
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//     productType: typeValues.map[json["product_type"]]!,
//     taxAmount: json["tax_amount"],
//     shippingAmount: json["shipping_amount"],
//     platformFee: json["platform_fee"],
//     sellerAmount: json["seller_amount"],
//     companyName: json["company_name"],
//     trackingNumber: json["tracking_number"],
//     orderItems: json["order_items"] == null ? [] : List<OrderItem>.from(json["order_items"]!.map((x) => OrderItem.fromJson(x))),
//     user: json["user"] == null ? null : User.fromJson(json["user"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "user_id": userId,
//     "payment_id": paymentId,
//     "cart_id": cartId,
//     "order_number": orderNumber,
//     "total_amount": totalAmount,
//     "currency": currencyValues.reverse[currency],
//     "status": datumStatusValues.reverse[status],
//     "shipping_address": shippingAddress?.toJson(),
//     "notes": notes,
//     "ordered_at": orderedAt?.toIso8601String(),
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "deleted_at": deletedAt,
//     "product_type": typeValues.reverse[productType],
//     "tax_amount": taxAmount,
//     "shipping_amount": shippingAmount,
//     "platform_fee": platformFee,
//     "seller_amount": sellerAmount,
//     "company_name": companyName,
//     "tracking_number": trackingNumber,
//     "order_items": orderItems == null ? [] : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
//     "user": user?.toJson(),
//   };
// }
//
// enum Currency {
//   USD
// }
//
// final currencyValues = EnumValues({
//   "USD": Currency.USD
// });
//
// class OrderItem {
//   int? id;
//   int? orderId;
//   int? productId;
//   dynamic productBidId;
//   int? quantity;
//   String? unitPrice;
//   String? subtotal;
//   List<dynamic>? attributes;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   dynamic deletedAt;
//   Product? product;
//
//   OrderItem({
//     this.id,
//     this.orderId,
//     this.productId,
//     this.productBidId,
//     this.quantity,
//     this.unitPrice,
//     this.subtotal,
//     this.attributes,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.product,
//   });
//
//   factory OrderItem.fromRawJson(String str) => OrderItem.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
//     id: json["id"],
//     orderId: json["order_id"],
//     productId: json["product_id"],
//     productBidId: json["product_bid_id"],
//     quantity: json["quantity"],
//     unitPrice: json["unit_price"],
//     subtotal: json["subtotal"],
//     attributes: json["attributes"] == null ? [] : List<dynamic>.from(json["attributes"]!.map((x) => x)),
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//     product: json["product"] == null ? null : Product.fromJson(json["product"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "order_id": orderId,
//     "product_id": productId,
//     "product_bid_id": productBidId,
//     "quantity": quantity,
//     "unit_price": unitPrice,
//     "subtotal": subtotal,
//     "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x)),
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "deleted_at": deletedAt,
//     "product": product?.toJson(),
//   };
// }
//
// class Product {
//   int? id;
//   String? title;
//   String? slug;
//   List<String>? images;
//   String? description;
//   int? userId;
//   int? categoryId;
//   int? subCategoryId;
//   int? stock;
//   Type? type;
//   int? bid;
//   String? shippingCost;
//   int? shipWithin;
//   int? price;
//   int? startingPrice;
//   DateTime? auctionEndAt;
//   int? winnerId;
//   ProductStatus? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   dynamic deletedAt;
//
//   Product({
//     this.id,
//     this.title,
//     this.slug,
//     this.images,
//     this.description,
//     this.userId,
//     this.categoryId,
//     this.subCategoryId,
//     this.stock,
//     this.type,
//     this.bid,
//     this.shippingCost,
//     this.shipWithin,
//     this.price,
//     this.startingPrice,
//     this.auctionEndAt,
//     this.winnerId,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });
//
//   factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     title: json["title"],
//     slug: json["slug"],
//     images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
//     description: json["description"],
//     userId: json["user_id"],
//     categoryId: json["category_id"],
//     subCategoryId: json["sub_category_id"],
//     stock: json["stock"],
//     type: typeValues.map[json["type"]]!,
//     bid: json["bid"],
//     shippingCost: json["shipping_cost"],
//     shipWithin: json["ship_within"],
//     price: json["price"],
//     startingPrice: json["starting_price"],
//     auctionEndAt: json["auction_end_at"] == null ? null : DateTime.parse(json["auction_end_at"]),
//     winnerId: json["winner_id"],
//     status: productStatusValues.map[json["status"]]!,
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "slug": slug,
//     "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
//     "description": description,
//     "user_id": userId,
//     "category_id": categoryId,
//     "sub_category_id": subCategoryId,
//     "stock": stock,
//     "type": typeValues.reverse[type],
//     "bid": bid,
//     "shipping_cost": shippingCost,
//     "ship_within": shipWithin,
//     "price": price,
//     "starting_price": startingPrice,
//     "auction_end_at": auctionEndAt?.toIso8601String(),
//     "winner_id": winnerId,
//     "status": productStatusValues.reverse[status],
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "deleted_at": deletedAt,
//   };
// }
//
// enum ProductStatus {
//   ACTIVE
// }
//
// final productStatusValues = EnumValues({
//   "active": ProductStatus.ACTIVE
// });
//
// enum Type {
//   AUCTION,
//   SALE
// }
//
// final typeValues = EnumValues({
//   "auction": Type.AUCTION,
//   "sale": Type.SALE
// });
//
// class ShippingAddress {
//   String? street;
//   String? city;
//   String? country;
//   String? postalCode;
//
//   ShippingAddress({
//     this.street,
//     this.city,
//     this.country,
//     this.postalCode,
//   });
//
//   factory ShippingAddress.fromRawJson(String str) => ShippingAddress.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
//     street: json["street"],
//     city: json["city"],
//     country: json["country"],
//     postalCode: json["postal_code"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "street": street,
//     "city": city,
//     "country": country,
//     "postal_code": postalCode,
//   };
// }
//
// enum DatumStatus {
//   CONFIRMED,
//   PENDING
// }
//
// final datumStatusValues = EnumValues({
//   "confirmed": DatumStatus.CONFIRMED,
//   "pending": DatumStatus.PENDING
// });
//
// class User {
//   int? id;
//   Name? name;
//   Email? email;
//   Avatar? avatar;
//   DateTime? emailVerifiedAt;
//   StripeAccountId? stripeAccountId;
//   int? onboardComplete;
//   dynamic country;
//   City? city;
//   State? state;
//   Address? address;
//   String? phone;
//   bool? isBanned;
//   String? zipCode;
//   dynamic deletedAt;
//   bool? cardAttributes;
//
//   User({
//     this.id,
//     this.name,
//     this.email,
//     this.avatar,
//     this.emailVerifiedAt,
//     this.stripeAccountId,
//     this.onboardComplete,
//     this.country,
//     this.city,
//     this.state,
//     this.address,
//     this.phone,
//     this.isBanned,
//     this.zipCode,
//     this.deletedAt,
//     this.cardAttributes,
//   });
//
//   factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//     id: json["id"],
//     name: nameValues.map[json["name"]]!,
//     email: emailValues.map[json["email"]]!,
//     avatar: avatarValues.map[json["avatar"]]!,
//     emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
//     stripeAccountId: stripeAccountIdValues.map[json["stripe_account_id"]]!,
//     onboardComplete: json["onboard_complete"],
//     country: json["country"],
//     city: cityValues.map[json["city"]]!,
//     state: stateValues.map[json["state"]]!,
//     address: addressValues.map[json["address"]]!,
//     phone: json["phone"],
//     isBanned: json["is_banned"],
//     zipCode: json["zip_code"],
//     deletedAt: json["deleted_at"],
//     cardAttributes: json["card_attributes"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": nameValues.reverse[name],
//     "email": emailValues.reverse[email],
//     "avatar": avatarValues.reverse[avatar],
//     "email_verified_at": emailVerifiedAt?.toIso8601String(),
//     "stripe_account_id": stripeAccountIdValues.reverse[stripeAccountId],
//     "onboard_complete": onboardComplete,
//     "country": country,
//     "city": cityValues.reverse[city],
//     "state": stateValues.reverse[state],
//     "address": addressValues.reverse[address],
//     "phone": phone,
//     "is_banned": isBanned,
//     "zip_code": zipCode,
//     "deleted_at": deletedAt,
//     "card_attributes": cardAttributes,
//   };
// }
//
// enum Address {
//   MOOHAKHALI_425_KF
// }
//
// final addressValues = EnumValues({
//   "Moohakhali 425, kf": Address.MOOHAKHALI_425_KF
// });
//
// enum Avatar {
//   UPLOADS_USERS_SELLER_1753350714_PNG
// }
//
// final avatarValues = EnumValues({
//   "uploads/users/seller-1753350714.png": Avatar.UPLOADS_USERS_SELLER_1753350714_PNG
// });
//
// enum City {
//   NEW_YORK
// }
//
// final cityValues = EnumValues({
//   "New york": City.NEW_YORK
// });
//
// enum Email {
//   SELLER_SELLER_COM
// }
//
// final emailValues = EnumValues({
//   "seller@seller.com": Email.SELLER_SELLER_COM
// });
//
// enum Name {
//   DAVID
// }
//
// final nameValues = EnumValues({
//   "David": Name.DAVID
// });
//
// enum State {
//   COLORADO
// }
//
// final stateValues = EnumValues({
//   "colorado": State.COLORADO
// });
//
// enum StripeAccountId {
//   ACCT_1_RNTS9_PLY_WRUC_JA_T
// }
//
// final stripeAccountIdValues = EnumValues({
//   "acct_1Rnts9PlyWRUCJaT": StripeAccountId.ACCT_1_RNTS9_PLY_WRUC_JA_T
// });
//
// class Link {
//   String? url;
//   String? label;
//   bool? active;
//
//   Link({
//     this.url,
//     this.label,
//     this.active,
//   });
//
//   factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//     url: json["url"],
//     label: json["label"],
//     active: json["active"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "url": url,
//     "label": label,
//     "active": active,
//   };
// }
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

















import 'dart:convert';

class BuyingOrderDataModel {
  bool? success;
  String? message;
  BuyingOrderData? data;
  dynamic code;

  BuyingOrderDataModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory BuyingOrderDataModel.fromRawJson(String str) => BuyingOrderDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BuyingOrderDataModel.fromJson(Map<String, dynamic> json) => BuyingOrderDataModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : BuyingOrderData.fromJson(json["data"]),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "code": code,
  };
}

class BuyingOrderData {
  dynamic currentPage;
  List<BuyingOrderDatum>? data;
  String? firstPageUrl;
  dynamic from;
  dynamic lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;

  BuyingOrderData({
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

  factory BuyingOrderData.fromRawJson(String str) => BuyingOrderData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BuyingOrderData.fromJson(Map<String, dynamic> json) => BuyingOrderData(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<BuyingOrderDatum>.from(json["data"]!.map((x) => BuyingOrderDatum.fromJson(x))),
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

class BuyingOrderDatum {
  dynamic id;
  dynamic userId;
  dynamic paymentId;
  dynamic cartId;
  String? orderNumber;
  String? totalAmount;
  Currency? currency;
  DatumStatus? status;
  ShippingAddress? shippingAddress;
  String? notes;
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
  List<OrderItem>? orderItems;
  User? user;

  BuyingOrderDatum({
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
    this.orderItems,
    this.user,
  });

  factory BuyingOrderDatum.fromRawJson(String str) => BuyingOrderDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BuyingOrderDatum.fromJson(Map<String, dynamic> json) => BuyingOrderDatum(
    id: json["id"],
    userId: json["user_id"],
    paymentId: json["payment_id"],
    cartId: json["cart_id"],
    orderNumber: json["order_number"],
    totalAmount: json["total_amount"],
    currency: json["currency"] != null && currencyValues.map.containsKey(json["currency"])
        ? currencyValues.map[json["currency"]]
        : null,
    status: json["status"] != null && datumStatusValues.map.containsKey(json["status"])
        ? datumStatusValues.map[json["status"]]
        : null,
    shippingAddress: json["shipping_address"] == null ? null : ShippingAddress.fromJson(json["shipping_address"]),
    notes: json["notes"],
    orderedAt: json["ordered_at"] == null ? null : DateTime.parse(json["ordered_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    productType: json["product_type"] != null && typeValues.map.containsKey(json["product_type"])
        ? typeValues.map[json["product_type"]]
        : null,
    taxAmount: json["tax_amount"],
    shippingAmount: json["shipping_amount"],
    platformFee: json["platform_fee"],
    sellerAmount: json["seller_amount"],
    companyName: json["company_name"],
    trackingNumber: json["tracking_number"],
    orderItems: json["order_items"] == null ? [] : List<OrderItem>.from(json["order_items"]!.map((x) => OrderItem.fromJson(x))),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
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
    "shipping_address": shippingAddress?.toJson(),
    "notes": notes,
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
    "order_items": orderItems == null ? [] : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
    "user": user?.toJson(),
  };
}

enum Currency {
  USD
}

final currencyValues = EnumValues({
  "USD": Currency.USD
});

class OrderItem {
  dynamic id;
  dynamic orderId;
  dynamic productId;
  dynamic productBidId;
  dynamic quantity;
  String? unitPrice;
  String? subtotal;
  List<dynamic>? attributes;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Product? product;

  OrderItem({
    this.id,
    this.orderId,
    this.productId,
    this.productBidId,
    this.quantity,
    this.unitPrice,
    this.subtotal,
    this.attributes,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.product,
  });

  factory OrderItem.fromRawJson(String str) => OrderItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    productBidId: json["product_bid_id"],
    quantity: json["quantity"],
    unitPrice: json["unit_price"],
    subtotal: json["subtotal"],
    attributes: json["attributes"] == null ? [] : List<dynamic>.from(json["attributes"]!.map((x) => x)),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "product_bid_id": productBidId,
    "quantity": quantity,
    "unit_price": unitPrice,
    "subtotal": subtotal,
    "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x)),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "product": product?.toJson(),
  };
}

class Product {
  dynamic id;
  String? title;
  String? slug;
  List<String>? images;
  String? description;
  dynamic userId;
  dynamic categoryId;
  dynamic subCategoryId;
  dynamic stock;
  Type? type;
  dynamic bid;
  String? shippingCost;
  dynamic shipWithin;
  dynamic price;
  dynamic startingPrice;
  DateTime? auctionEndAt;
  dynamic winnerId;
  ProductStatus? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Product({
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
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    description: json["description"],
    userId: json["user_id"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    stock: json["stock"],
    type: json["type"] != null && typeValues.map.containsKey(json["type"])
        ? typeValues.map[json["type"]]
        : null,
    bid: json["bid"],
    shippingCost: json["shipping_cost"],
    shipWithin: json["ship_within"],
    price: json["price"],
    startingPrice: json["starting_price"],
    auctionEndAt: json["auction_end_at"] == null ? null : DateTime.parse(json["auction_end_at"]),
    winnerId: json["winner_id"],
    status: json["status"] != null && productStatusValues.map.containsKey(json["status"])
        ? productStatusValues.map[json["status"]]
        : null,
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
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
  };
}

enum ProductStatus {
  ACTIVE
}

final productStatusValues = EnumValues({
  "active": ProductStatus.ACTIVE
});

enum Type {
  AUCTION,
  SALE
}

final typeValues = EnumValues({
  "auction": Type.AUCTION,
  "sale": Type.SALE
});

class ShippingAddress {
  String? street;
  String? city;
  String? country;
  String? postalCode;

  ShippingAddress({
    this.street,
    this.city,
    this.country,
    this.postalCode,
  });

  factory ShippingAddress.fromRawJson(String str) => ShippingAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
    street: json["street"],
    city: json["city"],
    country: json["country"],
    postalCode: json["postal_code"],
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "city": city,
    "country": country,
    "postal_code": postalCode,
  };
}

enum DatumStatus {
  CONFIRMED,
  PENDING,COMPLETED,SHIPPING, confirmed, completed
}

final datumStatusValues = EnumValues({
  "confirmed": DatumStatus.CONFIRMED,
  "completed": DatumStatus.COMPLETED,
  "shipping": DatumStatus.SHIPPING,
});

class User {
  dynamic id;
  Name? name;
  Email? email;
  Avatar? avatar;
  DateTime? emailVerifiedAt;
  StripeAccountId? stripeAccountId;
  dynamic onboardComplete;
  dynamic country;
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
    name: json["name"] != null && nameValues.map.containsKey(json["name"])
        ? nameValues.map[json["name"]]
        : null,
    email: json["email"] != null && emailValues.map.containsKey(json["email"])
        ? emailValues.map[json["email"]]
        : null,
    avatar: json["avatar"] != null && avatarValues.map.containsKey(json["avatar"])
        ? avatarValues.map[json["avatar"]]
        : null,
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    stripeAccountId: json["stripe_account_id"] != null && stripeAccountIdValues.map.containsKey(json["stripe_account_id"])
        ? stripeAccountIdValues.map[json["stripe_account_id"]]
        : null,
    onboardComplete: json["onboard_complete"],
    country: json["country"],
    city: json["city"] != null && cityValues.map.containsKey(json["city"])
        ? cityValues.map[json["city"]]
        : null,
    state: json["state"] != null && stateValues.map.containsKey(json["state"])
        ? stateValues.map[json["state"]]
        : null,
    address: json["address"] != null && addressValues.map.containsKey(json["address"])
        ? addressValues.map[json["address"]]
        : null,
    phone: json["phone"],
    isBanned: json["is_banned"],
    zipCode: json["zip_code"],
    deletedAt: json["deleted_at"],
    cardAttributes: json["card_attributes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "email": emailValues.reverse[email],
    "avatar": avatarValues.reverse[avatar],
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "stripe_account_id": stripeAccountIdValues.reverse[stripeAccountId],
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
  MOOHAKHALI_425_KF
}

final addressValues = EnumValues({
  "Moohakhali 425, kf": Address.MOOHAKHALI_425_KF
});

enum Avatar {
  UPLOADS_USERS_SELLER_1753350714_PNG
}

final avatarValues = EnumValues({
  "uploads/users/seller-1753350714.png": Avatar.UPLOADS_USERS_SELLER_1753350714_PNG
});

enum City {
  NEW_YORK
}

final cityValues = EnumValues({
  "New york": City.NEW_YORK
});

enum Email {
  SELLER_SELLER_COM
}

final emailValues = EnumValues({
  "seller@seller.com": Email.SELLER_SELLER_COM
});

enum Name {
  DAVID
}

final nameValues = EnumValues({
  "David": Name.DAVID
});

enum State {
  COLORADO
}

final stateValues = EnumValues({
  "colorado": State.COLORADO
});

enum StripeAccountId {
  ACCT_1_RNTS9_PLY_WRUC_JA_T
}

final stripeAccountIdValues = EnumValues({
  "acct_1Rnts9PlyWRUCJaT": StripeAccountId.ACCT_1_RNTS9_PLY_WRUC_JA_T
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