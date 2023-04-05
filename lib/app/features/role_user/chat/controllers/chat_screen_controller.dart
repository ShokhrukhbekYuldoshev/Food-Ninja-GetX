import 'package:get/get.dart';
import 'package:ninjafood/app/core/core.dart';
import 'package:ninjafood/app/models/chat_model.dart';
import 'package:ninjafood/app/features/role_user/tabs/controllers/tabs_controller.dart';
import 'package:ninjafood/app/global_controller/db_controller.dart';
import 'package:ninjafood/app/global_controller/global_controller.dart';
import 'package:ninjafood/app/models/message_chat_model.dart';
import 'package:ninjafood/app/routes/routes.dart';

class ChatScreenController extends BaseController {
  final TabsController tabsController;
  final AuthController authController = Get.find<AuthController>();
  final DatabaseController databaseController = Get.find<DatabaseController>();

  ChatScreenController({required this.tabsController});

  RxList<ChatModel> chatList = <ChatModel>[].obs;

  @override
  void onInit() {
    authController.chatList.listen((event) {
      chatList.assignAll(event);
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onTapChat(ChatModel chatModel) {
    Get.toNamed(AppRouteProvider.chatDetailsScreen, arguments: chatModel);
  }

  Future<void> handleOnTapChat() async {
    final currentUserId = authController.currentUser?.uid;
    final adminUserId = authController.adminUser?.uid;
    if (currentUserId == null || adminUserId == null) {
      throw Exception('currentUserId or adminUserId is null');
    }

    final MessageChat messageChat = MessageChat.createMessageChat(
        uid: currentUserId,
        senderId: currentUserId,
        receiverId: adminUserId,
        message: 'Hello',
        messageChatType: MessageChatType.text);
    final response = await databaseController.insertMessageChat(
      messageChat: messageChat, currentUserModel: authController.currentUser!,);
    response.fold((l) => print(l), (r) {
      // Get.toNamed(AppRouteProvider.chatDetailsScreen);
    });
  }
}
