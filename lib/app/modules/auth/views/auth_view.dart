import 'package:flutter/material.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

import '../../../data/asset_keys.dart';
import '../../../util/app_constants.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CSHomeWidget(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          verticalSpaceLarge,
          Obx(() => controller.authType.value == AuthType.SIGNIN
              ? verticalSpaceLarge
              : verticalSpaceTiny),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              kAppIcon,
              width: 90,
              height: 90,
            ),
          ),
          verticalSpaceTiny,
          Align(
            alignment: Alignment.center,
            child: CSText('auth_welcome'.tr),
          ),
          verticalSpaceMedium,
          Obx(
            () => controller.authType.value == AuthType.SIGNUP
                ? CSInputField(
                    controller: controller.tcUserName,
                    placeholder: 'auth_label_name'.tr,
                    errorText: controller.errorName.isNotEmpty
                        ? controller.errorName.value
                        : null,
                  )
                : emptyWidget,
          ),
          Obx(
            () => controller.authType.value == AuthType.SIGNUP
                ? verticalSpaceRegular
                : emptyWidget,
          ),
          Obx(
            () => CSInputField(
              controller: controller.tcUserMobile,
              placeholder: 'auth_label_mobile'.tr,
              inputType: TextInputType.phone,
              errorText: controller.errorMobile.isNotEmpty
                  ? controller.errorMobile.value
                  : null,
            ),
          ),
          verticalSpaceRegular,
          Obx(
            () => CSInputField(
              controller: controller.tcUserPass,
              placeholder: 'auth_label_password'.tr,
              isPassword: true,
              errorText: controller.errorPass.isNotEmpty
                  ? controller.errorPass.value
                  : (controller.authType.value == AuthType.SIGNIN)
                      ? controller.error.isNotEmpty
                          ? controller.error.value
                          : null
                      : null,
            ),
          ),
          Obx(
            () => controller.authType.value == AuthType.SIGNUP
                ? verticalSpaceRegular
                : emptyWidget,
          ),
          Obx(
            () => controller.authType.value == AuthType.SIGNUP
                ? CSInputField(
                    controller: controller.tcUserConfirmPass,
                    placeholder: 'auth_label_confirm_password'.tr,
                    isPassword: true,
                    errorText: controller.errorConfirmPass.isNotEmpty
                        ? controller.errorConfirmPass.value
                        : null,
                  )
                : emptyWidget,
          ),
          Obx(
            () => controller.authType.value == AuthType.SIGNUP
                ? verticalSpaceRegular
                : emptyWidget,
          ),
          Obx(
            () => controller.authType.value == AuthType.SIGNUP
                ? CSDropDown(
                    [...kBloodGroups],
                    header: "auth_label_group".tr,
                    onValueChange: (value) => controller.updateGroup(value),
                    error: controller.errorGroup.value,
                  )
                : emptyWidget,
          ),
          verticalSpaceMedium,
          Obx(
            () => CSButton(
              title: controller.authType.value == AuthType.SIGNIN
                  ? 'auth_button_sign_in'.tr
                  : 'auth_button_sign_up'.tr,
              onTap: () => controller.authenticateUser(),
            ),
          ),
          verticalSpaceLarge,
          Align(
            alignment: Alignment.center,
            child: Obx(
              () => CSTupleText(
                text1: controller.authType.value == AuthType.SIGNIN
                    ? 'auth_instruction_sign_up_part1'.tr
                    : 'auth_instruction_sign_in_part1'.tr,
                text2: controller.authType.value == AuthType.SIGNIN
                    ? 'auth_instruction_sign_up_part2'.tr
                    : 'auth_instruction_sign_in_part2'.tr,
                onTap: () => controller.switchAuthType(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
