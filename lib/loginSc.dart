import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
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
            height: MediaQuery.of(context).size.height * .04,
          ),
          const Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(
              "ENTER YOUR ID NUMBER",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const Text(
            "  Enter the ID associated with your account.",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 15,
                color: Color(0xFF707070),
                fontWeight: FontWeight.w500),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .016,
                vertical: 2),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: const Color.fromARGB(178, 4, 31, 5),
                ),
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.all(1),
            child: const TextField(
              // controller: _reviewController,
              decoration: InputDecoration(
                  hintText: '  ID - IQAMA NUMBER',
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                  hintStyle: TextStyle(fontSize: 13, color: Color(0xFF707070))),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(
              "ENTER YOUR ID NUMBER",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .016,
                vertical: 2),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: const Color.fromARGB(178, 4, 31, 5),
                ),
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.all(1),
            child: const TextField(
              // controller: _reviewController,
              decoration: InputDecoration(
                  hintText: '  ID - IQAMA NUMBER',
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                  hintStyle: TextStyle(fontSize: 13, color: Color(0xFF707070))),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .18,
          ),
          const SizedBox(height: 7),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .39,
                vertical: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.green.shade100.withOpacity(.43)),
            child: const Text(
              'LOGIN',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
