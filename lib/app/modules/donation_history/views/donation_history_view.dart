import 'package:flutter/material.dart';
import 'package:super_ui_kit/super_ui_kit.dart';
import '../controllers/donation_history_controller.dart';
import 'donation_item.dart';

class DonationHistoryView extends GetView<DonationHistoryController> {
  const DonationHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CSHomeWidget(
      // floatingActionButton: Obx(
      //   () => CSIconButton(
      //     icon: controller.editModeActive.value
      //         ? Icons.check_sharp
      //         : Icons.edit_sharp,
      //     onTap: () => controller.onEditButtonTap(),
      //   ),
      // ),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        children: [
          CSHeader(
            title: 'donation_history_title'.tr,
          ),
          verticalSpaceSmall,
          Expanded(
            child: Obx(
              () => LiveList.options(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: animationItemBuilder(
                  (index) => DonationItem(
                    controller.donations[index],
                    onTap: () => controller.viewDonationDetail(index),
                  ),
                ),
                itemCount:
                    controller.donations.length,
                options: kAnimationOptions,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
