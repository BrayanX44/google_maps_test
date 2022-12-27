import 'dart:async';

import 'package:flutter/material.dart'  show ChangeNotifier;
import 'package:permission_handler/permission_handler.dart';

class RequestLocationPermissionController extends ChangeNotifier {
  final Permission _locationPermission;

  RequestLocationPermissionController(this._locationPermission);

  final _streamController = StreamController<PermissionStatus>.broadcast();

  Stream<PermissionStatus> get onStatusChanged => _streamController.stream;

  Future<void> request() async {
    final status = await _locationPermission.request();
    _notify(status);
  }

  Future<PermissionStatus> check () async {
    final status = await _locationPermission.status;
    return status;
  }

  void _notify(PermissionStatus status) {
    if (!_streamController.isClosed && _streamController.hasListener) {
      _streamController.sink.add(status);
    }
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
