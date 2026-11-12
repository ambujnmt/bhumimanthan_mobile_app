import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../utils/app_imports.dart';
import 'model/user_to_agent_chat_model.dart';
import 'user_to_agent_chat_screen_controller.dart';

class UserToAgentChatScreen extends StatefulWidget {
  const UserToAgentChatScreen({super.key});

  @override
  State<UserToAgentChatScreen> createState() => _UserToAgentChatScreenState();
}

class _UserToAgentChatScreenState extends State<UserToAgentChatScreen> {
  final controller = Get.put(UserToAgentChatScreenController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value || controller.data.value == null
          ? Scaffold(
              appBar: CustomAppbar(title: 'Chat'),
              body: AppRefreshIndicator(
                onRefresh: controller.refreshData,
                child: controller.isLoading.value
                    ? AppLoader.widget()
                    : ApiErrorWidget(),
              ),
            )
          : Scaffold(
              appBar: CustomAppbar(
                title: controller.data.value?.creator.name ?? 'Messages',
              ),
              body: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: controller.messagesRef
                          .orderBy('created_at', descending: true)
                          .limit(50)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          controller.setDisableTyping(true);
                          return ApiErrorWidget();
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          controller.setDisableTyping(true);
                          return AppLoader.widget();
                        }

                        controller.setDisableTyping(false);

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return NoDataAvailable(
                            title: 'No messages yet',
                            message: 'Send a message to start chatting.',
                            icon: Icons.chat_bubble_outline,
                          );
                        }
                        List messages = [];
                        messages.assignAll(
                          snapshot.data!.docs.map(
                            UserToAgentChatModel.fromDocument,
                          ),
                        );
                        return ListView.builder(
                          controller: controller.scrollController,
                          reverse: true,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];

                            final isMine =
                                message.senderId == controller.currentUserId;

                            return _MessageBubble(
                              message: message,
                              isMine: isMine,
                              time: formatDateTime(
                                message.createdAt.toString(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  _buildMessageInput(context),
                ],
              ),
            ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Obx(
        () => IgnorePointer(
          ignoring: controller.disableTyping.value,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: controller.messageController,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  style: CustomText.kTextStyle(),
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    hintStyle: CustomText.kTextStyle(color: grey),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimentions.boxRadiusS,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    // enabledBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(AppDimentions.boxRadiusS),
                    //   borderSide: BorderSide.none,
                    // ),
                    // focusedBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(AppDimentions.boxRadiusS),
                    //   borderSide: BorderSide(
                    //     color: Theme.of(context).colorScheme.primary,
                    //   ),
                    // ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Obx(() {
                return SizedBox(
                  height: 48,
                  width: 48,
                  child: IconButton.filled(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        AppColors.primary,
                      ),
                    ),
                    tooltip: 'Send message',
                    onPressed: controller.isSending.value
                        ? null
                        : controller.sendMessage,
                    icon: controller.isSending.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: white,
                            ),
                          )
                        : const Icon(Icons.send_rounded),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final UserToAgentChatModel message;
  final bool isMine;
  final String time;

  const _MessageBubble({
    required this.message,
    required this.isMine,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.fromLTRB(14, 10, 10, 6),
        decoration: BoxDecoration(
          color: isMine
              ? AppColors.secondary.withValues(alpha: .7)
              : AppColors.hint,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMine ? 16 : 4),
            bottomRight: Radius.circular(isMine ? 4 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                message.message,
                style: TextStyle(
                  color: isMine ? Colors.white : Colors.black87,
                  fontSize: 15,
                  height: 1.35,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: isMine ? Colors.white70 : Colors.black54,
                    fontSize: 10,
                  ),
                ),
                if (isMine) ...[
                  const SizedBox(width: 4),
                  Icon(
                    message.isSeen
                        ? Icons.done_all_rounded
                        : Icons.done_rounded,
                    size: 15,
                    color: message.isSeen
                        ? Colors.lightBlueAccent
                        : Colors.white70,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
