import 'package:flutter/material.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

import '../../../data/asset_keys.dart';
import '../../../util/app_constants.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CSHomeWidget(
      floatingActionButton: Obx(
        () => CSIconButton(
          icon: controller.editMode.value != ProfileEditMode.noEdit
              ? Icons.check_sharp
              : Icons.edit_sharp,
          onTap: () => controller.onEditButtonTap(),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        children: [
          CSHeader(
            title: 'profile_title'.tr,
          ),
          verticalSpaceSmall,
          CSCard(
            children: [
              verticalSpaceSmall,
              // ("controller.dbService.profile.value?.imgSrc.isEmpty".isNotEmpty ?? true)
              //     ?
              Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  radius: 50,
                  foregroundColor: Get.theme.colorScheme.secondary,
                  backgroundColor: Get.theme.colorScheme.secondary,
                  backgroundImage: const AssetImage(kProfileImage),
                ),
              )
              // : Align(
              //     alignment: Alignment.topCenter,
              //     child: CircleAvatar(
              //       radius: 50,
              //       foregroundColor: Get.theme.colorScheme.secondary,
              //       backgroundColor: Get.theme.colorScheme.secondary,
              //       backgroundImage: NetworkImage(
              //           controller.dbService.profile.value!.imgSrc),
              //     ),
              //   )
              ,
              verticalSpaceTiny,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => CSText(
                      "controller.dbService.profile.value?.bloodGroup" ??
                          'profile_error_group'.tr,
                      color: Get.theme.colorScheme.primary,
                      style: Get.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CSText("controller.dbService.profile.value?.mobile" ??
                        'profile_error_mobile'.tr)
                  ],
                ),
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (controller.editMode.value != ProfileEditMode.profile)
                        ? CSText.title(
                            "controller.dbService.profile.value?.name" ??
                                'profile_error_name'.tr)
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: CSInputField(
                                maxLines: 1,
                                controller: controller.tcName,
                                focusNode: controller.fnName,
                                placeholder: 'profile_label_name'.tr,
                                inputType: TextInputType.name,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return const Icon(Icons.check);
                          }
                          return const Icon(Icons.close);
                        }),
                        activeColor: Colors.green,
                        value: true,
                        // controller.dbService.profile.value?.availability ==
                        //     Availability.AVAILABLE,
                        onChanged: (value) =>
                            controller.onAvailabilityChange(value),
                      ),
                    ),
                    // const CsIcon(
                    //   Icons.check_circle_sharp,
                    //   color: Colors.green,
                    // ),
                    CSText(
                      // (controller.dbService.profile.value?.availability ==
                      //         Availability.AVAILABLE)
                      //     ?
                      'READY TO DONATE'
                          // : 'NOT READY YET'
                        ,
                      color:
                          // (controller.dbService.profile.value?.availability ==
                          //         Availability.AVAILABLE)
                          //     ?
                          Colors.green
                              // : Colors.grey
                      ,
                    ),
                    horizontalSpaceRegular
                  ],
                ),
              ),
            ],
          ),
          verticalSpaceLarge,
          Expanded(
            child: ListView(
              children: [
                Obx(
                  () => (controller.editMode.value == ProfileEditMode.group)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CSDropDown(
                            [...kBloodGroups],
                            header: "auth_label_group".tr,
                            onValueChange: (value) =>
                                controller.updateGroup(value),
                            value: controller.bloodGroup.value,
                            error: controller.errorGroup.value,
                          ))
                      : ProfileItem(
                          iconData: Icons.bloodtype,
                          title: 'profile_item_change_group'.tr,
                          onTap: () => controller.changeBloodGroup(),
                        ),
                ),
                ProfileItem(
                  iconData: Icons.call_end_sharp,
                  title: 'profile_item_change_mobile'.tr,
                  onTap: () => controller.changeMobile(),
                ),
                ProfileItem(
                  iconData: Icons.password_sharp,
                  title: 'profile_item_change_password'.tr,
                  onTap: () => controller.changePass(),
                ),
                ProfileItem(
                  iconData: Icons.logout_sharp,
                  title: 'profile_item_logout'.tr,
                  onTap: (() => controller.logOut()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
