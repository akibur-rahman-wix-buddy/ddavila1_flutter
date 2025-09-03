import 'dart:convert';

/// Model for filtered product data API response.
class FilterProductDataModel {
  FilterProductDataModel({
    this.success = false,
    this.message = '',
    this.data,
    this.code = 0,
  });

  factory FilterProductDataModel.fromJson(Map<String, dynamic> json) {
    try {
      return FilterProductDataModel(
        success: json['success'] as bool? ?? false,
        message: json['message'] as String? ?? '',
        data: json['data'] != null
            ? PaginationData.fromJson(json['data'] as Map<String, dynamic>)
            : null,
        code: json['code'] as num? ?? 0,
      );
    } catch (e) {
      throw FormatException('Failed to parse FilterProductDataModel: $e');
    }
  }

  final bool success;
  final String message;
  final PaginationData? data;
  final num code;

  FilterProductDataModel copyWith({
    bool? success,
    String? message,
    PaginationData? data,
    num? code,
  }) =>
      FilterProductDataModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    if (data != null) 'data': data!.toJson(),
    'code': code,
  };
}

/// Model for pagination metadata.
class PaginationData {
  PaginationData({
    this.currentPage = 0,
    this.data = const [],
    this.firstPageUrl = '',
    this.from = 0,
    this.lastPage = 0,
    this.lastPageUrl = '',
    this.links = const [],
    this.nextPageUrl,
    this.path = '',
    this.perPage = 0,
    this.prevPageUrl,
    this.to = 0,
    this.total = 0,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) {
    try {
      return PaginationData(
        currentPage: json['current_page'] as num? ?? 0,
        data: (json['data'] as List<dynamic>?)
            ?.map((v) => Product.fromJson(v as Map<String, dynamic>))
            .toList() ??
            [],
        firstPageUrl: json['first_page_url'] as String? ?? '',
        from: json['from'] as num? ?? 0,
        lastPage: json['last_page'] as num? ?? 0,
        lastPageUrl: json['last_page_url'] as String? ?? '',
        links: (json['links'] as List<dynamic>?)
            ?.map((v) => Links.fromJson(v as Map<String, dynamic>))
            .toList() ??
            [],
        nextPageUrl: json['next_page_url'] as String?,
        path: json['path'] as String? ?? '',
        perPage: json['per_page'] as num? ?? 0,
        prevPageUrl: json['prev_page_url'] as String?,
        to: json['to'] as num? ?? 0,
        total: json['total'] as num? ?? 0,
      );
    } catch (e) {
      throw FormatException('Failed to parse PaginationData: $e');
    }
  }

  final num currentPage;
  final List<Product> data;
  final String firstPageUrl;
  final num from;
  final num lastPage;
  final String lastPageUrl;
  final List<Links> links;
  final String? nextPageUrl;
  final String path;
  final num perPage;
  final String? prevPageUrl;
  final num to;
  final num total;

  PaginationData copyWith({
    num? currentPage,
    List<Product>? data,
    String? firstPageUrl,
    num? from,
    num? lastPage,
    String? lastPageUrl,
    List<Links>? links,
    String? nextPageUrl,
    String? path,
    num? perPage,
    String? prevPageUrl,
    num? to,
    num? total,
  }) =>
      PaginationData(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        links: links ?? this.links,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'data': data.map((v) => v.toJson()).toList(),
    'first_page_url': firstPageUrl,
    'from': from,
    'last_page': lastPage,
    'last_page_url': lastPageUrl,
    'links': links.map((v) => v.toJson()).toList(),
    'next_page_url': nextPageUrl,
    'path': path,
    'per_page': perPage,
    'prev_page_url': prevPageUrl,
    'to': to,
    'total': total,
  };
}

/// Model for pagination links.
class Links {
  Links({
    this.url,
    this.label = '',
    this.active = false,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    try {
      return Links(
        url: json['url'] as String?,
        label: json['label'] as String? ?? '',
        active: json['active'] as bool? ?? false,
      );
    } catch (e) {
      throw FormatException('Failed to parse Links: $e');
    }
  }

  final String? url;
  final String label;
  final bool active;

  Links copyWith({
    String? url,
    String? label,
    bool? active,
  }) =>
      Links(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  Map<String, dynamic> toJson() => {
    'url': url,
    'label': label,
    'active': active,
  };
}

/// Model for a product in an auction.
class Product {
  Product({
    this.id = 0,
    this.title = '',
    this.slug = '',
    this.images = const [],
    this.description = '',
    this.userId = 0,
    this.categoryId = 0,
    this.subCategoryId = 0,
    this.stock = 0,
    this.type = '',
    this.bid = 0,
    this.shippingCost = '0.00',
    this.shipWithin = 0,
    this.price = 0,
    this.startingPrice = 0,
    this.auctionEndAt = '',
    this.winnerId,
    this.status = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.deletedAt,
    this.bookmark = false,
    this.properties = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        id: json['id'] as num? ?? 0,
        title: json['title'] as String? ?? '',
        slug: json['slug'] as String? ?? '',
        images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
        description: json['description'] as String? ?? '',
        userId: json['user_id'] as num? ?? 0,
        categoryId: json['category_id'] as num? ?? 0,
        subCategoryId: json['sub_category_id'] as num? ?? 0,
        stock: json['stock'] as num? ?? 0,
        type: json['type'] as String? ?? '',
        bid: json['bid'] as num? ?? 0,
        shippingCost: json['shipping_cost'] as String? ?? '0.00',
        shipWithin: json['ship_within'] as num? ?? 0,
        price: json['price'] as num? ?? 0,
        startingPrice: json['starting_price'] as num? ?? 0,
        auctionEndAt: json['auction_end_at'] as String? ?? '',
        winnerId: json['winner_id'] as num?,
        status: json['status'] as String? ?? '',
        createdAt: json['created_at'] as String? ?? '',
        updatedAt: json['updated_at'] as String? ?? '',
        deletedAt: json['deleted_at'] as String?,
        bookmark: json['bookmark'] as bool? ?? false,
        properties: (json['properties'] as List<dynamic>?)
            ?.map((v) => Property.fromJson(v as Map<String, dynamic>))
            .toList() ??
            [],
      );
    } catch (e) {
      throw FormatException('Failed to parse Product: $e');
    }
  }

  final num id;
  final String title;
  final String slug;
  final List<String> images;
  final String description;
  final num userId;
  final num categoryId;
  final num subCategoryId;
  final num stock;
  final String type;
  final num bid;
  final String shippingCost;
  final num shipWithin;
  final num price;
  final num startingPrice;
  final String auctionEndAt;
  final num? winnerId;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final bool bookmark;
  final List<Property> properties;

  Product copyWith({
    num? id,
    String? title,
    String? slug,
    List<String>? images,
    String? description,
    num? userId,
    num? categoryId,
    num? subCategoryId,
    num? stock,
    String? type,
    num? bid,
    String? shippingCost,
    num? shipWithin,
    num? price,
    num? startingPrice,
    String? auctionEndAt,
    num? winnerId,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    bool? bookmark,
    List<Property>? properties,
  }) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        images: images ?? this.images,
        description: description ?? this.description,
        userId: userId ?? this.userId,
        categoryId: categoryId ?? this.categoryId,
        subCategoryId: subCategoryId ?? this.subCategoryId,
        stock: stock ?? this.stock,
        type: type ?? this.type,
        bid: bid ?? this.bid,
        shippingCost: shippingCost ?? this.shippingCost,
        shipWithin: shipWithin ?? this.shipWithin,
        price: price ?? this.price,
        startingPrice: startingPrice ?? this.startingPrice,
        auctionEndAt: auctionEndAt ?? this.auctionEndAt,
        winnerId: winnerId ?? this.winnerId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        bookmark: bookmark ?? this.bookmark,
        properties: properties ?? this.properties,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'slug': slug,
    'images': images,
    'description': description,
    'user_id': userId,
    'category_id': categoryId,
    'sub_category_id': subCategoryId,
    'stock': stock,
    'type': type,
    'bid': bid,
    'shipping_cost': shippingCost,
    'ship_within': shipWithin,
    'price': price,
    'starting_price': startingPrice,
    'auction_end_at': auctionEndAt,
    'winner_id': winnerId,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'deleted_at': deletedAt,
    'bookmark': bookmark,
    'properties': properties.map((v) => v.toJson()).toList(),
  };
}

/// Model for product properties.
class Property {
  Property({
    this.id = 0,
    this.productId = 0,
    this.title = '',
    this.value = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    try {
      return Property(
        id: json['id'] as num? ?? 0,
        productId: json['product_id'] as num? ?? 0,
        title: json['title'] as String? ?? '',
        value: json['value'] as String? ?? '',
        createdAt: json['created_at'] as String? ?? '',
        updatedAt: json['updated_at'] as String? ?? '',
      );
    } catch (e) {
      throw FormatException('Failed to parse Property: $e');
    }
  }

  final num id;
  final num productId;
  final String title;
  final String value;
  final String createdAt;
  final String updatedAt;

  Property copyWith({
    num? id,
    num? productId,
    String? title,
    String? value,
    String? createdAt,
    String? updatedAt,
  }) =>
      Property(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        title: title ?? this.title,
        value: value ?? this.value,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_id': productId,
    'title': title,
    'value': value,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}