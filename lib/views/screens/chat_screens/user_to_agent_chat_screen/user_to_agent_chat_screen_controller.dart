import 'package:bhumi_manthan/models/propertiy_details_model.dart';

import '../../../../utils/app_imports.dart';

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/user_to_agent_chat_model.dart';

class UserToAgentChatScreenController extends GetxController {
  String? propertyId;

  final data = Rxn<PropertyDetailsModel>();

  final disableTyping = true.obs;

  final isLoading = true.obs;

  final collectionName = 'chats';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final user = UserController.user.value;

  late final String chatId;

  late final String currentUserId;

  final messageController = TextEditingController();

  final scrollController = ScrollController();

  final RxList<UserToAgentChatModel> messages = <UserToAgentChatModel>[].obs;

  final RxBool isSending = false.obs;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
  _messagesSubscription;

  bool _isDisposed = false;

  DocumentReference<Map<String, dynamic>> get _chatRef =>
      _firestore.collection(collectionName).doc(chatId);

  CollectionReference<Map<String, dynamic>> get messagesRef =>
      _chatRef.collection('messages');

  void _setChatData() {
    chatId = _getChatId();
  }

  Future<void> _getData() async {
    final res = await ApiServices().get('/properties/detail/$propertyId');

    if (!res.success) return;

    data.value = PropertyDetailsModel.fromJson(res.data['data']['property']);
    _setChatData();
  }

  Future<void> refreshData() async {
    isLoading(true);
    await _getData();
    isLoading(false);
  }

  void setDisableTyping(bool val) {
    WidgetsBinding.instance.addPostFrameCallback((_) => disableTyping(val));
  }

  @override
  void onInit() {
    super.onInit();
    propertyId = Get.arguments['id']?.toString();
    currentUserId = user!.id.toString();
    refreshData();
  }

  String _getChatId() {
    return 'chat_${data.value!.id}_${user?.id}_${data.value!.creator.id}';
  }

  // Send a text message.
  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    messageController.clear();

    if (text.isEmpty || isSending.value) return;

    isSending.value = true;

    try {
      final batch = _firestore.batch();
      final messageRef = messagesRef.doc();

      final message = UserToAgentChatModel(
        id: messageRef.id,
        senderId: currentUserId,
        message: text,
        isSeen: false,
      );

      batch.set(messageRef, message.toMap());
      final shouldRefreshHistory = messages.isEmpty;
      // Update the conversation's latest-message information.
      batch.set(_chatRef, {
        'last_message': text,
        'last_message_at': FieldValue.serverTimestamp(),
        'last_message_sender_id': currentUserId,
        if (messages.isEmpty) ...{
          'users': [user!.id.toString(), data.value!.creator.id.toString()],
          'other_user': {
            'id': data.value!.creator.id.toString(),
            'name': data.value!.creator.name,
            'role': data.value!.creator.role,
          },
          'user': {
            'id': user!.id.toString(),
            'name': user!.name,
            'role': user!.role,
          },
          'property': {
            'id': data.value!.id.toString(),
            'title': data.value!.title,
          },
        },
      }, SetOptions(merge: true));

      await batch.commit();
      if (shouldRefreshHistory) {
        // findController<ChatScreenController>()?.refreshData();
      }
    } catch (e) {
      debugPrint('Send message error: $e');
      AppToast.error('Please try again, Message not sent');
    } finally {
      if (!_isDisposed) {
        isSending.value = false;
      }
    }
  }

  // Mark only messages received from the other participant as seen.
  Future<void> markMessagesAsSeen(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) async {
    debugPrint('messages marked as seen');
    final unseenMessages = docs.where((doc) {
      final data = doc.data();

      return data['sender_id'] != currentUserId &&
          (data['isSeen'] as bool? ?? false) == false;
    }).toList();

    if (unseenMessages.isEmpty) return;

    try {
      final batch = _firestore.batch();

      for (final doc in unseenMessages) {
        batch.update(doc.reference, {'isSeen': true});
      }

      await batch.commit();
    } catch (e) {
      debugPrint('Mark messages as seen error: $e');
    }
  }

  // Retry after a stream error.
  void retryLoading() {
    if (_isDisposed) return;
    // listenToMessages();
  }

  @override
  void onClose() {
    _isDisposed = true;

    _messagesSubscription?.cancel();
    messageController.dispose();
    scrollController.dispose();

    super.onClose();
  }
}
