import 'package:flutter/material.dart';
import 'package:google_maps/app/ui/pages/home_page/home_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_){
        final controller = HomeController();
        controller.onMarkerTap.listen((String id) {
            print("Got to $id");
         });
        return controller;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<HomeController>(
          builder: (_,controller,__)=>GoogleMap(
            onMapCreated: controller.onMapCreated,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            compassEnabled: false,
            initialCameraPosition: controller.initialCameraPosition,
            markers: controller.markers,
            onTap: controller.onTap,
          ),
        ),
      ),
    );
  }
}