// import 'dart:convert';
//
// class CategoryWiseProductDataModel {
//   bool? success;
//   String? message;
//   Data? data;
//   int? code;
//
//   CategoryWiseProductDataModel({
//     this.success,
//     this.message,
//     this.data,
//     this.code,
//   });
//
//   factory CategoryWiseProductDataModel.fromRawJson(String str) => CategoryWiseProductDataModel.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory CategoryWiseProductDataModel.fromJson(Map<String, dynamic> json) => CategoryWiseProductDataModel(
//     success: json["success"],
//     message: json["message"],
//     data: json["data"] == null ? null : Data.fromJson(json["data"]),
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
// class Data {
//   Category? category;
//   Products? products;
//
//   Data({
//     this.category,
//     this.products,
//   });
//
//   factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     category: json["category"] == null ? null : Category.fromJson(json["category"]),
//     products: json["products"] == null ? null : Products.fromJson(json["products"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "category": category?.toJson(),
//     "products": products?.toJson(),
//   };
// }
//
// class Category {
//   int? id;
//   String? title;
//   String? slug;
//   String? image;
//   List<Subcategory>? subcategories;
//
//   Category({
//     this.id,
//     this.title,
//     this.slug,
//     this.image,
//     this.subcategories,
//   });
//
//   factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//     id: json["id"],
//     title: json["title"],
//     slug: json["slug"],
//     image: json["image"],
//     subcategories: json["subcategories"] == null ? [] : List<Subcategory>.from(json["subcategories"]!.map((x) => Subcategory.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "slug": slug,
//     "image": image,
//     "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
//   };
// }
//
// class Subcategory {
//   int? id;
//   String? title;
//   String? slug;
//
//   Subcategory({
//     this.id,
//     this.title,
//     this.slug,
//   });
//
//   factory Subcategory.fromRawJson(String str) => Subcategory.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
//     id: json["id"],
//     title: json["title"],
//     slug: json["slug"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "slug": slug,
//   };
// }
//
// class Products {
//   int? currentPage;
//   List<ProductData>? data;
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
//   Products({
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
//   factory Products.fromRawJson(String str) => Products.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Products.fromJson(Map<String, dynamic> json) => Products(
//     currentPage: json["current_page"],
//     data: json["data"] == null ? [] : List<ProductData>.from(json["data"]!.map((x) => ProductData.fromJson(x))),
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
// class ProductData {
//   int? id;
//   String? title;
//   String? slug;
//   List<String>? images;
//   int? price;
//   String? type;
//   int? bid;
//   int? categoryId;
//   int? subCategoryId;
//   DateTime? createdAt;
//   bool? bookmark;
//   int? highestBid;
//   String? firstImage;
//   Category? category;
//   Category? subcategory;
//
//   ProductData({
//     this.id,
//     this.title,
//     this.slug,
//     this.images,
//     this.price,
//     this.type,
//     this.bid,
//     this.categoryId,
//     this.subCategoryId,
//     this.createdAt,
//     this.bookmark,
//     this.highestBid,
//     this.firstImage,
//     this.category,
//     this.subcategory,
//   });
//
//   factory ProductData.fromRawJson(String str) => ProductData.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
//     id: json["id"],
//     title: json["title"],
//     slug: json["slug"],
//     images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
//     price: json["price"],
//     type: json["type"],
//     bid: json["bid"],
//     categoryId: json["category_id"],
//     subCategoryId: json["sub_category_id"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     bookmark: json["bookmark"],
//     highestBid: json["highest_bid"],
//     firstImage: json["first_image"],
//     category: json["category"] == null ? null : Category.fromJson(json["category"]),
//     subcategory: json["subcategory"] == null ? null : Category.fromJson(json["subcategory"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "slug": slug,
//     "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
//     "price": price,
//     "type": type,
//     "bid": bid,
//     "category_id": categoryId,
//     "sub_category_id": subCategoryId,
//     "created_at": createdAt?.toIso8601String(),
//     "bookmark": bookmark,
//     "highest_bid": highestBid,
//     "first_image": firstImage,
//     "category": category?.toJson(),
//     "subcategory": subcategory?.toJson(),
//   };
// }
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








