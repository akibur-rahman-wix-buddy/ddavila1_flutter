class ShopAllProductsDataModel {
  bool? success;
  String? message;
  Data? data; // Changed from ShopProductsData to Data
  int? code;

  ShopAllProductsDataModel({this.success, this.message, this.data, this.code});

  ShopAllProductsDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    message = json['message'] as String?;
    data = json['data'] != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null;
    code = json['code'] as int?;
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

class Data {
  int? currentPage;
  List<Product>? products; // Renamed from data to products for clarity
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.products,
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

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] as int?;
    if (json['data'] != null) {
      products = (json['data'] as List<dynamic>)
          .map((v) => Product.fromJson(v as Map<String, dynamic>))
          .toList();
    } else {
      products = [];
    }
    firstPageUrl = json['first_page_url'] as String?;
    from = json['from'] as int?;
    lastPage = json['last_page'] as int?;
    lastPageUrl = json['last_page_url'] as String?;
    if (json['links'] != null) {
      links = (json['links'] as List<dynamic>)
          .map((v) => Links.fromJson(v as Map<String, dynamic>))
          .toList();
    } else {
      links = [];
    }
    nextPageUrl = json['next_page_url'] as String?;
    path = json['path'] as String?;
    perPage = json['per_page'] as int?;
    prevPageUrl = json['prev_page_url'] as String?;
    to = json['to'] as int?;
    total = json['total'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (products != null) {
      data['data'] = products!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Product {
  int? id;
  String? title;
  String? slug;
  List<String>? images;
  int? price;
  String? type;
  int? bid;
  String? shippingCost;
  int? startingPrice;
  String? auctionEndAt;
  bool? bookmark;
  int? highestBid;
  String? firstImage;

  Product({
    this.id,
    this.title,
    this.slug,
    this.images,
    this.price,
    this.type,
    this.bid,
    this.shippingCost,
    this.startingPrice,
    this.auctionEndAt,
    this.bookmark,
    this.highestBid,
    this.firstImage,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
    slug = json['slug'] as String?;
    images = (json['images'] as List<dynamic>?)?.cast<String>() ?? [];
    price = json['price'] as int?;
    type = json['type'] as String?;
    bid = json['bid'] as int?;
    shippingCost = json['shipping_cost'] as String?;
    startingPrice = json['starting_price'] as int?;
    auctionEndAt = json['auction_end_at'] as String?;
    bookmark = json['bookmark'] as bool?;
    highestBid = json['highest_bid'] as int?;
    firstImage = json['first_image'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['images'] = images;
    data['price'] = price;
    data['type'] = type;
    data['bid'] = bid;
    data['shipping_cost'] = shippingCost;
    data['starting_price'] = startingPrice;
    data['auction_end_at'] = auctionEndAt;
    data['bookmark'] = bookmark;
    data['highest_bid'] = highestBid;
    data['first_image'] = firstImage;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'] as String?;
    label = json['label'] as String?;
    active = json['active'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}