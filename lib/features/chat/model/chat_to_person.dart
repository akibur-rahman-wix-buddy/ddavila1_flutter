import 'dart:convert';

class PersonalChatScreenDataModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  PersonalChatScreenDataModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory PersonalChatScreenDataModel.fromRawJson(String str) => PersonalChatScreenDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PersonalChatScreenDataModel.fromJson(Map<String, dynamic> json) => PersonalChatScreenDataModel(
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
  Conversations? conversations;
  bool? youblocked;
  bool? blockedyou;

  Data({
    this.conversations,
    this.youblocked,
    this.blockedyou,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    conversations: json["conversations"] == null ? null : Conversations.fromJson(json["conversations"]),
    youblocked: json["youblocked"],
    blockedyou: json["blockedyou"],
  );

  Map<String, dynamic> toJson() => {
    "conversations": conversations?.toJson(),
    "youblocked": youblocked,
    "blockedyou": blockedyou,
  };
}

class Conversations {
  int? id;
  List<Participant>? participants;
  List<Message>? messages;

  Conversations({
    this.id,
    this.participants,
    this.messages,
  });

  factory Conversations.fromRawJson(String str) => Conversations.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Conversations.fromJson(Map<String, dynamic> json) => Conversations(
    id: json["id"],
    participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
    messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
    "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
  };
}

// class Message {
//   int? id;
//   int? conversationId;
//   int? sendableId;
//   String? sendableType;
//   dynamic replyId;
//   String? body;
//   String? type;
//   dynamic keptAt;
//   dynamic deletedAt;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   bool? isMe;
//   List<dynamic>? attachment;
//
//   Message({
//     this.id,
//     this.conversationId,
//     this.sendableId,
//     this.sendableType,
//     this.replyId,
//     this.body,
//     this.type,
//     this.keptAt,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.isMe,
//     this.attachment,
//   });
//
//   factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Message.fromJson(Map<String, dynamic> json) => Message(
//     id: json["id"],
//     conversationId: json["conversation_id"],
//     sendableId: json["sendable_id"],
//     sendableType: json["sendable_type"],
//     replyId: json["reply_id"],
//     body: json["body"],
//     type: json["type"],
//     keptAt: json["kept_at"],
//     deletedAt: json["deleted_at"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     isMe: json["isMe"],
//     attachment: json["attachment"] == null ? [] : List<dynamic>.from(json["attachment"]!.map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "conversation_id": conversationId,
//     "sendable_id": sendableId,
//     "sendable_type": sendableType,
//     "reply_id": replyId,
//     "body": body,
//     "type": type,
//     "kept_at": keptAt,
//     "deleted_at": deletedAt,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "isMe": isMe,
//     "attachment": attachment == null ? [] : List<dynamic>.from(attachment!.map((x) => x)),
//   };
// }









class Message {
  int? id;
  int? conversationId;
  int? sendableId;
  String? sendableType;
  dynamic replyId;
  String? body;
  String? type;
  dynamic keptAt;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isMe;
  List<Attachment>? attachment;
  Sendable? sendable;
  Conversation? conversation;

  Message({
    this.id,
    this.conversationId,
    this.sendableId,
    this.sendableType,
    this.replyId,
    this.body,
    this.type,
    this.keptAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.isMe,
    this.attachment,
    this.sendable,
    this.conversation,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    conversationId: json["conversation_id"],
    sendableId: json["sendable_id"],
    sendableType: json["sendable_type"],
    replyId: json["reply_id"],
    body: json["body"],
    type: json["type"],
    keptAt: json["kept_at"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    isMe: json["isMe"],
    attachment: json["attachment"] == null
        ? null
        : List<Attachment>.from(
        json["attachment"].map((x) => Attachment.fromJson(x))),
    sendable: json["sendable"] == null
        ? null
        : Sendable.fromJson(json["sendable"]),
    conversation: json["conversation"] == null
        ? null
        : Conversation.fromJson(json["conversation"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "conversation_id": conversationId,
    "sendable_id": sendableId,
    "sendable_type": sendableType,
    "reply_id": replyId,
    "body": body,
    "type": type,
    "kept_at": keptAt,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "isMe": isMe,
    "attachment": attachment == null
        ? null
        : List<dynamic>.from(attachment!.map((x) => x.toJson())),
    "sendable": sendable?.toJson(),
    "conversation": conversation?.toJson(),
  };
}

class Attachment {
  int? id;
  String? attachableType;
  int? attachableId;
  String? filePath;
  String? fileName;
  String? originalName;
  dynamic url;
  String? mimeType;
  DateTime? createdAt;
  DateTime? updatedAt;

  Attachment({
    this.id,
    this.attachableType,
    this.attachableId,
    this.filePath,
    this.fileName,
    this.originalName,
    this.url,
    this.mimeType,
    this.createdAt,
    this.updatedAt,
  });

  factory Attachment.fromRawJson(String str) =>
      Attachment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    id: json["id"],
    attachableType: json["attachable_type"],
    attachableId: json["attachable_id"],
    filePath: json["file_path"],
    fileName: json["file_name"],
    originalName: json["original_name"],
    url: json["url"],
    mimeType: json["mime_type"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attachable_type": attachableType,
    "attachable_id": attachableId,
    "file_path": filePath,
    "file_name": fileName,
    "original_name": originalName,
    "url": url,
    "mime_type": mimeType,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Sendable {
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

  Sendable({
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

  factory Sendable.fromRawJson(String str) =>
      Sendable.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sendable.fromJson(Map<String, dynamic> json) => Sendable(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    avatar: json["avatar"],
    emailVerifiedAt: json["email_verified_at"] == null
        ? null
        : DateTime.parse(json["email_verified_at"]),
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

class Conversation {
  int? id;
  String? type;
  dynamic disappearingStartedAt;
  dynamic disappearingDuration;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic group;

  Conversation({
    this.id,
    this.type,
    this.disappearingStartedAt,
    this.disappearingDuration,
    this.createdAt,
    this.updatedAt,
    this.group,
  });

  factory Conversation.fromRawJson(String str) =>
      Conversation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    id: json["id"],
    type: json["type"],
    disappearingStartedAt: json["disappearing_started_at"],
    disappearingDuration: json["disappearing_duration"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    group: json["group"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "disappearing_started_at": disappearingStartedAt,
    "disappearing_duration": disappearingDuration,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "group": group,
  };
}

















































class Participant {
  String? participantableType;
  int? participantableId;
  int? conversationId;
  Participantable? participantable;

  Participant({
    this.participantableType,
    this.participantableId,
    this.conversationId,
    this.participantable,
  });

  factory Participant.fromRawJson(String str) => Participant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    participantableType: json["participantable_type"],
    participantableId: json["participantable_id"],
    conversationId: json["conversation_id"],
    participantable: json["participantable"] == null ? null : Participantable.fromJson(json["participantable"]),
  );

  Map<String, dynamic> toJson() => {
    "participantable_type": participantableType,
    "participantable_id": participantableId,
    "conversation_id": conversationId,
    "participantable": participantable?.toJson(),
  };
}

class Participantable {
  int? id;
  String? name;
  dynamic avatar;
  bool? cardAttributes;

  Participantable({
    this.id,
    this.name,
    this.avatar,
    this.cardAttributes,
  });

  factory Participantable.fromRawJson(String str) => Participantable.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Participantable.fromJson(Map<String, dynamic> json) => Participantable(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
    cardAttributes: json["card_attributes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "card_attributes": cardAttributes,
  };
}
