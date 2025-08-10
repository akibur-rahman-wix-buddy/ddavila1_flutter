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
  List<dynamic>? attachment;

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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    isMe: json["isMe"],
    attachment: json["attachment"] == null ? [] : List<dynamic>.from(json["attachment"]!.map((x) => x)),
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
    "attachment": attachment == null ? [] : List<dynamic>.from(attachment!.map((x) => x)),
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
