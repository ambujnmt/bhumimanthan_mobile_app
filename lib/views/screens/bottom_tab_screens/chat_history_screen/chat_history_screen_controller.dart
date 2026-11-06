import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../utils/app_imports.dart';
import 'model/chat_history_model.dart';

class ChatHistoryScreenController extends GetxController {
  final isLoadingData = true.obs;

  final collectionName = 'chats';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final user = UserController.user.value;

  final RxList<ChatHistoryModel> chatHistory = <ChatHistoryModel>[].obs;

  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;

  Future<void> refreshData() async {
    // isLoading(true);
    // await _getChatHistory();
    _listenToChatHistory();
    listenUnreadChats();
    // isLoading(false);
  }

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
  _chatHistorySubscription;

  void _listenToChatHistory() {
    // Cancel any previous listener
    _chatHistorySubscription?.cancel();

    isLoading.value = true;
    hasError.value = false;

    _chatHistorySubscription = _firestore
        .collection(collectionName)
        .where('users', arrayContains: user!.id.toString())
        .orderBy('last_message_at', descending: true)
        .snapshots()
        .listen(
          (snapshot) {
            final chats = snapshot.docs
                .map((doc) => ChatHistoryModel.fromDocument(doc))
                .toList();
            chatHistory.assignAll(chats);
            isLoading.value = false;
            debugPrint('Total chats: ${chats.length}');
          },
          onError: (error) {
            hasError.value = true;
            isLoading.value = false;

            debugPrint('Listen chat history error: $error');
          },
        );
  }

  final RxList<String> unreadChatIds = <String>[].obs;
  StreamSubscription? _unreadChatSubscription;

  void listenUnreadChats() {
    _unreadChatSubscription?.cancel();

    final currentUserId = user!.id.toString();

    _unreadChatSubscription = _firestore
        .collection('chats')
        .where('users', arrayContains: currentUserId)
        .snapshots()
        .listen((snapshot) {
          final List<String> unreadIds = [];

          for (final chat in snapshot.docs) {
            final data = chat.data();
            final unreadCount = data['unread_count'] ?? {};

            final count = (unreadCount[currentUserId] as num?)?.toInt() ?? 0;

            if (count > 0) {
              unreadIds.add(chat.id);
            }
          }

          unreadChatIds.assignAll(unreadIds);
        });
  }
}
