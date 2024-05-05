import 'package:get/get.dart';
import 'package:lifelink/app/modules/chat/bindings/chat_binding.dart';
import 'package:lifelink/app/modules/chat/views/chat_view.dart';

import '../modules/address/bindings/address_binding.dart';
import '../modules/address/views/address_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/donation/bindings/donation_binding.dart';
import '../modules/donation/views/donation_view.dart';
import '../modules/donation_history/bindings/donation_history_binding.dart';
import '../modules/donation_history/views/donation_history_view.dart';
import '../modules/donation_request/bindings/donation_request_binding.dart';
import '../modules/donation_request/views/donation_request_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/language/bindings/language_binding.dart';
import '../modules/language/views/language_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS,
      page: () => const AddressView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: _Paths.LANGUAGE,
      page: () => const LanguageView(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: _Paths.DONATION,
      page: () => const DonationView(),
      binding: DonationBinding(),
    ),
    GetPage(
      name: _Paths.DONATION_HISTORY,
      page: () => const DonationHistoryView(),
      binding: DonationHistoryBinding(),
    ),
    GetPage(
      name: _Paths.DONATION_REQUEST,
      page: () => const DonationRequestView(),
      binding: DonationRequestBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    )
  ];
}
