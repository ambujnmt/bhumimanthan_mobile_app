import 'package:cloud_firestore/cloud_firestore.dart';

class ChatHistoryModel {
  final String id;
  final String lastMessage;
  final DateTime lastMessageAt;
  final String lastMessageSenderId;
  final ChatHistoryUser user;
  final ChatHistoryUser otherUser;
  final ChatProperty property;

  const ChatHistoryModel({
    required this.id,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.lastMessageSenderId,
    required this.user,
    required this.otherUser,
    required this.property,
  });

  factory ChatHistoryModel.fromMap(String id, Map<String, dynamic> data) {
    return ChatHistoryModel(
      id: id,
      lastMessage: data['last_message'] as String? ?? '',
      lastMessageAt: (data['last_message_at'] as Timestamp?)!.toDate(),
      lastMessageSenderId: data['last_message_sender_id']?.toString() ?? '',
      otherUser: ChatHistoryUser.fromMap(data['other_user']),
      user: ChatHistoryUser.fromMap(data['user']),
      property: ChatProperty.fromMap(data['property']),
      // messages: data['messages'],
    );
  }

  factory ChatHistoryModel.fromDocument(dynamic doc) {
    return ChatHistoryModel.fromMap(doc.id, doc.data() ?? {});
  }
}

class ChatHistoryUser {
  final String id;
  final String name;
  final String role;

  const ChatHistoryUser({
    required this.id,
    required this.name,
    required this.role,
  });

  factory ChatHistoryUser.fromMap(Map<String, dynamic> data) {
    return ChatHistoryUser(
      id: data['id']?.toString() ?? '',
      role: data['role']?.toString() ?? '',
      name: data['name']?.toString() ?? '',
    );
  }
}

class ChatProperty {
  final String id;
  final String title;

  const ChatProperty({required this.id, required this.title});

  factory ChatProperty.fromMap(Map<String, dynamic> data) {
    return ChatProperty(
      id: data['id']?.toString() ?? '',
      title: data['title']?.toString() ?? '',
    );
  }
}
