class AuctionRunningModel {
  bool? success;
  String? message;
  AuctionData? data;
  int? code;

  AuctionRunningModel({this.success, this.message, this.data, this.code});

  AuctionRunningModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? AuctionData.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    map['code'] = code;
    return map;
  }
}

/// 📌 Pagination wrapper
class AuctionData {
  int? currentPage;
  List<AuctionItem>? items;
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

  AuctionData(
      {this.currentPage,
        this.items,
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
        this.total});

  AuctionData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      items = <AuctionItem>[];
      json['data'].forEach((v) {
        items!.add(AuctionItem.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = int.tryParse(json['per_page'].toString());
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['current_page'] = currentPage;
    if (items != null) {
      map['data'] = items!.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = firstPageUrl;
    map['from'] = from;
    map['last_page'] = lastPage;
    map['last_page_url'] = lastPageUrl;
    if (links != null) {
      map['links'] = links!.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
    return map;
  }
}

/// 📌 Auction Item Model
class AuctionItem {
  int? id;
  int? categoryId;
  int? subCategoryId;
  String? title;
  List<String>? images;
  int? price;
  String? type;
  int? bid;
  String? shippingCost;
  String? slug;
  int? shipWithin;
  String? auctionEndAt;
  int? startingPrice;
  bool? bookmark;
  int? highestBid;
  String? firstImage;
  List<dynamic>? bids;

  AuctionItem(
      {this.id,
        this.categoryId,
        this.subCategoryId,
        this.title,
        this.images,
        this.price,
        this.type,
        this.bid,
        this.shippingCost,
        this.slug,
        this.shipWithin,
        this.auctionEndAt,
        this.startingPrice,
        this.bookmark,
        this.highestBid,
        this.firstImage,
        this.bids});

  AuctionItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    title = json['title'];
    images = json['images'] != null ? List<String>.from(json['images']) : [];
    price = json['price'];
    type = json['type'];
    bid = json['bid'];
    shippingCost = json['shipping_cost']?.toString();
    slug = json['slug'];
    shipWithin = json['ship_within'];
    auctionEndAt = json['auction_end_at'];
    startingPrice = json['starting_price'];
    bookmark = json['bookmark'];
    highestBid = json['highest_bid'];
    firstImage = json['first_image'];
    bids = json['bids'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['category_id'] = categoryId;
    map['sub_category_id'] = subCategoryId;
    map['title'] = title;
    map['images'] = images;
    map['price'] = price;
    map['type'] = type;
    map['bid'] = bid;
    map['shipping_cost'] = shippingCost;
    map['slug'] = slug;
    map['ship_within'] = shipWithin;
    map['auction_end_at'] = auctionEndAt;
    map['starting_price'] = startingPrice;
    map['bookmark'] = bookmark;
    map['highest_bid'] = highestBid;
    map['first_image'] = firstImage;
    map['bids'] = bids;
    return map;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['url'] = url;
    map['label'] = label;
    map['active'] = active;
    return map;
  }
}
