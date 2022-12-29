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
        body: Selector<MapController, bool>(
          selector: (_, controller) => controller.loading,
          builder: (context, loading, loadingWidget) {
            if (loading) {
              return loadingWidget!;
            }
            return Consumer<MapController>(
              builder: (_, controller, gpsMessageWidget) {
                if (!controller.gpsEnable) {
                  return gpsMessageWidget!;
                }
                return GoogleMap(
                  initialCameraPosition: controller.initialCameraPosition,
                  onMapCreated: controller.onMapCreated,
                  markers: controller.markers,
                  onTap: controller.onTap,
                );
              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('You must enable GPS location service'),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        final controller = context.read<MapController>();
                        controller.turnOnGps();
                      },
                      child: const Text('Turn on GPS'),
                    ),
                  ],
                ),
              ),
            );
          },
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
