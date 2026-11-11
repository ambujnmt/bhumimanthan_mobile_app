import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../utils/app_imports.dart';

class ChatHistoryScreenController extends GetxController {
  final isLoadingData = true.obs;

  final collectionName = 'chats';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final currentUserId = UserController.user.value?.id.toString();

  Future<void> refreshData() async {
    listenUnreadChats();
  }

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  final RxList<String> unreadChatIds = <String>[].obs;
  StreamSubscription? _unreadChatSubscription;

  void listenUnreadChats() {
    _unreadChatSubscription?.cancel();

    _unreadChatSubscription = _firestore
        .collection('chats')
        .where('users', arrayContains: currentUserId)
        .snapshots()
        .listen(
          (querySnapshot) {
            for (var doc in querySnapshot.docs) {
              print('rr: ${doc.data()}');
            }
          },
          onError: (error) {
            print('Error listening to chat: $error');
          },
        );
  }
}
