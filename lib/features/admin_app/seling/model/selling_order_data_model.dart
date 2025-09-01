// import 'dart:convert';
//
// class SellingOrderDataModel {
//   bool? success;
//   String? message;
//   Data? data;
//   int? code;
//
//   SellingOrderDataModel({
//     this.success,
//     this.message,
//     this.data,
//     this.code,
//   });
//
//   factory SellingOrderDataModel.fromRawJson(String str) =>
//       SellingOrderDataModel.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory SellingOrderDataModel.fromJson(Map<String, dynamic> json) =>
//       SellingOrderDataModel(
//         success: json["success"] as bool?,
//         message: json["message"] as String?,
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//         code: json["code"] as int?,
//       );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "message": message,
//     "data": data?.toJson(),
//     "code": code,
//   };
// }
//
// class Data {
//   int? currentPage;
//   List<SellerOrderDatum>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   List<Link>? links;
//   String? nextPageUrl;
//   String? path;
//   int? perPage;
//   dynamic prevPageUrl;
//   int? to;
//   int? total;
//
//   Data({
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
//   factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     currentPage: json["current_page"] as int?,
//     data: json["data"] == null
//         ? []
//         : List<SellerOrderDatum>.from(
//         json["data"]!.map((x) => SellerOrderDatum.fromJson(x))),
//     firstPageUrl: json["first_page_url"] as String?,
//     from: json["from"] as int?,
//     lastPage: json["last_page"] as int?,
//     lastPageUrl: json["last_page_url"] as String?,
//     links: json["links"] == null
//         ? []
//         : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
//     nextPageUrl: json["next_page_url"] as String?,
//     path: json["path"] as String?,
//     perPage: json["per_page"] as int?,
//     prevPageUrl: json["prev_page_url"],
//     to: json["to"] as int?,
//     total: json["total"] as int?,
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
// class SellerOrderDatum {
//   int? id;
//   int? userId;
//   int? paymentId;
//   int? cartId;
//   String? orderNumber;
//   String? totalAmount;
//   Currency? currency;
//   DatumStatus? status;
//   ShippingAddress? shippingAddress;
//   Notes? notes;
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
//   SellerOrderDatum({
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
//   factory SellerOrderDatum.fromRawJson(String str) =>
//       SellerOrderDatum.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory SellerOrderDatum.fromJson(Map<String, dynamic> json) => SellerOrderDatum(
//     id: json["id"] as int?,
//     userId: json["user_id"] as int?,
//     paymentId: json["payment_id"] as int?,
//     cartId: json["cart_id"] as int?,
//     orderNumber: json["order_number"] as String?,
//     totalAmount: json["total_amount"] as String?,
//     currency: json["currency"] != null ? currencyValues.map[json["currency"]] : null,
//     status: json["status"] != null ? datumStatusValues.map[json["status"]] : null,
//     shippingAddress: json["shipping_address"] == null
//         ? null
//         : ShippingAddress.fromJson(json["shipping_address"]),
//     notes: json["notes"] != null ? notesValues.map[json["notes"]] : null,
//     orderedAt: json["ordered_at"] == null
//         ? null
//         : DateTime.parse(json["ordered_at"]),
//     createdAt: json["created_at"] == null
//         ? null
//         : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null
//         ? null
//         : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//     productType: json["product_type"] != null ? typeValues.map[json["product_type"]] : null,
//     taxAmount: json["tax_amount"] as String?,
//     shippingAmount: json["shipping_amount"] as String?,
//     platformFee: json["platform_fee"] as String?,
//     sellerAmount: json["seller_amount"] as String?,
//     companyName: json["company_name"] as String?,
//     trackingNumber: json["tracking_number"] as String?,
//     orderItems: json["order_items"] == null
//         ? []
//         : List<OrderItem>.from(json["order_items"]!.map((x) => OrderItem.fromJson(x))),
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
//     "notes": notesValues.reverse[notes],
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
//     "order_items": orderItems == null
//         ? []
//         : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
//     "user": user?.toJson(),
//   };
// }
//
// enum Currency { USD }
//
// final currencyValues = EnumValues({
//   "USD": Currency.USD,
// });
//
// enum Notes {
//   AUCTION_PAYMENT_FOR_BID_ID_127,
//   AUCTION_PAYMENT_FOR_BID_ID_89,
//   STANDARD_SALE_ORDER,
// }
//
// final notesValues = EnumValues({
//   "Auction payment for Bid ID: 127": Notes.AUCTION_PAYMENT_FOR_BID_ID_127,
//   "Auction payment for Bid ID: 89": Notes.AUCTION_PAYMENT_FOR_BID_ID_89,
//   "Standard sale order": Notes.STANDARD_SALE_ORDER,
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
//     id: json["id"] as int?,
//     orderId: json["order_id"] as int?,
//     productId: json["product_id"] as int?,
//     productBidId: json["product_bid_id"],
//     quantity: json["quantity"] as int?,
//     unitPrice: json["unit_price"] as String?,
//     subtotal: json["subtotal"] as String?,
//     attributes: json["attributes"] == null
//         ? []
//         : List<dynamic>.from(json["attributes"]!.map((x) => x)),
//     createdAt: json["created_at"] == null
//         ? null
//         : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null
//         ? null
//         : DateTime.parse(json["updated_at"]),
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
//     "attributes": attributes == null
//         ? []
//         : List<dynamic>.from(attributes!.map((x) => x)),
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
//     id: json["id"] as int?,
//     title: json["title"] as String?,
//     slug: json["slug"] as String?,
//     images: json["images"] == null
//         ? []
//         : List<String>.from(json["images"]!.map((x) => x)),
//     description: json["description"] as String?,
//     userId: json["user_id"] as int?,
//     categoryId: json["category_id"] as int?,
//     subCategoryId: json["sub_category_id"] as int?,
//     stock: json["stock"] as int?,
//     type: json["type"] != null ? typeValues.map[json["type"]] : null,
//     bid: json["bid"] as int?,
//     shippingCost: json["shipping_cost"] as String?,
//     shipWithin: json["ship_within"] as int?,
//     price: json["price"] as int?,
//     startingPrice: json["starting_price"] as int?,
//     auctionEndAt: json["auction_end_at"] == null
//         ? null
//         : DateTime.parse(json["auction_end_at"]),
//     winnerId: json["winner_id"] as int?,
//     status: json["status"] != null ? productStatusValues.map[json["status"]] : null,
//     createdAt: json["created_at"] == null
//         ? null
//         : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null
//         ? null
//         : DateTime.parse(json["updated_at"]),
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
// enum ProductStatus { ACTIVE }
//
// final productStatusValues = EnumValues({
//   "active": ProductStatus.ACTIVE,
// });
//
// enum Type { AUCTION, SALE }
//
// final typeValues = EnumValues({
//   "auction": Type.AUCTION,
//   "sale": Type.SALE,
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
//   factory ShippingAddress.fromRawJson(String str) =>
//       ShippingAddress.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
//     street: json["street"] as String?,
//     city: json["city"] as String?,
//     country: json["country"] as String?,
//     postalCode: json["postal_code"] as String?,
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
// enum DatumStatus { CONFIRMED, PENDING }
//
// final datumStatusValues = EnumValues({
//   "confirmed": DatumStatus.CONFIRMED,
//   "pending": DatumStatus.PENDING,
// });
//
// class User {
//   int? id;
//   Name? name;
//   Email? email;
//   String? avatar;
//   DateTime? emailVerifiedAt;
//   String? stripeAccountId;
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
//     id: json["id"] as int?,
//     name: json["name"] != null ? nameValues.map[json["name"]] : null,
//     email: json["email"] != null ? emailValues.map[json["email"]] : null,
//     avatar: json["avatar"] as String?,
//     emailVerifiedAt: json["email_verified_at"] == null
//         ? null
//         : DateTime.parse(json["email_verified_at"]),
//     stripeAccountId: json["stripe_account_id"] as String?,
//     onboardComplete: json["onboard_complete"] as int?,
//     country: json["country"],
//     city: json["city"] != null ? cityValues.map[json["city"]] : null,
//     state: json["state"] != null ? stateValues.map[json["state"]] : null,
//     address: json["address"] != null ? addressValues.map[json["address"]] : null,
//     phone: json["phone"] as String?,
//     isBanned: json["is_banned"] as bool?,
//     zipCode: json["zip_code"] as String?,
//     deletedAt: json["deleted_at"],
//     cardAttributes: json["card_attributes"] as bool?,
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": nameValues.reverse[name],
//     "email": emailValues.reverse[email],
//     "avatar": avatar,
//     "email_verified_at": emailVerifiedAt?.toIso8601String(),
//     "stripe_account_id": stripeAccountId,
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
//   DHAKA_GULSHAN_1212,
//   MOOHAKHALI_425_KF,
//   THE_25_D_ADDRESS,
// }
//
// final addressValues = EnumValues({
//   "Dhaka,gulshan-1212": Address.DHAKA_GULSHAN_1212,
//   "Moohakhali 425, kf": Address.MOOHAKHALI_425_KF,
//   "25D address": Address.THE_25_D_ADDRESS,
// });
//
// enum City { CITY, DHAKA, NEW_YORK }
//
// final cityValues = EnumValues({
//   "city": City.CITY,
//   "Dhaka": City.DHAKA,
//   "New york": City.NEW_YORK,
// });
//
// enum Email {
//   BUYER_BUYER_COM,
//   HATON45611_EFPAPER_COM,
//   SELLER_SELLER_COM,
// }
//
// final emailValues = EnumValues({
//   "buyer@buyer.com": Email.BUYER_BUYER_COM,
//   "haton45611@efpaper.com": Email.HATON45611_EFPAPER_COM,
//   "seller@seller.com": Email.SELLER_SELLER_COM,
// });
//
// enum Name { BUYER, DAVID, PIKU }
//
// final nameValues = EnumValues({
//   "Buyer": Name.BUYER,
//   "David": Name.DAVID,
//   "Piku": Name.PIKU,
// });
//
// enum State { ALABAMA, COLORADO, CONNECTICUT }
//
// final stateValues = EnumValues({
//   "alabama": State.ALABAMA,
//   "colorado": State.COLORADO,
//   "connecticut": State.CONNECTICUT,
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
//     url: json["url"] as String?,
//     label: json["label"] as String?,
//     active: json["active"] as bool?,
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

class SellingOrderDataModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  SellingOrderDataModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory SellingOrderDataModel.fromRawJson(String str) =>
      SellingOrderDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SellingOrderDataModel.fromJson(Map<String, dynamic> json) =>
      SellingOrderDataModel(
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

class Data {
  int? currentPage;
  List<SellerOrderDatum>? data;
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
        : List<SellerOrderDatum>.from(
        json["data"]!.map((x) => SellerOrderDatum.fromJson(x))),
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
    "data":
    data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links":
    links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class SellerOrderDatum {
  int? id;
  int? userId;
  int? paymentId;
  int? cartId;
  String? orderNumber;
  String? totalAmount;
  Currency? currency;
  DatumStatus? status;
  ShippingAddress? shippingAddress;
  String? notes; // Changed from Notes enum to String?
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

  SellerOrderDatum({
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

  factory SellerOrderDatum.fromRawJson(String str) =>
      SellerOrderDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SellerOrderDatum.fromJson(Map<String, dynamic> json) => SellerOrderDatum(
    id: json["id"] as int?,
    userId: json["user_id"] as int?,
    paymentId: json["payment_id"] as int?,
    cartId: json["cart_id"] as int?,
    orderNumber: json["order_number"] as String?,
    totalAmount: json["total_amount"] as String?,
    currency: json["currency"] != null ? currencyValues.map[json["currency"]] : null,
    status: json["status"] != null ? datumStatusValues.map[json["status"]] : null,
    shippingAddress: json["shipping_address"] == null
        ? null
        : ShippingAddress.fromJson(json["shipping_address"]),
    notes: json["notes"] as String?, // Changed to String?
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
    productType: json["product_type"] != null ? typeValues.map[json["product_type"]] : null,
    taxAmount: json["tax_amount"] as String?,
    shippingAmount: json["shipping_amount"] as String?,
    platformFee: json["platform_fee"] as String?,
    sellerAmount: json["seller_amount"] as String?,
    companyName: json["company_name"] as String?,
    trackingNumber: json["tracking_number"] as String?,
    orderItems: json["order_items"] == null
        ? []
        : List<OrderItem>.from(json["order_items"]!.map((x) => OrderItem.fromJson(x))),
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
    "notes": notes, // Changed to String?
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
    "order_items": orderItems == null
        ? []
        : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
    "user": user?.toJson(),
  };
}

enum Currency { USD }

final currencyValues = EnumValues({
  "USD": Currency.USD,
});

enum DatumStatus { CONFIRMED, COMPLETED,SHIPPING } // Added COMPLETED

final datumStatusValues = EnumValues({
  "confirmed": DatumStatus.CONFIRMED,
  "completed": DatumStatus.COMPLETED,
  "shipping": DatumStatus.SHIPPING,
});

class OrderItem {
  int? id;
  int? orderId;
  int? productId;
  dynamic productBidId;
  int? quantity;
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
    id: json["id"] as int?,
    orderId: json["order_id"] as int?,
    productId: json["product_id"] as int?,
    productBidId: json["product_bid_id"],
    quantity: json["quantity"] as int?,
    unitPrice: json["unit_price"] as String?,
    subtotal: json["subtotal"] as String?,
    attributes: json["attributes"] == null
        ? []
        : List<dynamic>.from(json["attributes"]!.map((x) => x)),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
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
    "attributes": attributes == null
        ? []
        : List<dynamic>.from(attributes!.map((x) => x)),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "product": product?.toJson(),
  };
}

class Product {
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
  int? price;
  int? startingPrice;
  DateTime? auctionEndAt;
  int? winnerId;
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
    id: json["id"] as int?,
    title: json["title"] as String?,
    slug: json["slug"] as String?,
    images: json["images"] == null
        ? []
        : List<String>.from(json["images"]!.map((x) => x)),
    description: json["description"] as String?,
    userId: json["user_id"] as int?,
    categoryId: json["category_id"] as int?,
    subCategoryId: json["sub_category_id"] as int?,
    stock: json["stock"] as int?,
    type: json["type"] != null ? typeValues.map[json["type"]] : null,
    bid: json["bid"] as int?,
    shippingCost: json["shipping_cost"] as String?,
    shipWithin: json["ship_within"] as int?,
    price: json["price"] as int?,
    startingPrice: json["starting_price"] as int?,
    auctionEndAt: json["auction_end_at"] == null
        ? null
        : DateTime.parse(json["auction_end_at"]),
    winnerId: json["winner_id"] as int?,
    status: json["status"] != null ? productStatusValues.map[json["status"]] : null,
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
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

enum ProductStatus { ACTIVE, INACTIVE } // Added INACTIVE

final productStatusValues = EnumValues({
  "active": ProductStatus.ACTIVE,
  "inactive": ProductStatus.INACTIVE,
});

enum Type { AUCTION, SALE }

final typeValues = EnumValues({
  "auction": Type.AUCTION,
  "sale": Type.SALE,
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

  factory ShippingAddress.fromRawJson(String str) =>
      ShippingAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
    street: json["street"] as String?,
    city: json["city"] as String?,
    country: json["country"] as String?,
    postalCode: json["postal_code"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "city": city,
    "country": country,
    "postal_code": postalCode,
  };
}

class User {
  int? id;
  String? name; // Changed from Name enum to String?
  String? email; // Changed from Email enum to String?
  String? avatar;
  DateTime? emailVerifiedAt;
  String? stripeAccountId;
  int? onboardComplete;
  String? country; // Changed to String? for consistency
  String? city; // Changed from City enum to String?
  String? state; // Changed from State enum to String?
  String? address; // Changed from Address enum to String?
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
    name: json["name"] as String?, // Changed to String?
    email: json["email"] as String?, // Changed to String?
    avatar: json["avatar"] as String?,
    emailVerifiedAt: json["email_verified_at"] == null
        ? null
        : DateTime.parse(json["email_verified_at"]),
    stripeAccountId: json["stripe_account_id"] as String?,
    onboardComplete: json["onboard_complete"] as int?,
    country: json["country"] as String?, // Changed to String?
    city: json["city"] as String?, // Changed to String?
    state: json["state"] as String?, // Changed to String?
    address: json["address"] as String?, // Changed to String?
    phone: json["phone"] as String?,
    isBanned: json["is_banned"] as bool?,
    zipCode: json["zip_code"] as String?,
    deletedAt: json["deleted_at"],
    cardAttributes: json["card_attributes"] as bool?,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name, // Changed to String?
    "email": email, // Changed to String?
    "avatar": avatar,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "stripe_account_id": stripeAccountId,
    "onboard_complete": onboardComplete,
    "country": country,
    "city": city, // Changed to String?
    "state": state, // Changed to String?
    "address": address, // Changed to String?
    "phone": phone,
    "is_banned": isBanned,
    "zip_code": zipCode,
    "deleted_at": deletedAt,
    "card_attributes": cardAttributes,
  };
}

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}