import 'package:flash_pass/vpage2.dart';
import 'package:flutter/material.dart';

class EmergencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
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
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              const Text(
                "PLEASE CHOOSE YOUR\nEMERGENCY",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(178, 4, 31, 5),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .09,
              ),

              // Buttons
              _buildButton(context, "POLICE"),
              const SizedBox(height: 20),
              _buildButton(context, "AMBULANCE"),
              const SizedBox(height: 20),
              _buildButton(context, "FIRE DEPARTMENT"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.height * .52,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EmergencyDetailsScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.green.shade100
                .withOpacity(.43), // Button background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(178, 4, 31, 5),
            ),
          ),
        ),
      ),
    );
  }
}
