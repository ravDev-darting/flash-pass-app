import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_pass/dashSc.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  String firstName = "Visitor";
  String lastName = "";
  String email = "guest@example.com";
  String dob = "Not specified";
  String badgeNumber = "N/A";
  String iqamaNumber = "N/A";
  String role = "VISITOR";
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
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
            dob = userDoc['dob'] ?? 'Not specified';
            badgeNumber = userDoc['badgeNumber'] ?? 'N/A';
            iqamaNumber = userDoc['iqamaNumber'] ?? 'N/A';
            role = userDoc['role'] ?? 'No role specified';
            isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print("Error fetching user details: $e");
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Flash Pass Logo Section
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
              SizedBox(height: MediaQuery.of(context).size.height * .1),

              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        // Visitor-specific message

                        // Display user details
                        _buildDetailRow('',
                            '${firstName.toUpperCase()} ${lastName.toUpperCase()}'),
                        _buildDetailRow('EMAIL:', email),
                        _buildDetailRow('ID NO.', iqamaNumber),
                        _buildDetailRow('BADGE NO.', badgeNumber),

                        _buildDetailRow('', '${role.toUpperCase()} DEPARTMENT'),
                        const SizedBox(height: 30),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * .2),

                        // Logout/Exit Button
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
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Logout',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          color: Colors.green.shade100.withOpacity(.7),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(178, 4, 31, 5),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(178, 4, 31, 5),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const DashScreen()),
        ModalRoute.withName(''),
      );
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
