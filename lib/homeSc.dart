import 'package:flash_pass/getPermitScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

void showAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Text(
                'ALERT!',
                style: TextStyle(
                  color: Colors.red[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  width: 8,
                ),
                Text(
                  'New Case:-',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Text(
                    'Amal Jamal, 24 F, Car Accident.',
                    style: TextStyle(fontSize: 16), // Truncate if necessary
                    softWrap: true, // Allows text to wrap naturally
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Location:-',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' 1.5KM at Main St.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Priority:-',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' High',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: Colors.green[100],
                  border: Border.all(color: Colors.black, width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const GetPermitScreen()))
                          .then((value) => Navigator.pop(context));
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: Colors.transparent),
                    child: const Text(
                      'Accept',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: Colors.transparent),
                    child: const Text(
                      'Deny',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _switchValue = false;
  LatLng? _currentLocation;
  GoogleMapController? _googleMapController;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    // Format date and time
    String formattedDate = DateFormat('MMM yyyy hh:mm a').format(now);
    final mH = MediaQuery.of(context).size.height;
    final mW = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Center(
                child: Text(
                  'welcome taif'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(178, 4, 31, 5),
                  ),
                ),
              ),
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.08),
                    ),
                    child: Text(formattedDate),
                  ),
                  FloatingActionButton(
                    tooltip: 'Test alert',
                    backgroundColor: Colors.green[100],
                    mini: true,
                    onPressed: () {
                      showAlert(context);
                    },
                    child: const Icon(Icons.electric_bolt),
                  ),
                ],
              ),
              5.height,
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'My Profile',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
              5.height,
              Padding(
                padding: const EdgeInsets.only(left: 7, right: 7),
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          const Color.fromARGB(178, 4, 31, 5).withOpacity(.1),
                      border: Border.all(color: Colors.black)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey.withOpacity(.2),
                          child: const Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('taif ali alghamdi'.toUpperCase()),
                          Text('id no. 12345678'.toUpperCase()),
                          Text('badge no. 4321'.toUpperCase())
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                      5.width
                    ],
                  ),
                ),
              ),
              7.height,
              Padding(
                padding: const EdgeInsets.only(left: 7, right: 7),
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            5.width,
                            const Text(
                              'Department',
                              style: TextStyle(fontSize: 16),
                            ),
                            const Spacer(),
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 10,
                              ),
                            ),
                            5.width,
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 7, bottom: 5),
                        color:
                            const Color.fromARGB(178, 4, 31, 5).withOpacity(.1),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            5.width,
                            const Text(
                              'Shifts',
                              style: TextStyle(fontSize: 16),
                            ),
                            const Spacer(),
                            Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  '9 AM - 5 PM',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black.withOpacity(.4)),
                                )),
                            3.width,
                            const Padding(
                              padding: EdgeInsets.only(top: 4.2),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 10,
                              ),
                            ),
                            5.width,
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          5.width,
                          const Padding(
                            padding: EdgeInsets.only(top: 8.3),
                            child: Text(
                              'On Call',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const Spacer(),
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              value: _switchValue,
                              onChanged: (value) {
                                setState(() {
                                  _switchValue = value;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              7.height,
              Padding(
                padding: const EdgeInsets.only(left: 7, right: 7),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: const Color.fromARGB(178, 4, 31, 5).withOpacity(.1),
                  ),
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      5.width,
                      const Text(
                        'Incoming Requests',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      3.width,
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 15,
                        ),
                      ),
                      5.width,
                    ],
                  ),
                ),
              ),
              7.height,
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Live Map',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
              3.height,
              _currentLocation == null
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(left: 7, right: 7),
                      child: SizedBox(
                        height: mH * .25,
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
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
            ]),
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
}

extension SizeW on num {
  SizedBox get h1 => SizedBox(height: toDouble());
  SizedBox get w1 => SizedBox(width: toDouble());
}
