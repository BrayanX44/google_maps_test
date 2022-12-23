import 'package:flutter/material.dart';

class MarkerDetailPage extends StatelessWidget {
  final String? id;

  const MarkerDetailPage({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id ?? ''),
      ),
    );
  }
}
