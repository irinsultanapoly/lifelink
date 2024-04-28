import 'package:super_ui_kit/super_ui_kit.dart';

import '../../../data/data_keys.dart';
import '../../../services/db_service.dart';

class DashboardController extends GetxController {
  DbService dbService = Get.find<DbService>();
  GetStorage box = GetStorage();

  final name = ''.obs;

  @override
  void onInit() {
    super.onInit();
    bindInitialData();
  }

  void bindInitialData() {
    name.value = box.read<String>(kKeyUserName) ?? '';
    printInfo(info: 'bindInitialData => name: ${name.value}');
  }
}
