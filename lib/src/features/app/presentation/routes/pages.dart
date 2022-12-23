import 'package:flutter/material.dart';
import 'package:google_maps/src/features/app/presentation/pages/home/home_page.dart';
import 'package:google_maps/src/features/app/presentation/pages/location_permission/request_location_permission_page.dart';
import 'package:google_maps/src/features/app/presentation/pages/map/map_page.dart';
import 'package:google_maps/src/features/app/presentation/pages/splash/splash_page.dart';
import 'package:google_maps/src/features/app/presentation/routes/routes.dart';

Map<String, Widget Function(BuildContext)> appRoutes() {
  return {
    Routes.splash: (_) => const SplashPage(),
    Routes.permissions: (_) => const RequestLocationPermissionPage(),
    Routes.home: (_) => const HomePage(),
    Routes.map: (_) => const MapPage(),
  };
}
