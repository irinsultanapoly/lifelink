import 'package:flutter/material.dart';
import 'package:super_ui_kit/super_ui_kit.dart';
import 'app/routes/app_pages.dart';
import 'app/services/db_service.dart';
import 'app/util/app_constants.dart';
import 'app/extensions/string_ext.dart';
import 'app/util/app_theme.dart';
import 'generated/locales.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Init DB
  await GetStorage.init();

  //Initial Ui Config
  await setupUiConfig();

  ///AWAIT SERVICES INITIALIZATION.
  await initServices();

  //App language
  var appLangCode = GetStorage().read<String>(kCurrentLangCode);
  var locale = appLangCode?.getLocaleFromCode() ?? kDefaultLocale;

  runApp(
    GetMaterialApp(
      title: 'app_name'.tr,
      translationsKeys: AppTranslation.translations,
      locale: locale,
      fallbackLocale: kFallbackLocale,
      initialRoute: true
          ? AppPages.INITIAL
          : Routes.HOME,
      getPages: AppPages.routes,
      theme: appThemeLight,
      darkTheme: appDarkTheme,
      enableLog: true,
      //initialBinding: BindingsBuilder(() => initServices()),
      debugShowCheckedModeBanner: false,
    ),
  );
}

setupUiConfig() {
  AppConfig.loaderScale = 1.7;
}

initServices() async {
  ///Initialize DB Service
  Get.put(DbService());
}
