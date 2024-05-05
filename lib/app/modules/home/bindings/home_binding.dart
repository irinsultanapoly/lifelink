import 'package:get/get.dart';

import '../../dashboard/controllers/dashboard_controller.dart';
import '../../donation_dashboard/controllers/donation_dashboard_controller.dart';
import '../../message/controllers/message_controller.dart';
import '../../setting/controllers/setting_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<DonationDashboardController>(
          () => DonationDashboardController(),
    );
    Get.lazyPut<MessageController>(
          () => MessageController(),
    );
    Get.lazyPut<SettingController>(
      () => SettingController(),
    );
  }
}
