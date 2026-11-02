import 'package:cloud_firestore/cloud_firestore.dart';

class ChatHistoryModel {
  final String lastMessage;
  final DateTime? lastMessageAt;
  final String lastMessageSenderId;
  final ChatListingData listingData;

  const ChatHistoryModel({
    required this.lastMessage,
    required this.lastMessageAt,
    required this.lastMessageSenderId,
    required this.listingData,
  });

  factory ChatHistoryModel.fromMap(Map<String, dynamic> data) {
    return ChatHistoryModel(
      lastMessage: data['last_message'] as String? ?? '',
      lastMessageAt: (data['last_message_at'] as Timestamp?)?.toDate(),
      lastMessageSenderId: data['last_message_sender_id']?.toString() ?? '',
      listingData: ChatListingData.fromMap(
        data['listing_data'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  factory ChatHistoryModel.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    return ChatHistoryModel.fromMap(doc.data() ?? {});
  }

  Map<String, dynamic> toMap() {
    return {
      'last_message': lastMessage,
      'last_message_at': FieldValue.serverTimestamp(),
      'last_message_sender_id': lastMessageSenderId,
      'listing_data': listingData.toMap(),
    };
  }
}

class ChatListingData {
  final String propertyId;
  final String role;
  final String propertyName;
  final String agentName;

  const ChatListingData({
    required this.propertyId,
    required this.agentName,
    required this.propertyName,
    required this.role,
  });

  factory ChatListingData.fromMap(Map<String, dynamic> data) {
    return ChatListingData(
      propertyId: data['property_id']?.toString() ?? '',
      role: data['role']?.toString() ?? '',
      propertyName: data['property_name']?.toString() ?? '',
      agentName: data['agent_name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'property_id': propertyId,
      'role': role,
      'property_name': propertyName,
      'agent_name': agentName,
    };
  }
}
