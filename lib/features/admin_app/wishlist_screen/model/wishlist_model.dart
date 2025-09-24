// ignore_for_file: unnecessary_this, unnecessary_new, unnecessary_question_mark, prefer_collection_literals

class WishlistModel {
  bool? success;
  String? message;
  List<Data>? data;
  int? code;

  WishlistModel({this.success, this.message, this.data, this.code});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? productId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  WishListProduct? product;

  Data(
      {this.id,
        this.userId,
        this.productId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.product});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    product =
    json['product'] != null ? new WishListProduct.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class WishListProduct {
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
  Null? winnerId;
  String? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  WishListProduct(
      {this.id,
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
        this.deletedAt});

  WishListProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    images = json['images'].cast<String>();
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['images'] = this.images;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['stock'] = this.stock;
    data['type'] = this.type;
    data['bid'] = this.bid;
    data['shipping_cost'] = this.shippingCost;
    data['ship_within'] = this.shipWithin;
    data['price'] = this.price;
    data['starting_price'] = this.startingPrice;
    data['auction_end_at'] = this.auctionEndAt;
    data['winner_id'] = this.winnerId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
