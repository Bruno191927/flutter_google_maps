import 'package:flutter/material.dart';
import 'package:google_maps/app/ui/pages/home_page/home_page.dart';
import 'package:google_maps/app/ui/pages/request_permission/request_permission_page.dart';
import 'package:google_maps/app/ui/pages/splash/splash_page.dart';
import 'package:google_maps/app/ui/routes/routes.dart';

Map<String,Widget Function(BuildContext)> appRoutes() {
  return {
    Routes.SPLASH : (_) => const SplashPage(),
    Routes.PERMISSION : (_) => const RequestPermissionPage(),
    Routes.HOME : (_) => const HomePage()
  };
}