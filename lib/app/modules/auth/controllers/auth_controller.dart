import 'package:flutter/material.dart';
import 'package:lifelink/app/data/models/models.dart';
import 'package:lifelink/app/extensions/string_ext.dart';
import 'package:lifelink/app/routes/app_pages.dart';
import 'package:lifelink/app/services/db_service.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

import '../../../data/data_keys.dart';
import '../../../util/app_constants.dart';

// ignore: constant_identifier_names
enum AuthType { SIGNIN, SIGNUP }

class AuthController extends GetxController {
  final _dbService = Get.find<DbService>();
  final GetStorage _box = GetStorage();

  TextEditingController tcUserName = TextEditingController();
  TextEditingController tcUserMobile = TextEditingController();
  TextEditingController tcUserPass = TextEditingController();
  TextEditingController tcUserConfirmPass = TextEditingController();
  TextEditingController tcUserEmail = TextEditingController();

  final userBloodGroup = ''.obs;

  final authType = AuthType.SIGNIN.obs;

  final error = ''.obs;
  final errorName = ''.obs;
  final errorMobile = ''.obs;
  final errorPass = ''.obs;
  final errorConfirmPass = ''.obs;
  final errorEmail = ''.obs;
  final errorGroup = ''.obs;

  final hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    bindListeners();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    //Dispose Controllers
    tcUserName.dispose();
    tcUserMobile.dispose();
    tcUserPass.dispose();
    tcUserConfirmPass.dispose();
    tcUserEmail.dispose();
  }

  void bindListeners() {
    tcUserName.addListener(() {
      errorName.value = '';
      error.value = '';
    });
    tcUserMobile.addListener(() {
      errorMobile.value = '';
      error.value = '';
      _box.write(kKeyUserEmail, tcUserMobile.text);
    });
    tcUserPass.addListener(() {
      errorPass.value = '';
      error.value = '';
      _box.write(kKeyUserPass, tcUserPass.text);
    });
    tcUserConfirmPass.addListener(() {
      errorConfirmPass.value = '';
      error.value = '';
    });
    tcUserEmail.addListener(() {
      errorEmail.value = '';
      error.value = '';
    });
  }

  switchAuthType() {
    authType.value = authType.value == AuthType.SIGNIN
        ? AuthType.SIGNUP
        : authType.value = AuthType.SIGNIN;
    _box.write(kKeyUserLastAuthType,
        authType.value == AuthType.SIGNIN ? kAuthTypeLogin : kAuthTypeSignup);
    clearErrors();
    clearMobile();
    clearPassword();
    if (authType.value == AuthType.SIGNIN) {
      tcUserMobile.text = _box.read(kKeyUserEmail) ?? '';
      tcUserPass.text = _box.read(kKeyUserPass) ?? '';
    }
  }

  void validateFields() {
    hasError.value = false;
    //validate common data first
    //Mobile
    if (!tcUserMobile.text.isPhoneNumber || !tcUserMobile.text.isValidMobile) {
      hasError.value = true;
      errorMobile.value = 'auth_error_mobile'.tr;
    }
    //Pass
    if (!tcUserPass.text.isValidPassword) {
      hasError.value = true;
      errorPass.value = 'auth_error_password_length'.tr;
    }

    //No need to check rest if sign in
    if (authType.value == AuthType.SIGNIN) return;

    //Name
    if (!tcUserName.text.isValidName) {
      hasError.value = true;
      errorName.value = 'auth_error_name'.tr;
    }
    //Confirm Pass
    if (tcUserConfirmPass.text != tcUserPass.text) {
      hasError.value = true;
      errorConfirmPass.value = 'auth_error_password_not_matched'.tr;
    }
    //Email
    if (tcUserEmail.text.isNotEmpty && !tcUserEmail.text.isEmail) {
      hasError.value = true;
      errorEmail.value = 'auth_error_email'.tr;
    }
    //Blood Group
    if (userBloodGroup.isEmpty ||
        !kBloodGroups.contains(userBloodGroup.value)) {
      hasError.value = true;
      errorGroup.value = 'auth_error_group'.tr;
    }
  }

  void clearErrors() {
    error.value = '';
    errorName.value = '';
    errorMobile.value = '';
    errorPass.value = '';
    errorConfirmPass.value = '';
    errorEmail.value = '';
    errorGroup.value = '';
    hasError.value = false;
  }

  void clearPassword() {
    tcUserPass.clear();
    tcUserConfirmPass.clear();
  }

  void clearMobile() {
    tcUserMobile.clear();
  }

  void updateGroup(String? value) {
    printInfo(info: 'updateGroup >>> value: $value');
    if (value != null && kBloodGroups.contains(value)) {
      errorGroup.value = '';
      userBloodGroup.value = value;
    }
  }

  void authenticateUser() async {
    printInfo(info: 'authenticateUser => Auth Type: ${authType.value}');
    //Hide keyboard first
    hideKeyBoard();
    //Check inputted data
    validateFields();
    //Check if there is any validation error
    printInfo(info: 'authenticateUser => hasError: $hasError');
    if (hasError.isFalse) {
      Get.showLoader();
      if (authType.value == AuthType.SIGNIN) {
        printInfo(info: 'authenticateUser => Log In ->');
        var isValidUser = await _dbService.existUserByMobileAndPassword(
            tcUserMobile.text, tcUserPass.text);
        if (isValidUser) {
          Get.hideLoader();
          Get.showAppSnackbar("Login success!");
          Get.toNamed(Routes.HOME);
        } else {
          Get.hideLoader();
          error.value = "Mobile or Password error!";
        }
      } else {
        printInfo(info: 'authenticateUser => Register ->');
        var isUserExist = await _dbService.existByMobile(tcUserMobile.text);
        if (isUserExist) {
          Get.hideLoader();
          Get.showAppSnackbar("User already exist! Please login");
        } else {
          await _dbService
              .createUser(User(
                  mobile: tcUserMobile.text,
                  pass: tcUserPass.text,
                  name: tcUserName.text,
                  bloodGroup: userBloodGroup.value))
              .then((value) {
            Get.hideLoader();
            Get.showAppSnackbar("User creation success!");
            Get.toNamed(Routes.HOME);
          }).onError((error, stackTrace) {
            printError(info: '$error');
            this.error.value = '$error';
            Get.hideLoader();
          });
        }
      }
    }
  }
}
