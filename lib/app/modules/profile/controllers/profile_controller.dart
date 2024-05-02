import 'package:flutter/material.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

import '../../../routes/app_pages.dart';
import '../../../services/db_service.dart';
import '../../../util/app_constants.dart';

enum ProfileEditMode { profile, group, mobile, pass, noEdit }

class ProfileController extends GetxController {
  final DbService dbService = Get.find<DbService>();

  final tcName = TextEditingController();
  final fnName = FocusNode();
  final tcPass = TextEditingController();
  final tcConfirmPass = TextEditingController();

  final bloodGroup = kBloodGroups.first.obs;

  final error = ''.obs;
  final errorName = ''.obs;
  final errorEmail = ''.obs;
  final errorGroup = ''.obs;

  final hasError = false.obs;
  final editMode = ProfileEditMode.noEdit.obs;

  @override
  void onInit() {
    super.onInit();
    bindListeners();
    bindInitialData();
  }

  @override
  void onClose() {
    tcName.dispose();
    fnName.dispose();
    tcPass.dispose();
    tcConfirmPass.dispose();
    super.onClose();
  }

  void bindListeners() {
    tcName.addListener(() {
      errorName.value = '';
      error.value = '';
    });
    // tcName.text = dbService.profile.value?.name ?? '';
  }

  void bindInitialData() {
    bloodGroup.value =
        // dbService.profile.value?.bloodGroup ??
    kBloodGroups.first;
  }

  void onEditButtonTap() {
    //hide keyboard first...
    hideKeyBoard();
    //check edit mode..
    //Submit changes
    switch (editMode.value) {
      case ProfileEditMode.profile:
        updateProfile();
        editMode.value = ProfileEditMode.noEdit;
        break;
      case ProfileEditMode.group:
        updateBloodGroup();
        editMode.value = ProfileEditMode.noEdit;
        break;
      case ProfileEditMode.mobile:
        updateMobile();
        editMode.value = ProfileEditMode.noEdit;
        break;
      case ProfileEditMode.pass:
        updatePass();
        editMode.value = ProfileEditMode.noEdit;
        break;
      case ProfileEditMode.noEdit:
        editMode.value = ProfileEditMode.profile;
        fnName.requestFocus();
        break;
    }
  }

  logOut() async {
    Get.showLoader();
    // await _authService.logOutUser();
    Get.hideLoader();
    Get.offAllNamed(Routes.AUTH);
  }

  changeBloodGroup() {
    Get.showDialog(
      "profile_dialog_group_desc".tr,
      title: 'profile_dialog_group_title'.tr,
      dialogType: DialogType.alert,
      onConfirm: () {
        Get.back();
        editMode.value = ProfileEditMode.group;
      },
      onCancel: () => {},
    );
  }

  changeMobile() {
    Get.snackbar('app_under_development'.tr, 'app_coming_soon'.tr);
  }

  changePass() {
    Get.snackbar('app_under_development'.tr, 'app_coming_soon'.tr);
  }

  updateProfile() {
    //Hide keyboard first
    hideKeyBoard();
    //Check inputted data
    validateFields();
    //Check if there is any validation error
    if (hasError.isFalse) {
      // if (dbService.profile.value != null) {
      //   dbService.realm?.write(
      //     () => {
      //       dbService.profile.value?.name = tcName.text,
      //       dbService.profile.refresh(),
      //       Get.snackbar("profile_snack_profile_title".tr,
      //           "profile_snack_profile_msg".tr)
      //     },
      //   );
      // }
    }
  }

  updateBloodGroup() {
    //Hide keyboard first
    hideKeyBoard();
    //Check inputted data
    validateFields();
    //Check if there is any validation error
    if (hasError.isFalse) {
      // if (dbService.profile.value != null &&
      //     kBloodGroups.contains(bloodGroup.value)) {
      //   dbService.realm?.write(
      //     () {
      //       dbService.profile.value?.bloodGroup = bloodGroup.value;
      //       dbService.profile.refresh();
      //       Get.snackbar(
      //           "profile_snack_group_title".tr, "profile_snack_group_msg".tr);
      //     },
      //   );
      // }
    }
  }

  updateMobile() {
    //Hide keyboard first
    hideKeyBoard();
    //Check inputted data
    validateFields();
    //Check if there is any validation error
    if (hasError.isFalse) {
      // if (dbService.profile.value != null) {
      //   dbService.realm?.write(
      //     () => {
      //       dbService.profile.value?.mobile = tcName.text,
      //     },
      //   );
      // }
    }
  }

  updatePass() {
    //Hide keyboard first
    hideKeyBoard();
    //Check inputted data
    validateFields();
    //Check if there is any validation error
    if (hasError.isFalse) {
      //TODO: Need to implement password change...
    }
  }

  void validateFields() {
    hasError.value = false;
    //validate common data first
    //Mobile
    // if (!tcName.text.isValidName) {
    //   hasError.value = true;
    //   errorName.value = 'auth_error_mobile'.tr;
    // }
    //Blood Group
    if (bloodGroup.isEmpty || !kBloodGroups.contains(bloodGroup.value)) {
      hasError.value = true;
      errorGroup.value = 'auth_error_group'.tr;
    }
  }

  void onAvailabilityChange(bool value) {
    // dbService.realm?.write(() {
    //   dbService.profile.value?.availability =
    //       value ? Availability.AVAILABLE : Availability.UNAVAILABLE;
    //   dbService.profile.refresh();
    // });
  }

  void updateGroup(String? value) {
    printInfo(info: 'updateGroup >>> value: $value');
    if (value != null && kBloodGroups.contains(value)) {
      errorGroup.value = '';
      bloodGroup.value = value;
    }
  }
}
