import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

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
                // Example of patient entries
                patientCard(
                  icon: Icons.male,
                  iconColor: Colors.blue,
                  name: "Amar Khalid",
                  age: 44,
                  condition: "Severe Burns",
                  time: "9:41 AM",
                ),
                patientCard(
                  icon: Icons.female,
                  iconColor: Colors.pink,
                  name: "Amani Faroqe",
                  age: 31,
                  condition: "Severe Asthma Attack",
                  time: "9:41 AM",
                ),
                patientCard(
                  icon: Icons.male,
                  iconColor: Colors.blue,
                  name: "Sami Abdullah",
                  age: 55,
                  condition: "Heart Attack",
                  time: "9:41 AM",
                ),

                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '12/02/2024',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                ),
                // Example of patient entries
                patientCard(
                  icon: Icons.male,
                  iconColor: Colors.blue,
                  name: "Amar Khalid",
                  age: 44,
                  condition: "Severe Burns",
                  time: "9:41 AM",
                ),
                patientCard(
                  icon: Icons.female,
                  iconColor: Colors.pink,
                  name: "Amani Faroqe",
                  age: 31,
                  condition: "Severe Asthma Attack",
                  time: "9:41 AM",
                ),
                patientCard(
                  icon: Icons.male,
                  iconColor: Colors.blue,
                  name: "Sami Abdullah",
                  age: 55,
                  condition: "Heart Attack",
                  time: "9:41 AM",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Patient card widget
  Widget patientCard({
    required IconData icon,
    required Color iconColor,
    required String name,
    required int age,
    required String condition,
    required String time,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Gender icon
            CircleAvatar(
              radius: 20,
              backgroundColor: iconColor.withOpacity(0.2),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 12),
            // Patient details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$age, $condition",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Timestamp
            Text(
              time,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
