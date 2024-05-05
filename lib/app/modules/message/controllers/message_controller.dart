import 'package:get/get.dart';
import 'package:lifelink/app/data/data_keys.dart';
import 'package:lifelink/app/services/db_service.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

import '../../../data/models/models.dart';
import '../../../routes/app_pages.dart';

class MessageController extends GetxController {
  final conversations = <Conversation>[].obs;

  @override
  void onInit() {
    super.onInit();
    getConversations();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getConversations() {
    Get.find<DbService>()
        .genConversations(GetStorage().read(kKeyUserId))
        .then((value) => conversations.value = value);
  }

  gotoChat(int index) {
    GetStorage().write(kKeyConversationId, conversations[index].id);
    Get.toNamed(Routes.CHAT);
  }
}
