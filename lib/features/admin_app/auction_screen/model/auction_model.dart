class AuctionModel {
  bool? success;
  String? message;
  AuctionData? data;
  int? code;

  AuctionModel({this.success, this.message, this.data, this.code});

  AuctionModel.fromJson(Map<String, dynamic> json) {
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

class AuctionData {
  int? currentPage;
  List<AuctionItem>? data;
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

  AuctionData({
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

  AuctionData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AuctionItem>[];
      json['data'].forEach((v) {
        data!.add(AuctionItem.fromJson(v));
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
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['current_page'] = currentPage;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
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
  int? winnerId;
  int? shipWithin;
  String? auctionEndAt;
  int? startingPrice;
  bool? bookmark;
  int? highestBid;
  String? firstImage;
  List<Bids>? bids;
  User? winner;

  AuctionItem({
    this.id,
    this.categoryId,
    this.subCategoryId,
    this.title,
    this.images,
    this.price,
    this.type,
    this.bid,
    this.shippingCost,
    this.slug,
    this.winnerId,
    this.shipWithin,
    this.auctionEndAt,
    this.startingPrice,
    this.bookmark,
    this.highestBid,
    this.firstImage,
    this.bids,
    this.winner,
  });

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
    winnerId = json['winner_id'];
    shipWithin = json['ship_within'];
    auctionEndAt = json['auction_end_at'];
    startingPrice = json['starting_price'];
    bookmark = json['bookmark'];
    highestBid = json['highest_bid'];
    firstImage = json['first_image'];
    if (json['bids'] != null) {
      bids = <Bids>[];
      json['bids'].forEach((v) {
        bids!.add(Bids.fromJson(v));
      });
    }
    winner = json['winner'] != null ? User.fromJson(json['winner']) : null;
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
    map['winner_id'] = winnerId;
    map['ship_within'] = shipWithin;
    map['auction_end_at'] = auctionEndAt;
    map['starting_price'] = startingPrice;
    map['bookmark'] = bookmark;
    map['highest_bid'] = highestBid;
    map['first_image'] = firstImage;
    if (bids != null) {
      map['bids'] = bids!.map((v) => v.toJson()).toList();
    }
    if (winner != null) {
      map['winner'] = winner!.toJson();
    }
    return map;
  }
}

class Bids {
  int? id;
  int? productId;
  int? userId;
  int? amount;
  int? isWinner;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  User? user;

  Bids({
    this.id,
    this.productId,
    this.userId,
    this.amount,
    this.isWinner,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.user,
  });

  Bids.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    amount = json['amount'];
    isWinner = json['is_winner'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['product_id'] = productId;
    map['user_id'] = userId;
    map['amount'] = amount;
    map['is_winner'] = isWinner;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    if (user != null) {
      map['user'] = user!.toJson();
    }
    return map;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? avatar;
  String? emailVerifiedAt;
  String? stripeAccountId;
  int? onboardComplete;
  String? country;
  String? city;
  String? state;
  String? address;
  String? phone;
  bool? isBanned;
  String? zipCode;
  String? deletedAt;
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

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    emailVerifiedAt = json['email_verified_at'];
    stripeAccountId = json['stripe_account_id'];
    onboardComplete = json['onboard_complete'];
    country = json['country'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
    phone = json['phone'];
    isBanned = json['is_banned'];
    zipCode = json['zip_code'];
    deletedAt = json['deleted_at'];
    cardAttributes = json['card_attributes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['avatar'] = avatar;
    map['email_verified_at'] = emailVerifiedAt;
    map['stripe_account_id'] = stripeAccountId;
    map['onboard_complete'] = onboardComplete;
    map['country'] = country;
    map['city'] = city;
    map['state'] = state;
    map['address'] = address;
    map['phone'] = phone;
    map['is_banned'] = isBanned;
    map['zip_code'] = zipCode;
    map['deleted_at'] = deletedAt;
    map['card_attributes'] = cardAttributes;
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
