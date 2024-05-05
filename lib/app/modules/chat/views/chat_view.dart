import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifelink/app/modules/chat/views/chat_item.dart';

import 'package:super_ui_kit/super_ui_kit.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CSHomeWidget(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        children: [
          CSHeader(
            title: 'Messages',
          ),
          verticalSpaceSmall,
          Row(
            children: [
              Expanded(
                flex: 4,
                  child: CSInputField(controller: controller.tcMessage)),
              Expanded(child: CSButton(title: "SEND", onTap: ()=> controller.sendMessage(),))
            ],
          ),
          Expanded(
            child: Obx(
              () => LiveList.options(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: animationItemBuilder(
                  (index) => ChatItem(
                    controller.chats[index],
                  ),
                ),
                itemCount: controller.chats.length,
                options: kAnimationOptions,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
