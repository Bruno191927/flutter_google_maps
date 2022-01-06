import 'dart:async';

import 'package:flutter/widgets.dart' show ChangeNotifier, Offset;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps/app/helpers/image_to_bytes.dart';
import 'package:google_maps/app/ui/utils/map_styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController with ChangeNotifier{
  final Map<MarkerId,Marker> _markers = {};

  final initialCameraPosition = const CameraPosition(target: LatLng(-11.925617, -76.674504),zoom: 15);

  final _iconMap = Completer<BitmapDescriptor>();

  bool _loading = true;
  bool get loading => _loading;

  late bool _gpsEnabled;
  bool get gpsEnable => _gpsEnabled;

  StreamSubscription? _gpsSuscription;

  HomeController(){
    _init();
  }


  Future<void> _init() async{
    final value = await imageToBytes('assets/car.png');
    final bitmap = BitmapDescriptor.fromBytes(value);
    _iconMap.complete(bitmap);

    _gpsEnabled = await Geolocator.isLocationServiceEnabled();

    _loading = false;

    _gpsSuscription =  Geolocator.getServiceStatusStream().listen(
      (status){
        _gpsEnabled = status == ServiceStatus.enabled;
        notifyListeners();
      }
    );
    notifyListeners();
  }

  Set<Marker> get markers => _markers.values.toSet();

  final _markersController = StreamController<String>.broadcast();

  Stream<String> get onMarkerTap => _markersController.stream;

  void onMapCreated(GoogleMapController controller){
    controller.setMapStyle(mapStyle);
  }

  Future<void> turnOnGps() => Geolocator.openLocationSettings();

  void onTap(LatLng position) async{
    final id = _markers.length.toString();
    final markerId = MarkerId(id);
    final icon = await _iconMap.future;
    final marker = Marker(
      markerId: markerId,
      position: position,
      draggable: true,
      anchor: const Offset(0.5,1),
      icon: icon,
      onTap: (){
        _markersController.sink.add(id);
      },
      onDragEnd: (newPosition){
        //print(newPosition);
      }
    );
    _markers[markerId] = marker;
    notifyListeners();
  }

  @override
  void dispose() {
    _markersController.close();
    _gpsSuscription?.cancel();
    super.dispose();
  }
}