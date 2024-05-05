import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lifelink/app/data/data_keys.dart';
import 'package:lifelink/app/data/models/models.dart';
import 'package:lifelink/app/services/db_service.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

class ChatController extends GetxController {
  final chats = <Message>[].obs;

  final tcMessage = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getChats();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getChats() {
    tcMessage.clear();
    var conversationId = GetStorage().read(kKeyConversationId);
    if (conversationId == null) {
      Get.showAppSnackbar("Something went wrong!");
      Get.back();
    } else {
      Get.find<DbService>().getMessages(conversationId).then((value) => chats.value = value);
    }
  }

  sendMessage() {
    var conversationId = GetStorage().read(kKeyConversationId);
    if (conversationId == null) {
      Get.showAppSnackbar("Something went wrong!");
      Get.back();
    } else {
      Get.find<DbService>()
          .createMessage(
              conversationId, GetStorage().read(kKeyUserId), tcMessage.text)
          .then((value) => getChats());
    }
  }
}
