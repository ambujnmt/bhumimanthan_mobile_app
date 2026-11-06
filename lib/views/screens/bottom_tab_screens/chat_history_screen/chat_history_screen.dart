import 'package:bhumi_manthan/utils/app_imports.dart';

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
      body: Obx(
        () => _con.isLoading.value
            ? AppLoader.widget()
            : _con.hasError.value
            ? AppRefreshIndicator(
                onRefresh: _con.refreshData,
                child: ApiErrorWidget(),
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
