import 'package:flutter/material.dart';

import 'package:super_ui_kit/super_ui_kit.dart';

import '../../../data/asset_keys.dart';
import '../../../util/app_constants.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: kpHorizontalPadding),
        children: [
          verticalSpaceLarge,
          Padding(
            padding:
                const EdgeInsets.only(left: kmCardMarginS + kmTextExtraMargin),
            child: Obx(
              () => CSText.title(
                'dashboard_hello_user'.trParams({
                  'name': controller.name.value
                }),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: kmCardMarginS + kmTextExtraMargin),
            child: CSText.label('dashboard_welcome_user'.tr),
          ),
          verticalSpaceMedium,
          CSCard(
            cardType: CSCardType.item,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CSText.title(
                            'dashboard_total_items'
                                .trParams({'count': '500+'}),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CSText.label(
                            DateTime.now().formatCustom(kDashBoardDateFormat),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        LottieBuilder.asset(
                          kaDashboardFeaturedAnim,
                          height: khFeaturedAnimation,
                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          verticalSpaceLarge,
        ],
      ),
    );
  }
}
