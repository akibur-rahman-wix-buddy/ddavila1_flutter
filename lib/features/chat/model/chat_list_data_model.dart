import 'dart:convert';

class ChatListModelData {
  bool? success;
  String? message;
  Data? data;
  int? code;

  ChatListModelData({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory ChatListModelData.fromRawJson(String str) => ChatListModelData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatListModelData.fromJson(Map<String, dynamic> json) => ChatListModelData(
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
  List<Conversation>? conversations;

  Data({
    this.conversations,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    conversations: json["conversations"] == null ? [] : List<Conversation>.from(json["conversations"]!.map((x) => Conversation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "conversations": conversations == null ? [] : List<dynamic>.from(conversations!.map((x) => x.toJson())),
  };
}

class Conversation {
  int? id;
  bool? readable;
  List<Participant>? participants;
  LastMessage? lastMessage;

  Conversation({
    this.id,
    this.readable,
    this.participants,
    this.lastMessage,
  });

  factory Conversation.fromRawJson(String str) => Conversation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    id: json["id"],
    readable: json["readable"],
    participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
    lastMessage: json["last_message"] == null ? null : LastMessage.fromJson(json["last_message"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "readable": readable,
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
    "last_message": lastMessage?.toJson(),
  };
}

class LastMessage {
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

  LastMessage({
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
  });

  factory LastMessage.fromRawJson(String str) => LastMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
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
