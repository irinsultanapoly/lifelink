import 'package:flutter/material.dart';
import 'package:lifelink/app/data/models/models.dart';

import 'package:super_ui_kit/super_ui_kit.dart';

import '../../../data/asset_keys.dart';
import '../controllers/donation_controller.dart';
import 'row_item.dart';

class DonationView extends GetView<DonationController> {
  const DonationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CSHomeWidget(
      floatingActionButton: Obx(
        () => CSIconButton(
          icon:
              controller.editMode.value ? Icons.check_sharp : Icons.edit_sharp,
          onTap: () => controller.saveDonationData(),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        children: [
          CSHeader(
            title: 'donation_title'.tr,
          ),
          verticalSpaceLarge,
          Expanded(
            child: ListView(
              children: [
                _DonationSummary(),
                verticalSpaceRegular,
                CSText('donation_label_user_info_seeker'.tr),
                // Obx(() => (controller.donation.value.seekerInfo != null)
                //     ? _UserInfo(controller.donation.value.seekerInfo!)
                //     : emptyWidget),
                // Obx(() => (controller.donation.value.seekerInfo != null)
                //     ? verticalSpaceRegular
                //     : emptyWidget),
                CSText('donation_label_user_info_donor'.tr),
                // Obx(() => (controller.donation.value.donorInfo != null)
                //     ? _UserInfo(controller.donation.value.donorInfo!)
                //     : emptyWidget),
                // Obx(() => (controller.donation.value.donorInfo != null)
                //     ? verticalSpaceRegular
                //     : emptyWidget),
                // CSText('donation_label_details'.tr),
                // _DonationInfo()
              ],
            ),
          ),
        ],
      ),
    );
  }

  _DonationSummary() => CSCard(
        children: [
          verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 50,
                      foregroundColor: Get.theme.colorScheme.secondary,
                      backgroundColor: Get.theme.colorScheme.secondary,
                      backgroundImage: const AssetImage(kProfileImage),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: LottieBuilder.asset(
                  kaConnectionAnim,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      radius: 50,
                      foregroundColor: Get.theme.colorScheme.secondary,
                      backgroundColor: Get.theme.colorScheme.secondary,
                      backgroundImage: const AssetImage(kProfileImage),
                    ),
                  ),
                ),
              ),
            ],
          ),
          verticalSpaceRegular,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CsIcon(Icons.water_drop_sharp),
              // Obx(() => CSText(controller.donation.value.bloodGroup)),
              horizontalSpaceSmall,
              const CsIcon(Icons.bloodtype_sharp),
              // Obx(() => CSText(controller.donation.value.reqType)),
              horizontalSpaceSmall,
              const CsIcon(Icons.medical_services_sharp),
              // Obx(() => CSText('${controller.donation.value.amount} bag')),
            ],
          ),
        ],
      );

  // _UserInfo(User userInfo) => CSCard(
  //       elevation: 1,
  //       children: [
  //         RowItem(
  //           'donation_label_user_name'.tr,
  //           userInfo.name,
  //           lFlex: 2,
  //           rFlex: 3,
  //         ),
  //         RowItem(
  //           'donation_label_user_mobile'.tr,
  //           userInfo.mobile,
  //           lFlex: 2,
  //           rFlex: 3,
  //         ),
  //         RowItem(
  //           'donation_label_user_mobile_alt'.tr,
  //           userInfo.mobile,
  //           lFlex: 2,
  //           rFlex: 3,
  //         ),
  //       ],
  //     );
  //
  // _DonationInfo() => CSCard(
  //       elevation: 1,
  //       children: [
  //         RowItem(
  //           'donation_label_group'.tr,
  //           controller.donation.value.bloodGroup,
  //           lFlex: 2,
  //           rFlex: 3,
  //         ),
  //         const CSDivider(),
  //         RowItem(
  //           'donation_label_type'.tr,
  //           controller.donation.value.reqType,
  //           lFlex: 2,
  //           rFlex: 3,
  //         ),
  //         const CSDivider(),
  //         RowItem(
  //           'donation_label_quantity'.tr,
  //           '${controller.donation.value.amount} Bags',
  //           lFlex: 2,
  //           rFlex: 3,
  //         ),
  //         const CSDivider(),
  //         RowItem(
  //           'donation_label_problem'.tr,
  //           controller.donation.value.patientProblem,
  //           lFlex: 2,
  //           rFlex: 3,
  //         ),
  //         const CSDivider(),
  //         RowItem(
  //           'donation_label_address_line'.tr,
  //           controller.donation.value.address?.addressLine ?? '',
  //           lFlex: 2,
  //           rFlex: 3,
  //         ),
  //       ],
  //     );
}
