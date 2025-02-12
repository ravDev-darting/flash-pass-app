import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  String role = "";
  bool isLoading = true;

  Future<void> _fetchUserDetails() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid) // Get user document by UID
          .get();
      setState(() {
        role = userDoc['role'] ?? 'No role specified';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  List<Widget> getFAQ() {
    switch (role) {
      case "police":
        return [
          ExpansionTile(
            title: const Text("How do I report a crime?"),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "You can report a crime by calling 911 for emergencies or visiting your nearest police station for non-emergencies.",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              )
            ],
          ),
          ExpansionTile(
            title: const Text("How can I check my traffic fines?"),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "You can check your traffic fines through the official police website or visit the traffic department.",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              )
            ],
          ),
          ExpansionTile(
            title: const Text(
                "How do I apply for a police clearance certificate?"),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Visit the official police website or your nearest police station to apply for a police clearance certificate.",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              )
            ],
          ),
        ];
      case "ambulance":
        return [
          ExpansionTile(
            title: const Text("How do I call an ambulance?"),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "You can call an ambulance by dialing 911 or your local emergency number.",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              )
            ],
          ),
          ExpansionTile(
            title:
                const Text("What should I do while waiting for an ambulance?"),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Stay calm, provide first aid if necessary, and ensure a clear path for the ambulance to arrive quickly.",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              )
            ],
          ),
          ExpansionTile(
            title: const Text("How do I become a certified paramedic?"),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "To become a certified paramedic, you must complete a recognized emergency medical training program and obtain certification from the appropriate health authorities.",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              )
            ],
          ),
        ];
      case "firefighter":
        return [
          ExpansionTile(
            title: const Text("How do I report a fire emergency?"),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Dial 911 or your local fire emergency number to report a fire.",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              )
            ],
          ),
          ExpansionTile(
            title: const Text("What fire safety precautions should I take?"),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Install smoke detectors, have a fire escape plan, and never leave open flames unattended.",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              )
            ],
          ),
          ExpansionTile(
            title: const Text("How do I become a firefighter?"),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "To become a firefighter, you must complete fire training programs and pass physical and written exams as required by your local fire department.",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              )
            ],
          ),
        ];
      default:
        return [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("No FAQ available for your role."),
            ),
          )
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "${role.isNotEmpty ? role.toUpperCase() : "Department"} - FAQ",
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 4, 31, 5),
          centerTitle: true,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Frequently Asked Questions",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 4, 31, 5),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...getFAQ(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
