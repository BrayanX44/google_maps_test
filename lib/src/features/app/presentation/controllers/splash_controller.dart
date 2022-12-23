import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:google_maps/src/features/app/presentation/routes/routes.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends ChangeNotifier {
  SplashController(this._locationPermission);

  final Permission _locationPermission;
  String? _routeName;

  String? get routeName => _routeName;

  Future<void> checkPermission() async {
    final bool isGranted = await _locationPermission.request().isGranted;
    _routeName = isGranted ? Routes.home : Routes.permissions;
    notifyListeners();
  }
}
