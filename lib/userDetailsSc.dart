import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_pass/dashSc.dart'; // Assuming this is your dashboard screen

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  String firstName = "";
  String lastName = "";
  String email = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  // Fetch user details from Firestore
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
            isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        // Handle error if fetching fails
        print("Error fetching user details: $e");
      }
    } else {
      // If no user is logged in, navigate to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) =>
                const DashScreen()), // Assuming you want to go to dashboard
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser; // Get current user

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Flash Pass Logo Section
              Center(
                child: Card(
                  elevation: 0,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.traffic_outlined,
                          size: 80,
                          color: Color.fromARGB(178, 4, 31, 5),
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
              SizedBox(height: MediaQuery.of(context).size.height * .2),

              // Loading or user details display
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        // Display user first and last name
                        Text(
                          'Name: $firstName $lastName',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Email: $email',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 30),

                        // Logout Button
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .4,
                            child: ElevatedButton(
                              onPressed: () async {
                                await _logout(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  backgroundColor:
                                      Colors.green.shade100.withOpacity(.7),
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                  minimumSize: const Size(0, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              child: const Text(
                                'Logout',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // Firebase logout function
  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out user from Firebase
      // After logging out, navigate to login screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) =>
                const DashScreen()), // Navigate to your main screen after logout
        ModalRoute.withName(''),
      );
    } catch (e) {
      // Show an error message in case of any issue
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}
