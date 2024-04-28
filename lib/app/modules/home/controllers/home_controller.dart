import 'package:flutter/material.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

import '../../../data/data_keys.dart';
import '../../../util/app_constants.dart';

class HomeController extends GetxController {
  final GetStorage box = GetStorage();

  late PageController pageController;

  final selectedIndex = 0.obs;

  @override
  void onInit() {
    box.write(kKeyUserLastAuthType, kAuthTypeLogin);
    super.onInit();
    pageController = PageController(initialPage: selectedIndex.value);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
