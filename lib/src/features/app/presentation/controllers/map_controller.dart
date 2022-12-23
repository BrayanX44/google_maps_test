import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps/src/core/settings/app_assets.dart';
import 'package:google_maps/src/core/utils/asset_to_bytes.dart';
import 'package:google_maps/src/core/utils/map_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends ChangeNotifier {
  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();

  final _markersController = StreamController<String>.broadcast();

  Stream<String> get onMarkerTap => _markersController.stream;

  final _markerIcon = Completer<BitmapDescriptor>();

  final initialCameraPosition = const CameraPosition(
      target: LatLng(7.0809615608080865, -73.14828396220663), zoom: 20);

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
  }

  MapController() {
    imageToBytes(
      "https://smallimg.pngkey.com/png/small/497-4975453_bigstock-map-marker-map-pin-vector-ma-92524379.png",
      width: 35,
      height: 40,
      fromNetwork: true,
    ).then((value) {
      final bitmap = BitmapDescriptor.fromBytes(value);
      _markerIcon.complete(bitmap);
    });
  }

  void onTap(LatLng position) async {
    final id = _markers.length.toString();
    final markerId = MarkerId(id);
    final icon = await _markerIcon.future;

    final Marker marker = Marker(
        markerId: markerId,
        position: position,
        draggable: true,
        icon: icon,
        //icon: BitmapDescriptor.defaultMarkerWithHue(100), //Set icon specific hue value color
        //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        //Set icon predefined color
        anchor: const Offset(0.5, 1),
        //To set marker position
        onDragEnd: (LatLng newPosition) {
          log('$newPosition', name: 'newPosition');
        },
        onTap: () {
          log('$markerId', name: 'markerId');
          _markersController.sink.add(id);
        });
    _markers[markerId] = marker;

    notifyListeners();
  }

  @override
  void dispose() {
    _markersController.close();
    super.dispose();
  }
}
