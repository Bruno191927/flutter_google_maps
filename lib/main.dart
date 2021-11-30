import 'package:flutter/material.dart';
import 'package:google_maps/app/ui/pages/home_page/home_page.dart';

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: HomePage()
    );
  }
}