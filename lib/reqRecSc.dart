import 'dart:async';

import 'package:flash_pass/trafficLightCont.dart';
import 'package:flutter/material.dart';

class RequestReceivedScreen extends StatefulWidget {
  const RequestReceivedScreen({super.key});

  @override
  _RequestReceivedScreenState createState() => _RequestReceivedScreenState();
}

class _RequestReceivedScreenState extends State<RequestReceivedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const TrafficLightScreen(),
            ),
            (route) => false);
      },
    );
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
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
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
              ),
              const Text(
                'Request received\nWe will contact you immediately!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Please wait...',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              // Change the screen when the request is complete
            ],
          ),
        ),
      ),
    );
  }
}
