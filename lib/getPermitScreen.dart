import 'package:flash_pass/openTrLight.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetPermitScreen extends StatefulWidget {
  const GetPermitScreen({super.key});

  @override
  State<GetPermitScreen> createState() => _GetPermitScreenState();
}

class _GetPermitScreenState extends State<GetPermitScreen> {
  LatLng? _currentLocation;
  LatLng? _destinationLocation;
  LatLng? _midPoint;
  GoogleMapController? _googleMapController;
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {}; // Use this to hold your markers

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCurrentLocation();
    });
    final mH = MediaQuery.of(context).size.height;
    final mW = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
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
                                  .withOpacity(.25),
                            ),
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
              ),
              7.height,
              3.height,
              _currentLocation == null
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(left: 7, right: 7),
                      child: SizedBox(
                        height: mH * .6,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: GoogleMap(
                              myLocationButtonEnabled: true,
                              zoomControlsEnabled: false,
                              myLocationEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: _currentLocation!,
                                zoom: 15.0,
                              ),
                              onMapCreated: (controller) {
                                _googleMapController = controller;
                              },
                              markers: _markers, // Use the _markers set here
                              polylines: _polylines,
                            ),
                          ),
                        ),
                      ),
                    ),
              10.height,
              Center(
                child: Container(
                  decoration: BoxDecoration(border: Border.all(width: .7)),
                  child: const Text(
                    'You Have one traffic light on your way',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              7.height,
              Center(
                child: SizedBox(
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const OpenTrLight())),
                    style: ElevatedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      backgroundColor: Colors.red[900],
                      shadowColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: const Text(
                      'Click to get permit',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
            ],
          ),
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

    // Set state to update the current and destination locations
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _destinationLocation = LatLng(
        position.latitude + 0.01, // Approx 5 km in latitude
        position.longitude,
      );

      // Calculate midpoint for the custom marker
      _midPoint = LatLng(
        (_currentLocation!.latitude + _destinationLocation!.latitude) / 2,
        (_currentLocation!.longitude + _destinationLocation!.longitude) / 2,
      );

      // Clear existing polyline and add a new one
      _polylines.clear(); // Clear any previous polyline data
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: [_currentLocation!, _destinationLocation!],
          color: Colors.blue,
          width: 5,
        ),
      );

      // Clear markers and add the updated markers
      _markers.clear();
      _markers.addAll({
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: _currentLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
        if (_destinationLocation != null)
          Marker(
            markerId: const MarkerId('destinationLocation'),
            position: _destinationLocation!,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        if (_midPoint != null)
          Marker(
            markerId: const MarkerId('midPoint'),
            position: _midPoint!,
            infoWindow: const InfoWindow(title: 'Traffic Light'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
          ),
      });
    });

    // Calculate bounds for the polyline
    double minLat = _currentLocation!.latitude;
    double minLong = _currentLocation!.longitude;
    double maxLat = _destinationLocation!.latitude;
    double maxLong = _destinationLocation!.longitude;

    // Update the camera with bounds after polyline is set
    if (_googleMapController != null) {
      _googleMapController!.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLong),
          northeast: LatLng(maxLat, maxLong),
        ),
        50, // Added padding for better visibility
      ));
    }
  }
}

extension SizeW on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}
