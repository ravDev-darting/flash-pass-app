import 'package:flash_pass/loginOrSignUp.dart';
import 'package:flash_pass/vpage1.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  Future<void> _handleVisitorSelection() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_type', 'visitor');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EmergencyScreen()),
    );
  }

  // Function to handle employee selection
  Future<void> _handleEmployeeSelection() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'user_type', 'employee'); // Save user type as employee

    // Navigate to LoginOrSignUp
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginOrSignUp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            Card(
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
                            fontSize: 40,
                            color: Color.fromARGB(178, 4, 31, 5),
                          ),
                        ),
                        Text(
                          "  EMERGENCY",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(178, 4, 31, 5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              heightFactor: 6,
              child: Text(
                "YOUR SAFETY IS\n  OUR PRIORITY",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: _handleEmployeeSelection,
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: _kButtonMinWidth,
                  maxWidth: _kButtonMaxWidth,
                ),
                height: _kButtonHeight,
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: _kButtonPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      _kButtonHeight / 2), // Perfect circle
                  color: Colors.green.shade100.withOpacity(.43),
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'EMPLOYEE',
                    style: TextStyle(
                      fontSize: _kButtonFontSize,
                      // Optional: Use responsive font size
                      // fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: _kButtonSpacing),
            GestureDetector(
              onTap: _handleVisitorSelection,
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: _kButtonMinWidth,
                  maxWidth: _kButtonMaxWidth,
                ),
                height: _kButtonHeight,
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: _kButtonPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_kButtonHeight / 2),
                  color: Colors.green.shade100.withOpacity(.43),
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'VISITOR',
                    style: TextStyle(
                      fontSize: _kButtonFontSize,
                      // Optional: Use responsive font size
                      // fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height * .16,
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(178, 4, 31, 5),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'CONTACT US',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const <Widget>[
                          Text(
                            '+966548293737\npmu@pmu.edu.sa',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          Spacer(),
                          Icon(Icons.email_outlined,
                              size: 70, color: Colors.grey),
                          Icon(Icons.call_outlined,
                              size: 70, color: Colors.grey),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const double _kButtonMinWidth = 200.0; // Minimum width for buttons
const double _kButtonMaxWidth = 400.0; // Maximum width for buttons
const double _kButtonHeight = 60.0; // Fixed height works well for buttons
const double _kButtonPadding = 16.0; // Horizontal padding
const double _kButtonFontSize = 20.0;
const double _kButtonSpacing = 10.0;
