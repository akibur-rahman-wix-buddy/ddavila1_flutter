// import 'dart:convert';
//
// class AllProductDataModel {
//   bool? success;
//   String? message;
//   ProductData? data;
//   int? code;
//
//   AllProductDataModel({this.success, this.message, this.data, this.code});
//
//   AllProductDataModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     data = json['data'] != null ? ProductData.fromJson(json['data']) : null;
//     code = json['code'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['success'] = success;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['code'] = code;
//     return data;
//   }
// }
//
// class ProductData {
//   List<AllProductData> data;
//
//   ProductData({required this.data});
//
//   ProductData.fromJson(Map<String, dynamic> json) : data = [] {
//     if (json['data'] != null) {
//       data = (json['data'] as List).map((v) => AllProductData.fromJson(v)).toList();
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'data': data.map((v) => v.toJson()).toList()};
//   }
// }
//
// class AllProductData {
//   int? id;
//   String? title;
//   String? slug;
//   List<String>? images;
//   String? description;
//   int? userId;
//   int? categoryId;
//   int? subCategoryId;
//   int? stock;
//   String? type;
//   int? bid;
//   String? shippingCost;
//   int? shipWithin;
//   int? price;
//   int? startingPrice;
//   String? auctionEndAt;
//   int? winnerId;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   dynamic deletedAt;
//   Category? category;
//   Category? subcategory;
//   bool? bookmark;
//
//   AllProductData({
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
//     this.category,
//     this.subcategory,
//     this.bookmark,
//   });
//
//   AllProductData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     slug = json['slug'];
//     images = json['images']?.cast<String>();
//     description = json['description'];
//     userId = json['user_id'];
//     categoryId = json['category_id'];
//     subCategoryId = json['sub_category_id'];
//     stock = json['stock'];
//     type = json['type'];
//     bid = json['bid'];
//     shippingCost = json['shipping_cost'];
//     shipWithin = json['ship_within'];
//     price = json['price'];
//     startingPrice = json['starting_price'];
//     auctionEndAt = json['auction_end_at'];
//     winnerId = json['winner_id'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'];
//     category = json['category'] != null ? Category.fromJson(json['category']) : null;
//     subcategory = json['subcategory'] != null ? Category.fromJson(json['subcategory']) : null;
//     bookmark = json['bookmark'] ?? false;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     data['slug'] = slug;
//     data['images'] = images;
//     data['description'] = description;
//     data['user_id'] = userId;
//     data['category_id'] = categoryId;
//     data['sub_category_id'] = subCategoryId;
//     data['stock'] = stock;
//     data['type'] = type;
//     data['bid'] = bid;
//     data['shipping_cost'] = shippingCost;
//     data['ship_within'] = shipWithin;
//     data['price'] = price;
//     data['starting_price'] = startingPrice;
//     data['auction_end_at'] = auctionEndAt;
//     data['winner_id'] = winnerId;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['deleted_at'] = deletedAt;
//     if (category != null) {
//       data['category'] = category!.toJson();
//     }
//     if (subcategory != null) {
//       data['subcategory'] = subcategory!.toJson();
//     }
//     data['bookmark'] = bookmark;
//     return data;
//   }
// }
//
// class Category {
//   int? id;
//   String? title;
//
//   Category({this.id, this.title});
//
//   Category.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     return data;
//   }
// }







import 'dart:convert';

class AllProductDataModel {
  bool? success;
  String? message;
  ProductData? data;
  int? code;

  AllProductDataModel({this.success, this.message, this.data, this.code});

  AllProductDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'] is List) {
        // Handle case where data is a List<dynamic>
        data = ProductData(
          data: (json['data'] as List).map((v) => AllProductData.fromJson(v)).toList(),
        );
      } else {
        // Handle case where data is a Map with nested data
        data = ProductData.fromJson(json['data']);
      }
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = code;
    return data;
  }
}

class ProductData {
  List<AllProductData> data;

  ProductData({required this.data});

  ProductData.fromJson(Map<String, dynamic> json) : data = [] {
    if (json['data'] != null) {
      data = (json['data'] as List).map((v) => AllProductData.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {'data': data.map((v) => v.toJson()).toList()};
  }
}

class AllProductData {
  int? id;
  String? title;
  String? slug;
  List<String>? images;
  String? description;
  int? userId;
  int? categoryId;
  int? subCategoryId;
  int? stock;
  String? type;
  int? bid;
  String? shippingCost;
  int? shipWithin;
  int? price;
  int? startingPrice;
  String? auctionEndAt;
  int? winnerId;
  String? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Category? category;
  Category? subcategory;
  bool? bookmark;

  AllProductData({
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
    this.category,
    this.subcategory,
    this.bookmark,
  });

  AllProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    images = json['images']?.cast<String>();
    description = json['description'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    stock = json['stock'];
    type = json['type'];
    bid = json['bid'];
    shippingCost = json['shipping_cost'];
    shipWithin = json['ship_within'];
    price = json['price'];
    startingPrice = json['starting_price'];
    auctionEndAt = json['auction_end_at'];
    winnerId = json['winner_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    subcategory = json['subcategory'] != null ? Category.fromJson(json['subcategory']) : null;
    bookmark = json['bookmark'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['images'] = images;
    data['description'] = description;
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['stock'] = stock;
    data['type'] = type;
    data['bid'] = bid;
    data['shipping_cost'] = shippingCost;
    data['ship_within'] = shipWithin;
    data['price'] = price;
    data['starting_price'] = startingPrice;
    data['auction_end_at'] = auctionEndAt;
    data['winner_id'] = winnerId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (subcategory != null) {
      data['subcategory'] = subcategory!.toJson();
    }
    data['bookmark'] = bookmark;
    return data;
  }
}

class Category {
  int? id;
  String? title;

  Category({this.id, this.title});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}