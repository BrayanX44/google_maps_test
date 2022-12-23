import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps/src/features/app/presentation/controllers/request_location_permission_controller.dart';
import 'package:google_maps/src/features/app/presentation/routes/routes.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestLocationPermissionPage extends StatefulWidget {
  const RequestLocationPermissionPage({Key? key}) : super(key: key);

  @override
  State<RequestLocationPermissionPage> createState() =>
      _RequestLocationPermissionPageState();
}

class _RequestLocationPermissionPageState
    extends State<RequestLocationPermissionPage> {
  final _controller =
      RequestLocationPermissionController(Permission.locationWhenInUse);
  late StreamSubscription _subscription;

  @override
  void initState() {
    _subscription = _controller.onStatusChanged.listen((status) {
      if (status == PermissionStatus.granted) {
        Navigator.pushReplacementNamed(context, Routes.home);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: ElevatedButton(
          child: const Text('Allow'),
          onPressed: () {
            _controller.request();
          },
        ),
      )),
    );
  }
}
