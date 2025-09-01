import 'dart:convert';

class AdminDashModel {
    final dynamic auctionsAll;
    final dynamic auctionsOnGoing;
    final dynamic totalEarning;
    final dynamic soldItems;
    final Map<String, dynamic>? dailyData;
    final List<TopBidder>? topBidder;
    final Map<String, dynamic>? earning;
    final List<RecentAuction>? recentAuctions;

    AdminDashModel({
        this.auctionsAll,
        this.auctionsOnGoing,
        this.totalEarning,
        this.soldItems,
        this.dailyData,
        this.topBidder,
        this.earning,
        this.recentAuctions,
    });

    factory AdminDashModel.fromRawJson(String str) => AdminDashModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AdminDashModel.fromJson(Map<String, dynamic> json) => AdminDashModel(
        auctionsAll: json["auctionsAll"],
        auctionsOnGoing: json["auctionsOnGoing"],
        totalEarning: json["totalEarning"],
        soldItems: json["soldItems"],
        dailyData: Map.from(json["dailyData"]!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        topBidder: json["topBidder"] == null ? [] : List<TopBidder>.from(json["topBidder"]!.map((x) => TopBidder.fromJson(x))),
        earning: Map.from(json["earning"]!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        recentAuctions: json["recentAuctions"] == null ? [] : List<RecentAuction>.from(json["recentAuctions"]!.map((x) => RecentAuction.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "auctionsAll": auctionsAll,
        "auctionsOnGoing": auctionsOnGoing,
        "totalEarning": totalEarning,
        "soldItems": soldItems,
        "dailyData": Map.from(dailyData!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "topBidder": topBidder == null ? [] : List<dynamic>.from(topBidder!.map((x) => x.toJson())),
        "earning": Map.from(earning!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "recentAuctions": recentAuctions == null ? [] : List<dynamic>.from(recentAuctions!.map((x) => x.toJson())),
    };
}

class RecentAuction {
    final dynamic id;
    final String? title;
    final String? slug;
    final List<String>? images;
    final DateTime? auctionEndAt;
    final dynamic startingPrice;

    RecentAuction({
        this.id,
        this.title,
        this.slug,
        this.images,
        this.auctionEndAt,
        this.startingPrice,
    });

    factory RecentAuction.fromRawJson(String str) => RecentAuction.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RecentAuction.fromJson(Map<String, dynamic> json) => RecentAuction(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        auctionEndAt: json["auction_end_at"] == null ? null : DateTime.parse(json["auction_end_at"]),
        startingPrice: json["starting_price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "auction_end_at": auctionEndAt?.toIso8601String(),
        "starting_price": startingPrice,
    };
}

class TopBidder {
    final dynamic userId;
    final dynamic maxBid;
    final User? user;

    TopBidder({
        this.userId,
        this.maxBid,
        this.user,
    });

    factory TopBidder.fromRawJson(String str) => TopBidder.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TopBidder.fromJson(Map<String, dynamic> json) => TopBidder(
        userId: json["user_id"],
        maxBid: json["max_bid"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "max_bid": maxBid,
        "user": user?.toJson(),
    };
}

class User {
    final int? id;
    final String? name;
    final String? email;
    final String? avatar;
    final DateTime? emailVerifiedAt;
    final String? stripeAccountId;
    final int? onboardComplete;
    final String? country;
    final String? city;
    final String? state;
    final String? address;
    final String? phone;
    final bool? isBanned;
    final String? zipCode;
    final dynamic deletedAt;
    final bool? cardAttributes;

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
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        stripeAccountId: json["stripe_account_id"],
        onboardComplete: json["onboard_complete"],
        country: json["country"],
        city: json["city"],
        state: json["state"],
        address: json["address"],
        phone: json["phone"],
        isBanned: json["is_banned"],
        zipCode: json["zip_code"],
        deletedAt: json["deleted_at"],
        cardAttributes: json["card_attributes"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "avatar": avatar,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "stripe_account_id": stripeAccountId,
        "onboard_complete": onboardComplete,
        "country": country,
        "city": city,
        "state": state,
        "address": address,
        "phone": phone,
        "is_banned": isBanned,
        "zip_code": zipCode,
        "deleted_at": deletedAt,
        "card_attributes": cardAttributes,
    };
}
