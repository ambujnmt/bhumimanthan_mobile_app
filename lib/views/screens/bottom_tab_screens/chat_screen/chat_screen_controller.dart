import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../utils/app_imports.dart';
import 'model/chat_history_model.dart';

class ChatScreenController extends GetxController {
  final isLoadingData = true.obs;

  final collectionName = 'chats';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final user = UserController.user.value;

  late final String chatId;

  late final String currentUserId;

  final messageController = TextEditingController();

  final scrollController = ScrollController();

  final RxList<ChatHistoryModel> messages = <ChatHistoryModel>[].obs;

  final RxBool isLoading = true.obs;
  final RxBool isSending = false.obs;
  final RxBool hasError = false.obs;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
  _messagesSubscription;

  bool _isDisposed = false;

  DocumentReference<Map<String, dynamic>> get _chatRef =>
      _firestore.collection(collectionName).doc(chatId);

  CollectionReference<Map<String, dynamic>> get _messagesRef =>
      _chatRef.collection('messages');

  @override
  void onInit() {
    super.onInit();
    currentUserId = user!.id.toString();
    listenToMessages();
  }

  // Listen to the latest 50 messages in real time.
  void listenToMessages() {
    _messagesSubscription?.cancel();

    isLoading.value = true;
    hasError.value = false;

    _messagesSubscription = _messagesRef
        .orderBy('created_at', descending: true)
        .limit(50)
        .snapshots()
        .listen(
          (snapshot) {
            if (_isDisposed) return;

            messages.assignAll(
              snapshot.docs.map(ChatHistoryModel.fromDocument),
            );

            isLoading.value = false;
            hasError.value = false;
          },
          onError: (Object error) {
            if (_isDisposed) return;

            isLoading.value = false;
            hasError.value = true;

            debugPrint('Firestore message listener error: $error');
          },
        );
  }

  // Retry after a stream error.
  void retryLoading() {
    if (_isDisposed) return;
    listenToMessages();
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
