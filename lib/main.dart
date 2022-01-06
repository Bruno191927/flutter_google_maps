import 'package:flutter/material.dart';
import 'package:google_maps/app/ui/routes/pages.dart';
import 'package:google_maps/app/ui/routes/routes.dart';

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      initialRoute: Routes.SPLASH,
      routes: appRoutes(),
    );
  }
}