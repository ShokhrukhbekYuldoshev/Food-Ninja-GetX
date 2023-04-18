import 'package:flutter/material.dart';
import 'package:ninja_theme/ninja_theme.dart';
import 'package:ninjafood/app/controllers/controllers.dart';
import 'package:ninjafood/app/models/chat_model.dart';
import 'package:ninjafood/app/helper/helper.dart';
import 'package:ninjafood/app/models/message_chat_model.dart';

class GroupChatItem extends StatelessWidget {
  final GroupChatModel groupChatItem;
  final Animation<double> animation;
  final Function(GroupChatModel) onTap;

  const GroupChatItem({super.key, required this.groupChatItem, required this.animation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final currentUser = UserController.instance.getCurrentUser;
    final _user =
        {groupChatItem.receiverUser, groupChatItem.senderUser}.firstWhere((element) => element.uid != currentUser!.uid);
    return AnimationItem(
      animation: animation,
      child: AppPadding(
        padding: AppEdgeInsets.only(bottom: AppGapSize.medium),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Material(
            child: InkWell(
              onTap: () => onTap(groupChatItem),
              child: ColoredBox(
                color: isDarkMode ? ThemeColors.backgroundTextFormDark() : Theme.of(context).colorScheme.onPrimary,
                child: AppPadding.medium(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppPadding(
                        padding: AppEdgeInsets.only(right: AppGapSize.medium),
                        child: AppNetworkImage(
                            borderRadius: 64,
                            width: kToolbarHeight,
                            height: kToolbarHeight,
                            url: _user.photoUrl ?? '',
                            fit: BoxFit.cover),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: AppText.bodyLarge(
                                      text: _user.getName(),
                                      fontWeight: FontWeight.w400,
                                      textAlign: TextAlign.start,
                                      maxLines: 1),
                                ),
                                AppPadding(
                                  padding: AppEdgeInsets.only(left: AppGapSize.medium),
                                  child: AppText.bodyMedium(
                                      text: convertTimeStamp(groupChatItem.lastMessageChat.timestamp)),
                                ),
                              ],
                            ),
                            Builder(builder: (context) {
                              String message = groupChatItem.lastMessageChat.message.toString();
                              if (groupChatItem.lastMessageChat.messageChatType != MessageChatType.text) {
                                message =
                                    MessageChatFile.fromJson(groupChatItem.lastMessageChat.message).message.toString();
                              }

                              return AppText.bodyMedium(
                                text: message,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
