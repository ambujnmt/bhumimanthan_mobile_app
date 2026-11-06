import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../utils/app_imports.dart';
import 'model/chat_history_model.dart';

class ChatHistoryScreenController extends GetxController {
  final isLoadingData = true.obs;

  final collectionName = 'chats';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final user = UserController.user.value;

  final totalCount = 0.obs;

  final RxList<ChatHistoryModel> chatHistory = <ChatHistoryModel>[].obs;

  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;

  Future<void> refreshData() async {
    // isLoading(true);
    // await _getChatHistory();
    _listenToChatHistory();
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
        // .orderBy('last_message_at', descending: true)
        .snapshots()
        .listen(
          (snapshot) {
            final chats = snapshot.docs
                .map((doc) => ChatHistoryModel.fromDocument(doc))
                .toList();
            chats.sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));
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
}
