import 'package:package_info_plus/package_info_plus.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

import '../../../routes/app_pages.dart';

class SettingController extends GetxController {

  final appVersion = ''.obs;

  @override
  void onReady() {
    getAppVersion();
    super.onReady();
  }

  void gotoProfile() {}

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    appVersion.value = version;
  }

  void gotoLicense() {
  }

  void gotoLanguageSetting() {
  }

  void gotoDonationHistory() {
  }

  void gotoDonationRequestHistory() {
  }

  logout() {
    Get.offAllNamed(Routes.AUTH);
  }
}
