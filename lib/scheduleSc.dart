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
  @override
  void initState() {
    // TODO: implement initState

    _fetchUserDetails();
    super.initState();
  }

  String firstName = "";
  String lastName = "";
  String email = "";
  String badgeNumber = "";
  bool isLoading = true;
  Future<void> _fetchUserDetails() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid) // Get user document by UID
            .get();

        if (userDoc.exists) {
          setState(() {
            firstName = userDoc['firstName'] ?? 'No First Name';
            lastName = userDoc['lastName'] ?? 'No Last Name';
            email = user.email ?? 'No Email';
            badgeNumber = userDoc['badgeNumber'] ?? 'No Badge Number';
            isLoading = false;
          });
          RegExp regExp = RegExp(r'\d+'); // This matches one or more digits

          // Find the match
          Iterable<Match> matches = regExp.allMatches(email);

          // Extract and print the number
          for (var match in matches) {
            String number = match.group(0)!;
            setState(() {
              email = number;
            });
          }
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        // Handle error if fetching fails
        print("Error fetching user details: $e");
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    // Format date and time
    String formattedDate = DateFormat('d/MM/yyyy').format(now);
    final mH = MediaQuery.of(context).size.height;
    final mW = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                        headerCell('Afternoon Shift\n(2:00 PM - 10:00 PM)'),
                        headerCell('Night Shift\n(10:00 PM - 6:00 AM)'),
                        headerCell('On Call'),
                      ],
                    ),
                    // Days Rows
                    for (var day in [
                      'Sunday',
                      'Monday',
                      'Tuesday',
                      'Wednesday',
                      'Thursday',
                      'Friday',
                      'Saturday'
                    ])
                      TableRow(
                        children: [
                          dayCell(day),
                          shiftCell(),
                          shiftCell(),
                          shiftCell(),
                          shiftCell(),
                        ],
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.star_border,
                          color: Colors.grey,
                        ),
                        Text(
                          'Available to standby, didn\'t been called',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.star_half,
                          color: Colors.grey,
                        ),
                        Text(
                          'Covered Half the Shift',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                        ),
                        Text(
                          'Covered the Full Shift',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for header cells
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

  // Widget for day cells
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

  // Widget for shift cells with stars
  Widget shiftCell() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Icon(
        Icons.star,
        color: Colors.grey,
      ),
    );
  }
}
