import 'package:flutter/material.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

import '../../../util/app_constants.dart';

enum RequestType { blood, platelet }

class DonationRequestController extends GetxController {
  final requestType = RequestType.blood.obs;

  final userBloodGroup = kBloodGroups.first.obs;
  final errorBloodGroup = ''.obs;

  final error = ''.obs;
  final hasError = false.obs;

  final tcAmount = TextEditingController();
  final errorAmount = ''.obs;

  // final tcAmount = TextEditingController();
  // final errorAmount = ''.obs;

  // final tcAmount = TextEditingController();
  // final errorAmount = ''.obs;

  // final tcAmount = TextEditingController();
  // final errorAmount = ''.obs;

  // final tcAmount = TextEditingController();
  // final errorAmount = ''.obs;

  // final tcAmount = TextEditingController();
  // final errorAmount = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  saveDonationData() {
    Get.showDialog(
      'Request submitted. Please wait for the donor.',
      onConfirm: () => Get.back(),
      dialogType: DialogType.general,
    );
  }

  void changeReqType(RequestType reqType) {
    requestType.value = reqType;
    printInfo(info: "changeReqType => requestType: $reqType");
  }

  setBloodGroup(String? group) {
    if (kBloodGroups.contains(group)) {
      userBloodGroup.value = group!;
    }
  }
}
