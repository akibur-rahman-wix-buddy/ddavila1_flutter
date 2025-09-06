class BidHistoryDataModel {
  bool? success;
  String? message;
  List<BidHistoryData>? data;
  int? code;

  BidHistoryDataModel({this.success, this.message, this.data, this.code});

  BidHistoryDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

    // Fixed data parsing - handle both array and object cases
    if (json['data'] != null) {
      if (json['data'] is List) {
        // Handle array response
        data = <BidHistoryData>[];
        for (var v in json['data']) {
          data!.add(BidHistoryData.fromJson(v));
        }
      } else {
        // Handle object response or unexpected format by setting empty list
        data = <BidHistoryData>[];
      }
    } else {
      data = <BidHistoryData>[];
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    return data;
  }
}

class BidHistoryData {
  int? id;
  int? productId;
  int? userId;
  int? amount;
  int? isWinner;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Product? product;

  BidHistoryData({
    this.id,
    this.productId,
    this.userId,
    this.amount,
    this.isWinner,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.product,
  });

  BidHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    amount = json['amount'];
    isWinner = json['is_winner'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['user_id'] = userId;
    data['amount'] = amount;
    data['is_winner'] = isWinner;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
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

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];

    // Fixed images parsing
    if (json['images'] != null) {
      if (json['images'] is List) {
        images = (json['images'] as List).map((item) => item.toString()).toList();
      } else if (json['images'] is String) {
        images = [json['images']];
      } else {
        images = null;
      }
    } else {
      images = null;
    }

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
    return data;
  }
}