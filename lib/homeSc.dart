import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_pass/getPermitScreen.dart';
import 'package:flash_pass/scheduleSc.dart';
import 'package:flash_pass/userDetailsSc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showAlert(BuildContext context, bool isVisitor) {
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
                SizedBox(width: 8),
                Text(
                  'New Case:-',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Amal Jamal, 24 F, Car Accident.',
                    style: TextStyle(fontSize: 16),
                    softWrap: true,
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' High',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.green[100],
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: isVisitor
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const GetPermitScreen(),
                              ),
                            ).then((value) => Navigator.pop(context));
                          },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                    child: Text(
                      isVisitor ? 'View Only' : 'Accept',
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  const VerticalDivider(thickness: 1, color: Colors.black),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                    child: const Text(
                      'Close',
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
  bool isVisitor = false;
  bool isLoading = true;

  String firstName = "Visitor";
  String lastName = "";
  String email = "Guest";
  String badgeNumber = "N/A";
  String department = "General";
  String shiftHours = "9 AM - 5 PM";

  @override
  void initState() {
    super.initState();
    _checkUserType();
    _getCurrentLocation();
  }

  Future<void> _checkUserType() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isVisitor = prefs.getString('user_type') == 'visitor';
    });
    if (!isVisitor) {
      await _fetchUserDetails();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchUserDetails() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          firstName = userDoc['firstName'] ?? firstName;
          lastName = userDoc['lastName'] ?? lastName;
          email = user.email ?? email;
          if (email.isNotEmpty) {
            final matches = RegExp(r'\d+').allMatches(email);
            for (var match in matches) {
              setState(() {
                email = match.group(0)!;
              });
            }
          }
          badgeNumber = userDoc['badgeNumber'] ?? badgeNumber;

          department = userDoc['role'] ?? 'No role specified';
          shiftHours = userDoc['shiftHours'] ?? shiftHours;
          isLoading = false;
        });

        // Extract numbers from email if available
        // if (email.isNotEmpty) {
        //   final matches = RegExp(r'\d+').allMatches(email);
        //   for (var match in matches) {
        //     setState(() {
        //       email = match.group(0)!;
        //     });
        //   }
        // }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching user details: $e");
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      if (permission == LocationPermission.deniedForever) return;

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (mounted) {
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
        });
      }
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Card(
          elevation: 0,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(178, 4, 31, 5).withOpacity(.25),
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
    );
  }

  Widget _buildProfileCard() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const UserDetailsScreen(),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(178, 4, 31, 5).withOpacity(.1),
            border: Border.all(color: Colors.black),
          ),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey.withOpacity(.2),
                        child: const Icon(Icons.person, color: Colors.grey),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$firstName $lastName'.toUpperCase()),
                        Text('id no. $email'.toUpperCase()),
                        if (!isVisitor)
                          Text('badge no. $badgeNumber'.toUpperCase()),
                      ],
                    ),
                    const Spacer(),
                    if (!isVisitor)
                      const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    const SizedBox(width: 5),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildDepartmentSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          children: [
            // Department Row
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  const SizedBox(width: 5),
                  const Text('Department', style: TextStyle(fontSize: 16)),
                  const Spacer(),
                  // Text(department, style: const TextStyle(fontSize: 16)),

                  Text(department, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 5),
                ],
              ),
            ),
            // Shifts Row
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ShiftSchedule(),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 7),
                color: const Color.fromARGB(178, 4, 31, 5).withOpacity(.1),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    const Text('Shifts', style: TextStyle(fontSize: 16)),
                    const Spacer(),
                    Text(
                      shiftHours,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black.withOpacity(.4),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
            ),
            // On Call Row
            Row(
              children: [
                const SizedBox(width: 5),
                const Padding(
                  padding: EdgeInsets.only(top: 8.3),
                  child: Text('On Call', style: TextStyle(fontSize: 16)),
                ),
                const Spacer(),
                Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    value: _switchValue,
                    onChanged: isVisitor
                        ? null
                        : (value) => setState(() => _switchValue = value),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection(double height) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: SizedBox(
        height: height * .25,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: _currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : ClipRRect(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMM yyyy hh:mm a').format(DateTime.now());
    final mH = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Center(
              child: Text(
                isVisitor
                    ? 'WELCOME VISITOR'
                    : 'WELCOME ${firstName.toUpperCase()}',
                style: const TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(178, 4, 31, 5),
                ),
              ),
            ),
            const SizedBox(height: 10),
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
                    showAlert(context, isVisitor);
                  },
                  child: const Icon(Icons.electric_bolt),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'My Profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 5),
            _buildProfileCard(),
            const SizedBox(height: 7),
            _buildDepartmentSection(),
            const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: const Color.fromARGB(178, 4, 31, 5).withOpacity(.1),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: const [
                    SizedBox(width: 5),
                    Text('Incoming Requests', style: TextStyle(fontSize: 16)),
                    Spacer(),
                    SizedBox(width: 5),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 7),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Live Map',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 3),
            _buildMapSection(mH),
          ],
        ),
      ),
    );
  }
}

extension SizeW on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}
