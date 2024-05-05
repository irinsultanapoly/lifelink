import 'package:flutter/material.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: kpHorizontalPadding),
        children: [
          verticalSpaceLarge,
          const Padding(
            padding:
                EdgeInsets.only(left: kmCardMarginS + kmTextExtraMargin),
            child: CSText.title('Settings'),
          ),
          verticalSpaceRegular,
          // CsSettingItem(
          //   onTap: () {
          //     controller.gotoProfile();
          //   },
          //   title: 'Profile',
          //   iconData: Icons.account_circle_sharp,
          // ),
          CsSettingItem(
            onTap: () {
              controller.gotoDonationHistory();
            },
            title: 'Donation History',
            iconData: Icons.history_toggle_off_sharp,
          ),
          CsSettingItem(
            onTap: () {
              controller.gotoDonationRequestHistory();
            },
            title: 'Request History',
            iconData: Icons.history_toggle_off_sharp,
          ),
          verticalSpaceMedium,
          CsSettingItem(
              title: 'Logout',
              iconData:Icons.logout_sharp,
              showTrailing: false,
            onTap: ()=> controller.logout(),
            ),
          verticalSpaceMedium,
          Obx(
            () => CsSettingItem(
              header: 'Version',
              title: controller.appVersion.value,
              iconData:
                  GetPlatform.isIOS ? Icons.apple_sharp : Icons.android_sharp,
              showTrailing: false,
            ),
          ),
        ],
      ),
    );
  }
}
