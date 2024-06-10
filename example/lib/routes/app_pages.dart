import 'package:flutter_nuvei_simply_connect_test_example/modules/homepage/homepage_binding.dart';
import 'package:flutter_nuvei_simply_connect_test_example/modules/homepage/homepage_view.dart';
import 'package:get/get.dart';
part './app_routes.dart';

class AppPages {
  const AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.HOMEPAGE;

  static final pages = [
    GetPage(
      name: Routes.HOMEPAGE,
      page: () => const HomePageView(),
      binding: HomePageBinding(),
    ),
  ];
}
