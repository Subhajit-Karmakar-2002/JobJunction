import 'dart:convert';

List<ReceivedMessage> receivedMessageFromJson(String str) =>
    List<ReceivedMessage>.from(
        json.decode(str).map((x) => ReceivedMessage.fromJson(x)));

class ReceivedMessage {
  final String id;
  final Sender sender;
  final String content;
  final String receiver;
  final Chat chat;
  final List<dynamic> readBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ReceivedMessage({
    required this.id,
    required this.sender,
    required this.content,
    required this.receiver,
    required this.chat,
    required this.readBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ReceivedMessage.fromJson(Map<String, dynamic> json) =>
      ReceivedMessage(
        id: json["_id"] ?? "",
        sender: Sender.fromJson(json["sender"] ?? {}),
        content: json["content"] ?? "",
        receiver: json["receiver"] ?? "",
        chat: Chat.fromJson(json["chat"] ?? {}),
        readBy: json["readBy"] != null
            ? List<dynamic>.from(json["readBy"].map((x) => x))
            : [],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : DateTime.now(),
        v: json["__v"] ?? 0,
      );
}

class Chat {
  final String id;
  final String chatName;
  final bool isGroupChat;
  final List<User> users;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String latestMessage;

  Chat({
    required this.id,
    required this.chatName,
    required this.isGroupChat,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.latestMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"] ?? "",
        chatName: json["chatName"] ?? "",
        isGroupChat: json["isGroupChat"] ?? false,
        users: json["users"] != null
            ? List<User>.from(json["users"].map((x) => User.fromJson(x)))
            : [],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : DateTime.now(),
        v: json["__v"] ?? 0,
        latestMessage: json["latestMessage"] ?? "",
      );
}

class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final List<String> skills;
  final String profile;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String location;
  final String phone;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.skills,
    required this.profile,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.location,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] ?? "",
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        skills: json["skills"] != null
            ? List<String>.from(json["skills"].map((x) => x))
            : [],
        profile: json["profile"] ?? "",
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : DateTime.now(),
        v: json["__v"] ?? 0,
        location: json["location"] ?? "",
        phone: json["phone"] ?? "",
      );
}

class Sender {
  final String id;
  final String username;
  final String email;
  final String profile;

  Sender({
    required this.id,
    required this.username,
    required this.email,
    required this.profile,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"] ?? "",
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        profile: json["profile"] ?? "",
      );
}
