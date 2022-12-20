import 'package:flutter/material.dart';
import 'package:google_maps/src/core/utils/map_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends ChangeNotifier{
  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();

  final initialCameraPosition =
      const CameraPosition(target: LatLng(7.0809615608080865, -73.14828396220663), zoom: 0);

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
  }

  void onTap(LatLng position) {
    final markerId = MarkerId(_markers.length.toString());
    final Marker marker = Marker(
      markerId: markerId,
      position: position,
    );
    _markers[markerId] = marker;
    notifyListeners();
  }
}
