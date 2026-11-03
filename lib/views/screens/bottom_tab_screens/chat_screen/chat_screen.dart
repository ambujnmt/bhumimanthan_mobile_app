import 'package:bhumi_manthan/utils/app_imports.dart';

import 'chat_screen_controller.dart';
import 'model/chat_history_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with AutomaticKeepAliveClientMixin {
  final _con = Get.put(ChatScreenController());
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CustomAppbar(title: 'Chat History', showLeading: false),
      body: Obx(
        () => _con.isLoading.value
            ? AppLoader.widget()
            : _con.hasError.value
            ? AppRefreshIndicator(
                onRefresh: _con.refreshData,
                child: errorLoadingData(),
              )
            : ListView.separated(
                padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
                itemCount: _con.chatHistory.length,
                itemBuilder: (context, index) => _chatHistoryTile(
                  chat: _con.chatHistory[index],
                  currentUserId: _con.user!.id.toString(),
                ),
                separatorBuilder: (context, index) => heightSpace10,
              ),
      ),
    );
  }
}

Widget _chatHistoryTile({
  required ChatHistoryModel chat,
  required String currentUserId,
}) {
  final otherUser = chat.user.id == currentUserId ? chat.otherUser : chat.user;

  return InkWell(
    onTap: () => Get.toNamed(
      AppRoutes.userToAgentChatScreen,
      arguments: {'id': chat.property.id},
    ),
    child: AppContainer(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.kText(
                  chat.property.title,
                  size: 12,
                  weight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                heightSpace3,
                CustomText.kText(otherUser.name, size: 15),
                CustomText.kText(chat.lastMessage, size: 12),
              ],
            ),
          ),
          widthSpace5,
          const Icon(Icons.chevron_right, color: grey),
        ],
      ),
    ),
  );
}
