import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LatLng? _currentLocation;
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final mH = MediaQuery.of(context).size.height;
    final mW = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              elevation: 0,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(178, 4, 31, 5)
                              .withOpacity(.25)),
                      child: const Icon(
                        Icons.traffic_outlined,
                        size: 80,
                        color: Color.fromARGB(178, 4, 31, 5),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          " FLASH🚓PASS",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Color.fromARGB(178, 4, 31, 5),
                          ),
                        ),
                        Text(
                          "  EMERGENCY",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color.fromARGB(178, 4, 31, 5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          _currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: mH * .3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        center: _currentLocation,
                        zoom: 15.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: const ['a', 'b', 'c'],
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: _currentLocation!,
                              builder: (ctx) => const Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 40.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _recenterMap,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.location_searching_rounded,
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return; // Location services are not enabled
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return; // Permissions are denied
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return; // Permissions are permanently denied
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _recenterMap() {
    if (_currentLocation != null) {
      // Center the map to the current location
      _mapController.move(
          _currentLocation!, 16.0); // You can adjust zoom as needed
    }
  }
}

extension SizeW on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}
