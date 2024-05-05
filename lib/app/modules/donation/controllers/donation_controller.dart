import 'package:lifelink/app/data/data_keys.dart';
import 'package:lifelink/app/data/models/models.dart';
import 'package:lifelink/app/routes/app_pages.dart';
import 'package:lifelink/app/services/db_service.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

enum DonationStatus { inprogress, accepted, completed, rejected }

class DonationController extends GetxController {
  final donation = BloodRequest(-1,
          requestType: "",
          bloodGroup: "",
          amount: 0,
          pName: "",
          hospital: "",
          donationDate: "",
          donationTime: "",
          isCritical: false,
          requesterId: "",
          status: "")
      .obs;

  final editMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    getDonationInfo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  saveDonationData() {}

  void getDonationInfo() {
    var donationId = GetStorage().read(kKeyDonationId);
    if (donationId == null) return;
    Get.find<DbService>().getBloodRequestById(donationId).then((value) {
      if (value == null) {
        Get.showDialog("Error getting donation info!", onConfirm: () {
          Get.back(); //Close Dialog
          Get.back();
        }, dialogType: DialogType.error);
      } else {
        donation.value = value;
      }
    });
  }

  acceptDonationReq() {
    var donorId = GetStorage().read(kKeyUserId);
    if (donorId == null) return;
    Get.find<DbService>()
        .acceptBloodReq(donation.value.id, donorId)
        .then((value) {
      Get.showDialog("Thank you for saving life");
      getDonationInfo();
    });
  }

  gotoMessage() async {
    var coversationId = await Get.find<DbService>().getConversation(
        donation.value.requesterId, donation.value.donorId ?? '');
    if (coversationId == null) {
      Get.find<DbService>()
          .createConversation(
              donation.value.requesterId, donation.value.donorId ?? '')
          .then((value) => gotoMessage());
    } else {
      GetStorage().write(kKeyConversationId, coversationId);
      Get.toNamed(Routes.CHAT);
    }
  }
}
