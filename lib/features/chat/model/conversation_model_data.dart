import 'dart:convert';

class ConversationCreateModelData {
  bool? success;
  String? message;
  Data? data;
  int? code;

  ConversationCreateModelData({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory ConversationCreateModelData.fromRawJson(String str) => ConversationCreateModelData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConversationCreateModelData.fromJson(Map<String, dynamic> json) => ConversationCreateModelData(
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
  Conversation? conversation;
  User? user;

  Data({
    this.conversation,
    this.user,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    conversation: json["conversation"] == null ? null : Conversation.fromJson(json["conversation"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "conversation": conversation?.toJson(),
    "user": user?.toJson(),
  };
}

class Conversation {
  int? id;
  String? type;
  dynamic disappearingStartedAt;
  dynamic disappearingDuration;
  DateTime? createdAt;
  DateTime? updatedAt;

  Conversation({
    this.id,
    this.type,
    this.disappearingStartedAt,
    this.disappearingDuration,
    this.createdAt,
    this.updatedAt,
  });

  factory Conversation.fromRawJson(String str) => Conversation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    id: json["id"],
    type: json["type"],
    disappearingStartedAt: json["disappearing_started_at"],
    disappearingDuration: json["disappearing_duration"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "disappearing_started_at": disappearingStartedAt,
    "disappearing_duration": disappearingDuration,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class User {
  int? id;
  String? name;
  String? email;
  String? avatar;
  DateTime? emailVerifiedAt;
  String? stripeAccountId;
  int? onboardComplete;
  dynamic country;
  String? city;
  String? state;
  String? address;
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
