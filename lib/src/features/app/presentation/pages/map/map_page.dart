import 'package:flutter/material.dart';
import 'package:google_maps/src/features/app/presentation/controllers/map_controller.dart';
import 'package:google_maps/src/features/app/presentation/pages/map/marker_detail_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapController>(
      create: (_) {
        final controller = MapController();
        controller.onMarkerTap.listen((String id) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MarkerDetailPage(id: id)));
        });
        return controller;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<MapController>(
          builder: (_, controller, __) => GoogleMap(
            initialCameraPosition: controller.initialCameraPosition,
            onMapCreated: controller.onMapCreated,
            markers: controller.markers,
            onTap: controller.onTap,
          ),
        ),
      ),
    );
  }
}
