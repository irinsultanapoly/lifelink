import 'package:get/get.dart';

import '../controllers/donation_request_controller.dart';

class DonationRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonationRequestController>(
      () => DonationRequestController(),
    );
  }
}
