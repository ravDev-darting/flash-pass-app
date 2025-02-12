import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShiftSchedule extends StatefulWidget {
  const ShiftSchedule({super.key});

  @override
  State<ShiftSchedule> createState() => _ShiftScheduleState();
}

class _ShiftScheduleState extends State<ShiftSchedule> {
  String firstName = "";
  String lastName = "";
  String email = "";
  String badgeNumber = "";
  bool isLoading = true;
  String userId = "";
  Map<String, Map<String, int>> shiftStars = {}; // Store stars for each shift

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      userId = user.uid;
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            firstName = userDoc['firstName'] ?? 'No First Name';
            lastName = userDoc['lastName'] ?? 'No Last Name';
            email = user.email ?? 'No Email';
            badgeNumber = userDoc['badgeNumber'] ?? 'No Badge Number';
          });
        }

        await _initializeStars();
      } catch (e) {
        print("Error fetching user details: $e");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _initializeStars() async {
    List<String> days = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];

    Map<String, Map<String, int>> tempShiftStars = {};

    for (var day in days) {
      DocumentReference dayRef = FirebaseFirestore.instance
          .collection('stars')
          .doc('NzEl7SLhReTKdRZIIvva')
          .collection('users')
          .doc(userId)
          .collection('days')
          .doc(day);

      DocumentSnapshot starDoc = await dayRef.get();

      if (!starDoc.exists) {
        // Create missing document with default values
        await dayRef.set({
          'morning': 0,
          'afternoon': 0,
          'night': 0,
          'onCall': 0,
        });
      }

      // ✅ Cast data to Map<String, dynamic> before using []
      Map<String, dynamic> starData =
          starDoc.data() as Map<String, dynamic>? ?? {};

      tempShiftStars[day] = {
        'morning': starData['morning'] ?? 0,
        'afternoon': starData['afternoon'] ?? 0,
        'night': starData['night'] ?? 0,
        'onCall': starData['onCall'] ?? 0,
      };

      print("Fetched data for $day: $starData"); // Debugging output
    }

    setState(() {
      shiftStars = tempShiftStars;
    });

    print("Final shiftStars: $shiftStars"); // Debugging output
  }

  Future<void> _saveStars(String day, String shift, int stars) async {
    await FirebaseFirestore.instance
        .collection('stars') // Use the correct collection
        .doc('NzEl7SLhReTKdRZIIvva') // Specific document ID for stars
        .collection(
            'users') // If users have their own sub-collection (optional)
        .doc(userId) // Save under the specific user
        .collection('days') // Sub-collection for days (optional)
        .doc(day) // Save per day
        .set({
      shift: stars,
    }, SetOptions(merge: true));

    setState(() {
      shiftStars[day]![shift] = stars;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d/MM/yyyy').format(now);

    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'BACK',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(178, 4, 31, 5),
                            ),
                          )),
                    ),
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
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35,
                                        color: Color.fromARGB(178, 4, 31, 5),
                                      ),
                                    ),
                                    Text(
                                      "  EMERGENCY",
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        formattedDate,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '$firstName $lastName',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Table(
                        border: TableBorder.all(color: Colors.grey),
                        columnWidths: const {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(3),
                          2: FlexColumnWidth(3),
                          3: FlexColumnWidth(3),
                          4: FlexColumnWidth(2),
                        },
                        children: [
                          // Header Row
                          TableRow(
                            children: [
                              headerCell(''),
                              headerCell('Morning Shift\n(6:00 AM - 2:00 PM)'),
                              headerCell(
                                  'Afternoon Shift\n(2:00 PM - 10:00 PM)'),
                              headerCell('Night Shift\n(10:00 PM - 6:00 AM)'),
                              headerCell('On Call'),
                            ],
                          ),
                          // Days Rows
                          for (var day in shiftStars.keys)
                            TableRow(
                              children: [
                                dayCell(day),
                                shiftCell(day, 'morning'),
                                shiftCell(day, 'afternoon'),
                                shiftCell(day, 'night'),
                                shiftCell(day, 'onCall'),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget dayCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget shiftCell(String day, String shift) {
    int stars = shiftStars[day]?[shift] ?? 0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          int newStars = (stars + 1) % 4; // Cycle between 0-3 stars
          _saveStars(day, shift, newStars);
        },
        child: Icon(
          stars == 0
              ? Icons.star_border
              : (stars == 1 ? Icons.star_half : Icons.star),
          color: Colors.grey,
        ),
      ),
    );
  }
}
