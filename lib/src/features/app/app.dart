import 'package:flutter/material.dart';
import 'package:google_maps/src/features/app/presentation/pages/home/home_page.dart';
import 'package:google_maps/src/features/app/presentation/routes/pages.dart';
import 'package:google_maps/src/features/app/presentation/routes/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.splash,
      routes: appRoutes(),
      home: const HomePage(),
    );
  }
}
