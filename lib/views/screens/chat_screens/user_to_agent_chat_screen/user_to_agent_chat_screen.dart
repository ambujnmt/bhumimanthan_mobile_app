import '../../../../utils/app_imports.dart';
import 'user_to_agent_chat_model.dart';
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
    return Scaffold(
      appBar: CustomAppbar(title: 'Messages'),
      body: Column(
        children: [
          Expanded(child: _buildMessages()),
          _buildMessageInput(context),
        ],
      ),
    );
  }

  Widget _buildMessages() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.hasError.value) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.cloud_off_outlined,
                size: 42,
                color: Colors.grey,
              ),
              const SizedBox(height: 12),
              const Text('Unable to load messages'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: controller.retryLoading,
                child: const Text('Try again'),
              ),
            ],
          ),
        );
      }

      if (controller.messages.isEmpty) {
        return const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.chat_bubble_outline, size: 48, color: Colors.grey),
              SizedBox(height: 12),
              Text(
                'No messages yet',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Text(
                'Send a message to start chatting.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        controller: controller.scrollController,
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: controller.messages.length,
        itemBuilder: (context, index) {
          final message = controller.messages[index];

          final isMine = message.senderId == controller.currentUserId;

          return _MessageBubble(
            message: message,
            isMine: isMine,
            time: formatDateTime(message.createdAt.toString()),
          );
        },
      );
    });
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
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
                  borderRadius: BorderRadius.circular(AppDimentions.boxRadiusS),
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
                  backgroundColor: WidgetStatePropertyAll(AppColors.primary),
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
