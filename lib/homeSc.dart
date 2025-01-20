import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

const CameraPosition cameraPosition = CameraPosition(
  target: LatLng(33.6155555, 73.1455555),
  zoom: 15,
);

String? cityName;
Completer<GoogleMapController> completer = Completer();
LatLng latLng = const LatLng(33.6155555, 73.1455555);
GoogleMapController? mapController;
Set<Marker> markers = {};
PolylinePoints? polylinePoints;
bool? rideStart;
getUserCurrentLocation() async {
  mapController = await completer.future;
  loc.LocationData currentLocation;
  var location = loc.Location();
  currentLocation = await location.getLocation();
  mapController!.animateCamera(CameraUpdate.newCameraPosition(
    CameraPosition(
      target: LatLng(currentLocation.latitude!.toDouble(),
          currentLocation.longitude!.toDouble()),
      zoom: 15,
    ),
  ));
  latLng = LatLng(currentLocation.latitude!.toDouble(),
      currentLocation.longitude!.toDouble());

  // try {
  //   List<Placemark> placemarks = await placemarkFromCoordinates(
  //       currentLocation.latitude!.toDouble(),
  //       currentLocation.longitude!.toDouble());
  //   cityName = placemarks[0].locality.toString();
  // } catch (err) {}
}

Future<void> getUserLocation() async {
  var location = loc.Location();
  var checkPermForLocation = await location.requestPermission();

  if (checkPermForLocation == loc.PermissionStatus.granted) {
    getUserCurrentLocation();
  } else if (checkPermForLocation == loc.PermissionStatus.denied) {
    location.requestPermission();
  } else if (checkPermForLocation == loc.PermissionStatus.deniedForever) {}
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context);
    final mH = MediaQuery.of(context).size.height;
    final mW = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                20.height,
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Around You',
                    style: TextStyle(fontSize: 20, color: primary.primaryColor),
                  ),
                ),
                20.height,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: mH * .48,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GoogleMap(
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      onMapCreated: (controller) {
                        setState(() {
                          mapController = controller;
                          completer.complete(controller);
                        });
                      },
                      zoomControlsEnabled: false,
                      initialCameraPosition: cameraPosition,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    completer = Completer();
    super.dispose();
  }

  @override
  void initState() {
    getUserLocation();

    super.initState();
  }
}

extension SizeW on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}
