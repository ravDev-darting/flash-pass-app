import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    _fetchUserDetails();
    super.initState();
  }

  List<Map<String, dynamic>> policeHistory = [];
  List<Map<String, dynamic>> ambulanceHistory = [];
  List<Map<String, dynamic>> firefHistory = [];
  String role = "";
  bool isLoading = true;

  // Fetch user details from Firestore
  Future<void> _fetchUserDetails() async {
    final User? user = FirebaseAuth.instance.currentUser;
    CollectionReference history =
        FirebaseFirestore.instance.collection('history');
    DocumentSnapshot docSnapshot =
        await history.doc('Xji4UkEYSN6b9RAGGJQR').get();
    Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;

    if (data != null && data.containsKey('policeHistory')) {
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid) // Get user document by UID
            .get();
        setState(() {
          role = userDoc['role'] ?? 'No role specified';
          policeHistory =
              List<Map<String, dynamic>>.from(data['policeHistory']);
          ambulanceHistory =
              List<Map<String, dynamic>>.from(data['ambulanceHistory']);
          firefHistory = List<Map<String, dynamic>>.from(data['firefHistory']);
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
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
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '12/01/2024',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: role == "police"
                            ? policeHistory.length
                            : role == "ambulance"
                                ? ambulanceHistory.length
                                : firefHistory.length,
                        itemBuilder: (context, index) {
                          var item = role == "police"
                              ? policeHistory[index]
                              : role == "ambulance"
                                  ? ambulanceHistory[index]
                                  : firefHistory[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8.0),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.2),
                                    child: Icon(
                                        role == "police"
                                            ? Icons.local_police_rounded
                                            : role == "ambulance"
                                                ? Icons.local_hospital_rounded
                                                : Icons
                                                    .fire_extinguisher_rounded,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Area: ${item['area']} - ${item['activity']} at ${item['time']}",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
