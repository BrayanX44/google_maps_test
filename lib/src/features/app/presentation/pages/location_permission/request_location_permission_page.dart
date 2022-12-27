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
    extends State<RequestLocationPermissionPage> with WidgetsBindingObserver {
  final _controller =
      RequestLocationPermissionController(Permission.locationWhenInUse);
  late StreamSubscription _subscription;
  bool _fromSettings = false;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    _subscription = _controller.onStatusChanged.listen((status) {
      switch (status) {
        case PermissionStatus.denied:
          // TODO: Handle this case.
          break;
        case PermissionStatus.granted:
          _goToHome();
          break;
        case PermissionStatus.restricted:
          // TODO: Handle this case.
          break;
        case PermissionStatus.limited:
          // TODO: Handle this case.
          break;
        case PermissionStatus.permanentlyDenied:
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: const Text('Hola'),
                    content: const Text(
                        'Por favor, concede manualmente al permiso de ubicacion de la app'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cerrar')),
                      TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            _fromSettings = await openAppSettings();
                          },
                          child: const Text('Ir a los ajustes')),
                    ],
                  ));
          break;
      }
    });
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && _fromSettings) {
      final status = await _controller.check();
      if (status == PermissionStatus.granted) {
        _goToHome();
      }
    }
    _fromSettings = false;
    super.didChangeAppLifecycleState(state);
  }

  void _goToHome() {
    Navigator.pushReplacementNamed(context, Routes.home);
  }

  @override
  void dispose() {
    _subscription.cancel();
    _controller.dispose();
    WidgetsBinding.instance?.removeObserver(this);
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
