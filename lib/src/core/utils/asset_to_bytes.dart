import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<Uint8List> imageToBytes(String asset,
    {int width = 24, int height = 24, bool fromNetwork = false}) async {
  late Uint8List bytes;
  if (fromNetwork) {
    var file = await DefaultCacheManager().getSingleFile(asset);
    bytes = await file.readAsBytes();
  } else {
    final byteData = await rootBundle.load(asset);
    bytes = byteData.buffer.asUint8List();
  }
  final codec = await ui.instantiateImageCodec(bytes,
      targetWidth: width, targetHeight: height);
  final frame = await codec.getNextFrame();
  final newByteData =
      await frame.image.toByteData(format: ui.ImageByteFormat.png);
  return newByteData!.buffer.asUint8List();
}
