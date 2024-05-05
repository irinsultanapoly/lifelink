import 'package:flutter/material.dart';
import 'package:lifelink/app/data/data_keys.dart';
import 'package:lifelink/app/data/models/models.dart';
import 'package:lifelink/app/modules/donation/controllers/donation_controller.dart';
import 'package:lifelink/app/services/db_service.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

import '../../../util/app_constants.dart';

enum RequestType { blood, platelet }

class DonationRequestController extends GetxController {
  final _dbService = Get.find<DbService>();
  final _box = GetStorage();

  final requestType = RequestType.blood.obs;

  final userBloodGroup = kBloodGroups.first.obs;
  final errorBloodGroup = ''.obs;

  final tcAmount = TextEditingController();
  final errorAmount = ''.obs;

  final tcPatientName = TextEditingController();
  final errorPatientName = ''.obs;

  final tcPatientContactNo = TextEditingController();
  final errorPContactNo = ''.obs;

  final tcPatientProblem = TextEditingController();
  final errorPProblem = ''.obs;

  final tcHospital = TextEditingController();
  final errorHospital = ''.obs;

  final tcBedNumber = TextEditingController();
  final errorBedNumber = ''.obs;

  final tcDonationDate = TextEditingController();
  final errorDonationDate = ''.obs;

  final tcDonationTime = TextEditingController();
  final errorDonationTime = ''.obs;

  final isCritical = false.obs;

  final error = ''.obs;
  final hasError = false.obs;

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

  void changeReqType(RequestType reqType) {
    requestType.value = reqType;
    printInfo(info: "changeReqType => requestType: $reqType");
  }

  setBloodGroup(String? group) {
    if (kBloodGroups.contains(group)) {
      userBloodGroup.value = group!;
    }
  }

  void changeCritical(bool? value) {
    isCritical.value = isCritical.toggle().value;
  }

  saveDonationData() async {
    hideKeyBoard();
    //TODO: Validate fields

    var requesterId = _box.read(kKeyUserId);
    if (requesterId == null) return;
    var bloodReq = BloodRequest(
      -1,
      requestType: requestType.value.name,
      bloodGroup: userBloodGroup.value,
      amount: int.parse(tcAmount.text),
      pName: tcPatientName.text,
      pContact: tcPatientContactNo.text,
      pProblem: tcPatientProblem.text,
      hospital: tcHospital.text,
      bedNumber: tcBedNumber.text,
      donationDate: tcDonationDate.text,
      donationTime: tcDonationTime.text,
      isCritical: isCritical.value,
      requesterId: requesterId,
      status: DonationStatus.inprogress.name,
    );
    int rowId = await _dbService.createBloodRequest(bloodReq);
    if (rowId < 0) {
      Get.showAppSnackbar("Something went wrong!");
    } else {
      Get.showDialog(
        'Request submitted. Please wait for the donor.',
        onConfirm: () {
          Get.back(); // Dialog close
          Get.back();
        },
        dialogType: DialogType.general,
      );
    }
  }
}
