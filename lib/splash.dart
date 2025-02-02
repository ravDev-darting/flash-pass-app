import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth import
import 'package:flash_pass/customtabs.dart';
import 'package:flash_pass/dashSc.dart'; // Assuming your login screen is in this file
import 'package:flutter/material.dart';

class SplashScreenMain extends StatefulWidget {
  const SplashScreenMain({super.key});

  @override
  State<SplashScreenMain> createState() => _SplashScreenMainState();
}

class _SplashScreenMainState extends State<SplashScreenMain> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      _checkLoginStatus();
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(82, 115, 230, 120),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.traffic_outlined,
                    size: 80,
                    color: Colors.white,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "FLASH🚓PASS",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Color.fromARGB(255, 193, 201, 193)),
                      ),
                      Text(
                        "EMERGENCY",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 193, 201, 193)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  // Check if the user is already logged in
  void _checkLoginStatus() {
    User? user = _auth.currentUser;

    // Navigate based on the login status
    if (user != null) {
      // If the user is logged in, navigate to DashScreen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const CustomNav()),
        ModalRoute.withName(''),
      );
    } else {
      // If the user is not logged in, navigate to LoginScreen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const DashScreen()),
        ModalRoute.withName(''),
      );
    }
  }
}
