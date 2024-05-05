import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lifelink/app/data/data_keys.dart';

import 'package:super_ui_kit/super_ui_kit.dart';

import '../../../data/asset_keys.dart';
import '../../../data/models/models.dart';
import '../../../services/db_service.dart';
import '../controllers/donation_controller.dart';
import 'row_item.dart';

class DonationView extends GetView<DonationController> {
  const DonationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CSHomeWidget(
      // floatingActionButton: Obx(
      //   () => CSIconButton(
      //     icon:
      //         controller.editMode.value ? Icons.check_sharp : Icons.edit_sharp,
      //     onTap: () => controller.saveDonationData(),
      //   ),
      // ),
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
                Obx(() => FutureBuilder<User?>(
                      future: Get.find<DbService>().findUserByMobile(
                          controller.donation.value.requesterId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('Loading...');
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error: ${snapshot.error}'); // Show an error message if fetching data fails
                        } else {
                          final user = snapshot.data;
                          if (user == null) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return _UserInfo(user);
                          }
                        }
                      },
                    )),
                verticalSpaceRegular,
                CSText('donation_label_user_info_donor'.tr),
                Obx(
                  () => (controller.donation.value.donorId != null)
                      ? FutureBuilder<User?>(
                          future: Get.find<DbService>().findUserByMobile(
                              controller.donation.value.donorId!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('Loading...');
                            } else if (snapshot.hasError) {
                              return Text(
                                  'Error: ${snapshot.error}'); // Show an error message if fetching data fails
                            } else {
                              final user = snapshot.data;
                              if (user == null) {
                                return Text('No donor accepted yet.');
                              } else {
                                return _UserInfo(user);
                              }
                            }
                          },
                        )
                      : CSText('\n     No donor accepted yet.\n'),
                ),
                Obx(() => (controller.donation.value.donorId != null)
                    ? verticalSpaceRegular
                    : emptyWidget),
                CSText('donation_label_details'.tr),
                Obx(() => _DonationInfo()),
                verticalSpaceSmall,
                Obx(() => (controller.donation.value.status ==
                            DonationStatus.inprogress.name &&
                        controller.donation.value.requesterId !=
                            GetStorage().read(kKeyUserId) &&
                        (controller.donation.value.donorId?.isEmpty ?? true))
                    ? CSButton(
                        title: "Accept",
                        onTap: () => controller.acceptDonationReq(),
                      )
                    : emptyWidget),
                Obx(() => controller.donation.value.donorId ==
                        GetStorage().read(kKeyUserId)
                    ? CSButton(
                        title: "Message",
                        onTap: () => controller.gotoMessage(),
                      )
                    : emptyWidget),
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
              Obx(() => CSText(controller.donation.value.bloodGroup)),
              horizontalSpaceSmall,
              const CsIcon(Icons.bloodtype_sharp),
              Obx(() => CSText(controller.donation.value.requestType)),
              horizontalSpaceSmall,
              const CsIcon(Icons.medical_services_sharp),
              Obx(() => CSText('${controller.donation.value.amount} bag')),
            ],
          ),
        ],
      );

  _UserInfo(User userInfo) => CSCard(
        elevation: 1,
        children: [
          RowItem(
            'donation_label_user_name'.tr,
            userInfo.name,
            lFlex: 2,
            rFlex: 3,
          ),
          RowItem(
            'donation_label_user_mobile'.tr,
            userInfo.mobile,
            lFlex: 2,
            rFlex: 3,
          ),
          RowItem(
            'donation_label_user_mobile_alt'.tr,
            userInfo.mobile,
            lFlex: 2,
            rFlex: 3,
          ),
        ],
      );

  _DonationInfo() => CSCard(
        elevation: 1,
        children: [
          RowItem(
            'donation_label_group'.tr,
            controller.donation.value.bloodGroup,
            lFlex: 2,
            rFlex: 3,
          ),
          const CSDivider(),
          RowItem(
            'donation_label_type'.tr,
            controller.donation.value.requestType,
            lFlex: 2,
            rFlex: 3,
          ),
          const CSDivider(),
          RowItem(
            'donation_label_quantity'.tr,
            '${controller.donation.value.amount} Bags',
            lFlex: 2,
            rFlex: 3,
          ),
          const CSDivider(),
          RowItem(
            'donation_label_problem'.tr,
            controller.donation.value.pProblem ?? '',
            lFlex: 2,
            rFlex: 3,
          ),
          const CSDivider(),
          RowItem(
            'donation_label_address_line'.tr,
            controller.donation.value.hospital,
            lFlex: 2,
            rFlex: 3,
          ),
        ],
      );
}
