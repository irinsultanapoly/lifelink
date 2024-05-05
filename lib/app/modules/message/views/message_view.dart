import 'package:flutter/material.dart';
import 'package:lifelink/app/modules/message/views/conversation_item.dart';

import 'package:super_ui_kit/super_ui_kit.dart';

import '../controllers/message_controller.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpaceSmall,
        CSHeader(
          title: 'Conversations',
          headerType: HeaderType.other,
          showLeading: false,
        ),
        verticalSpaceSmall,
        Expanded(
          child: Obx(
                () => LiveList.options(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: animationItemBuilder(
                    (index) => ConversationItem(
                  controller.conversations[index],
                  onTap: () => controller.gotoChat(index),
                ),
              ),
              itemCount: controller.conversations.length,
              options: kAnimationOptions,
            ),
          ),
        ),
      ],
    );
  }
}
