import 'package:flash_pass/deptType.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OpenTrLight extends StatefulWidget {
  const OpenTrLight({super.key});

  @override
  State<OpenTrLight> createState() => _OpenTrLightState();
}

class _OpenTrLightState extends State<OpenTrLight> {
  LatLng? _currentLocation;
  LatLng? _destinationLocation;
  GoogleMapController? _googleMapController;
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};

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
              7.heights,
              3.heights,
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
                              markers: {
                                Marker(
                                  markerId: const MarkerId('currentLocation'),
                                  position: _currentLocation!,
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                      BitmapDescriptor.hueRed),
                                ),
                                if (_destinationLocation != null)
                                  Marker(
                                    markerId:
                                        const MarkerId('destinationLocation'),
                                    position: _destinationLocation!,
                                    icon: BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueBlue),
                                  ),
                              },
                              polylines: _polylines,
                            ),
                          ),
                        ),
                      ),
                    ),
              10.heights,
              Center(
                child: SizedBox(
                  height: 60,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EmergencyServicesScreen())),
                    style: ElevatedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      backgroundColor: Colors.red[900],
                      shadowColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: const Text(
                      'Open',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
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

      // Calculate the midpoint
      double midLat =
          (_currentLocation!.latitude + _destinationLocation!.latitude) / 2;
      double midLong =
          (_currentLocation!.longitude + _destinationLocation!.longitude) / 2;
      LatLng midpoint = LatLng(midLat, midLong);

      // Clear markers and add new ones including the midpoint marker
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
        // Custom midpoint marker
        Marker(
          markerId: const MarkerId('midpoint'),
          position: midpoint,
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen), // Custom color or icon
        ),
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
    });
  }
}

extension SizeW on num {
  SizedBox get heights => SizedBox(height: toDouble());
  SizedBox get widths => SizedBox(width: toDouble());
}