import 'dart:convert';

class CategoryResponseModel {
  bool? success;
  String? message;
  List<Category>? data;
  dynamic code;

  CategoryResponseModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory CategoryResponseModel.fromRawJson(String str) =>
      CategoryResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) => CategoryResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Category>.from(json["data"]!.map((x) => Category.fromJson(x))),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "code": code,
  };
}

class CategoryWiseProductDataModel {
  bool? success;
  String? message;
  Data? data;
  dynamic code;

  CategoryWiseProductDataModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory CategoryWiseProductDataModel.fromRawJson(String str) =>
      CategoryWiseProductDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryWiseProductDataModel.fromJson(Map<String, dynamic> json) => CategoryWiseProductDataModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "code": code,
  };
}

class Data {
  Category? category;
  Products? products;

  Data({
    this.category,
    this.products,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    products: json["products"] == null ? null : Products.fromJson(json["products"]),
  );

  Map<String, dynamic> toJson() => {
    "category": category?.toJson(),
    "products": products?.toJson(),
  };
}

class Category {
  dynamic id;
  String? title;
  String? slug;
  String? image;
  dynamic trending;
  dynamic popular;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  List<Subcategory>? subcategories;

  Category({
    this.id,
    this.title,
    this.slug,
    this.image,
    this.trending,
    this.popular,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.subcategories,
  });

  factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    image: json["image"],
    trending: json["trending"],
    popular: json["popular"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    subcategories: json["subcategories"] == null ? [] : List<Subcategory>.from(json["subcategories"]!.map((x) => Subcategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "image": image,
    "trending": trending,
    "popular": popular,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
  };
}

class Subcategory {
  dynamic id;
  dynamic categoryId;
  String? title;
  String? slug;
  String? image;
  dynamic trending;
  dynamic popular;
  DateTime? createdAt;
  DateTime? updatedAt;

  Subcategory({
    this.id,
    this.categoryId,
    this.title,
    this.slug,
    this.image,
    this.trending,
    this.popular,
    this.createdAt,
    this.updatedAt,
  });

  factory Subcategory.fromRawJson(String str) => Subcategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json["id"],
    categoryId: json["category_id"],
    title: json["title"],
    slug: json["slug"],
    image: json["image"],
    trending: json["trending"],
    popular: json["popular"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "title": title,
    "slug": slug,
    "image": image,
    "trending": trending,
    "popular": popular,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Products {
  dynamic currentPage;
  List<ProductData>? data;
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

  Products({
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

  factory Products.fromRawJson(String str) => Products.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<ProductData>.from(json["data"]!.map((x) => ProductData.fromJson(x))),
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

class ProductData {
  dynamic id;
  String? title;
  String? slug;
  List<String>? images;
  dynamic price;
  String? type;
  dynamic bid;
  dynamic categoryId;
  dynamic subCategoryId;
  DateTime? createdAt;
  bool? bookmark;
  dynamic highestBid;
  String? firstImage;
  Category? category;
  Category? subcategory;

  ProductData({
    this.id,
    this.title,
    this.slug,
    this.images,
    this.price,
    this.type,
    this.bid,
    this.categoryId,
    this.subCategoryId,
    this.createdAt,
    this.bookmark,
    this.highestBid,
    this.firstImage,
    this.category,
    this.subcategory,
  });

  factory ProductData.fromRawJson(String str) => ProductData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    price: json["price"],
    type: json["type"],
    bid: json["bid"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    bookmark: json["bookmark"],
    highestBid: json["highest_bid"],
    firstImage: json["first_image"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    subcategory: json["subcategory"] == null ? null : Category.fromJson(json["subcategory"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "price": price,
    "type": type,
    "bid": bid,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "created_at": createdAt?.toIso8601String(),
    "bookmark": bookmark,
    "highest_bid": highestBid,
    "first_image": firstImage,
    "category": category?.toJson(),
    "subcategory": subcategory?.toJson(),
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