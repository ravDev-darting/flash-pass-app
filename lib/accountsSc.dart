import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_pass/resetPass2.dart';
import 'package:flash_pass/supportSc.dart';
import 'package:flash_pass/userDetailsSc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_pass/dashSc.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  @override
  void initState() {
    super.initState();
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

              Column(
                children: [
                  // Visitor-specific message

                  // Display user details
                  GestureDetector(
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const UserDetailsScreen(),
                            ),
                          ),
                      child: _buildDetailRow('', 'PROFILE INFORMATION', false)),
                  _buildDetailRow('', 'APP NOTIIFCATION', true),
                  GestureDetector(
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const SupportScreen(type: 'accounts'),
                            ),
                          ),
                      child: _buildDetailRow('', 'SUPPORT', false)),
                  GestureDetector(
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ResetPassScreen2(),
                            ),
                          ),
                      child: _buildDetailRow('', 'CHANGE PASSWORD', false)),

                  GestureDetector(
                      onTap: () async => await _logout(context),
                      child: _buildDetailRow('', 'LOGOUT', false)),
                  const SizedBox(height: 30),

                  SizedBox(height: MediaQuery.of(context).size.height * .2),

                  // Logout/Exit Button
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, bool toggle) {
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
            toggle
                ? Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: _switchValue,
                      onChanged: (value) =>
                          setState(() => _switchValue = value),
                    ),
                  )
                : const Icon(Icons.arrow_forward_ios, color: Colors.grey),
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

  bool _switchValue = false;
}
