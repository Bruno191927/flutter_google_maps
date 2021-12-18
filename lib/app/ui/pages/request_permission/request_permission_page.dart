import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps/app/ui/pages/request_permission/request_permission_controller.dart';
import 'package:google_maps/app/ui/routes/routes.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestPermissionPage extends StatefulWidget {
  const RequestPermissionPage({ Key? key }) : super(key: key);

  @override
  _RequestPermissionPageState createState() => _RequestPermissionPageState();
}

class _RequestPermissionPageState extends State<RequestPermissionPage> {

  final _controller = RequestPermissionController(Permission.locationWhenInUse);
  late StreamSubscription _subscription;

  @override
  void initState() {
    _subscription = _controller.onStatusChanged.listen((status) {
      if(status == PermissionStatus.granted){
        Navigator.pushReplacementNamed(context, Routes.HOME);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: ElevatedButton(
            child: const Text("Allow"),
            onPressed: (){
              _controller.request();
            },
          ),
        ),
      ),
    );
  }
}