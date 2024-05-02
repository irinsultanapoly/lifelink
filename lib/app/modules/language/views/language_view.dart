import 'package:flutter/material.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

import '../controllers/language_controller.dart';
import 'language_item_view.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return CSHomeWidget(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        children: [
          CSHeader(
            title: 'lang'.tr,
          ),
          verticalSpaceSmall,
          Expanded(
            child: Obx(
              () => LiveList.options(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                options: kAnimationOptions,
                itemBuilder: animationItemBuilder(
                  (index) => LanguageItemView(
                    controller.languages[index],
                    onTap: () =>
                        controller.changeLanguage(controller.languages[index]),
                  ),
                ),
                itemCount: controller.languages.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
