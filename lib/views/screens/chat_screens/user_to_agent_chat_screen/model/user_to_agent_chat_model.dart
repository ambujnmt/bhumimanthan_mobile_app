import 'package:cloud_firestore/cloud_firestore.dart';

class UserToAgentChatModel {
  final String id;
  final String senderId;
  final String message;
  final bool isSeen;
  final DateTime? createdAt;

  const UserToAgentChatModel({
    required this.id,
    required this.senderId,
    required this.message,
    this.isSeen = false,
    this.createdAt,
  });

  factory UserToAgentChatModel.fromDocument(dynamic doc) {
    final data = doc.data() ?? {};

    return UserToAgentChatModel(
      id: doc.id,
      senderId: data['sender_id'].toString(),
      message: data['message'] as String? ?? '',
      isSeen: data['isSeen'] as bool? ?? false,
      createdAt: (data['created_at'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sender_id': senderId,
      'message': message,
      'isSeen': isSeen,
      'created_at': FieldValue.serverTimestamp(),
    };
  }
}
