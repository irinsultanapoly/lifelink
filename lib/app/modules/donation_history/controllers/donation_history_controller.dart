import 'package:lifelink/app/data/data_keys.dart';
import 'package:lifelink/app/data/models/models.dart';
import 'package:lifelink/app/services/db_service.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

import '../../../routes/app_pages.dart';

enum DonationHistoryType { donations, requests }

class DonationHistoryController extends GetxController {
  final donations = <BloodRequest>[].obs;

  @override
  void onInit() {
    super.onInit();
    getBloodRequests();
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

  void getBloodRequests() {
    var historyType = GetStorage().read(kKeyDonationHistoryType);
    var userId = GetStorage().read(kKeyUserId);
    if (historyType == null || userId == null) return;
    if (historyType == DonationHistoryType.requests.name) {
      Get.find<DbService>()
          .getBloodRequestsByRequesterId(userId)
          .then((value) => donations.value = value);
    } else {
      Get.find<DbService>()
          .getBloodRequestsByDonorId(userId)
          .then((value) => donations.value = value);
    }
  }
}
