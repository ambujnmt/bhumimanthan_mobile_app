import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../zz_main_screen/main_screen.dart';
import 'chat_history_screen_controller.dart';
import 'model/chat_history_model.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen>
    with AutomaticKeepAliveClientMixin {
  final _con = Get.put(ChatHistoryScreenController());
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CustomAppbar(title: 'Chat History', showLeading: false),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(_con.collectionName)
            .where('users', arrayContains: _con.currentUserId)
            .orderBy('last_message_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ApiErrorWidget();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppLoader.widget();
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return NoDataAvailable();
          }

          final chats = snapshot.data!.docs
              .map((doc) => ChatHistoryModel.fromDocument(doc))
              .toList();

          return ListView.separated(
            padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
            itemCount: chats.length,
            itemBuilder: (context, index) => _chatHistoryTile(
              chat: chats[index],
              currentUserId: _con.currentUserId!,
            ),
            separatorBuilder: (context, index) => heightSpace10,
          );
        },
      ),
    );
  }
}

Widget _chatHistoryTile({
  required ChatHistoryModel chat,
  required String currentUserId,
}) {
  final otherUser = chat.user.id == currentUserId ? chat.otherUser : chat.user;
  final chatIconCon = Get.find<ChatIconController>();

  return InkWell(
    onTap: () => Get.toNamed(
      AppRoutes.userToAgentChatScreen,
      arguments: {'id': chat.property.id},
    ),
    child: AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.toNamed(
                    AppRoutes.propertyDetailsScreen,
                    arguments: {'id': chat.property.id},
                  ),
                  child: CustomText.kText(
                    chat.property.title,
                    size: 12,
                    weight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
              widthSpace3,
              CustomText.kText(
                formatDateTime(chat.lastMessageAt.toString()),
                size: 12,
              ),
            ],
          ),
          heightSpace3,
          CustomText.kText(otherUser.name, size: 15),
          Obx(() {
            final count = chatIconCon.unreadChatIds.where((i) => i == chat.id);
            return Row(
              children: [
                Expanded(child: CustomText.kText(chat.lastMessage, size: 12)),
                if (count.isNotEmpty) ...[
                  widthSpace3,
                  AppContainer(
                    padding: EdgeInsets.all(AppDimentions.screenPaddingXS * .8),
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    child: CustomText.kText(
                      count.length.toString(),
                      size: 12,
                      weight: FontWeight.w600,
                      color: white,
                    ),
                  ),
                ],
              ],
            );
          }),
        ],
      ),
    ),
  );
}
