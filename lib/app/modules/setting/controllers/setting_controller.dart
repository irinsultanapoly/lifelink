import 'package:lifelink/app/extensions/string_ext.dart';
import 'package:lifelink/app/modules/donation_history/controllers/donation_history_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

import '../../../data/data_keys.dart';
import '../../../routes/app_pages.dart';

class SettingController extends GetxController {
  final GetStorage _box = GetStorage();

  final appVersion = ''.obs;
  var currentLang = Get.locale?.languageCode.getLanguageFromCode().obs;

  @override
  void onReady() {
    getAppVersion();
    super.onReady();
  }

  void gotoProfile() {
    // Get.toNamed(Routes.PROFILE);
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    appVersion.value = version;
  }

  void gotoLicense() {}

  void gotoLanguageSetting() {}

  void gotoDonationHistory() {
    GetStorage()
        .write(kKeyDonationHistoryType, DonationHistoryType.donations.name);
    Get.toNamed(Routes.DONATION_HISTORY);
  }

  void gotoDonationRequestHistory() {
    GetStorage()
        .write(kKeyDonationHistoryType, DonationHistoryType.requests.name);
    Get.toNamed(Routes.DONATION_HISTORY);
  }

  logout() {
    _box.remove(kKeyUserId);
    Get.offAllNamed(Routes.AUTH);
  }
}
