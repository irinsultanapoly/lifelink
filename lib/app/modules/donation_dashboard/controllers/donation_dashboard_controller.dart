import 'package:lifelink/app/services/db_service.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

import '../../../data/data_keys.dart';
import '../../../data/models/models.dart';
import '../../../routes/app_pages.dart';

class DonationDashboardController extends GetxController {
  final donations = <BloodRequest>[].obs;

  @override
  void onInit() {
    super.onInit();
    getDonations();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  viewDonationDetail(int index) {
    GetStorage().write(kKeyDonationId, donations[index].id);
    Get.toNamed(Routes.DONATION);
  }

  void getDonations() {
    Get.find<DbService>()
        .getInprogressDonations()
        .then((value) => donations.value = value);
  }
}
