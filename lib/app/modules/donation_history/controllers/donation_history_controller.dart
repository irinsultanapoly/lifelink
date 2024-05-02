import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class DonationHistoryController extends GetxController {
  final donations = <String>[].obs;
  @override
  void onInit() {
    super.onInit();
    // donations.add(
    //   Donation(
    //     ObjectId(),
    //     kOrgId,
    //     ObjectId().toString(),
    //     DateTime.now(),
    //     bloodGroup: "O+",
    //     patientProblem: "Dengue Fever",
    //     neededAt: DateTime.now().add(
    //       const Duration(days: 7),
    //     ),
    //     seekerInfo: UserInfo("John", "01000200300"),
    //     address: Address("John", "01000200300", addressLine: "Square Hospital"),
    //   ),
    // );
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
    Get.toNamed(Routes.DONATION);
  }
}
