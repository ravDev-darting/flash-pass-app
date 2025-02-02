import 'package:flash_pass/reqRecSc.dart';
import 'package:flutter/material.dart';

class EmergencyServicesScreen extends StatelessWidget {
  const EmergencyServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
              const SizedBox(height: 35),
              const EmergencyButton(label: 'Police'),
              const SizedBox(height: 17),
              const EmergencyButton(label: 'Ambulance'),
              const SizedBox(height: 17),
              const EmergencyButton(label: 'Fire Department'),
            ],
          ),
        ),
      ),
    );
  }
}

class EmergencyButton extends StatelessWidget {
  final String label;

  const EmergencyButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const RequestReceivedScreen())),
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          color: Colors.green[100],
        ),
        alignment: Alignment.center,
        child: Text(
          textAlign: TextAlign.center,
          label,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
