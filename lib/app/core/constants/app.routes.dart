// ignore_for_file: prefer_const_constructors
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/modules/bindings/bindings.dart';
import 'package:driver_app/app/modules/screens/screens.dart';
import 'package:driver_app/app/modules/screens/settings.screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._();

  static final routes = [
    GetPage(
      name: '/',
      page: () => HomeScreen(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
    ),
    GetPage(
      name: '/about',
      page: () => AboutScreen(),
    ),
    GetPage(
      name: '/settings',
      page: () => SettingsScreen(),
    ),
  ];

  static final List<DrawerItemModel> drawerRoutes = [
    DrawerItemModel(
      routeName: 'Dashboard',
      icon: 'assets/icons/dashboard.png',
      onTap: () {
        Get.toNamed('/login');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'Settings',
      icon: 'assets/icons/settings.png',
      onTap: () {
        Get.toNamed('/settings');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'About',
      icon: 'assets/icons/about.png',
      onTap: () {
        Get.toNamed('/about');
      },
      width: 23,
    ),
  ];
}
