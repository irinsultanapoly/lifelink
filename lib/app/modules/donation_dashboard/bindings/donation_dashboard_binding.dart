import 'package:get/get.dart';

import '../controllers/donation_dashboard_controller.dart';

class DonationDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonationDashboardController>(
      () => DonationDashboardController(),
    );
  }
}
