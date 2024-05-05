import 'package:flutter/material.dart';

import 'package:super_ui_kit/super_ui_kit.dart';

import '../../donation_history/views/donation_item.dart';
import '../controllers/donation_dashboard_controller.dart';

class DonationDashboardView extends GetView<DonationDashboardController> {
  const DonationDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpaceSmall,
        CSHeader(
          title: 'Ongoing Requests',
          headerType: HeaderType.other,
          showLeading: false,
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
              itemCount: controller.donations.length,
              options: kAnimationOptions,
            ),
          ),
        ),
      ],
    );
  }
}
