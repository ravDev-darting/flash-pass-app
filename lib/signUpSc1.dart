import 'package:flutter/material.dart';

class SignUpScreen1 extends StatefulWidget {
  const SignUpScreen1({super.key});

  @override
  State<SignUpScreen1> createState() => _SignUpScreen1State();
}

class _SignUpScreen1State extends State<SignUpScreen1> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              "GET GOING WITH ID",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: const Text(
                "Please enter your ID number to authenticate your access.",
                style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF707070),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
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
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                  hintText: '  ID - IQAMA NUMBER',
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                  hintStyle: TextStyle(fontSize: 13, color: Color(0xFF707070))),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.security_update_good_outlined,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .85,
                  child: const Text(
                    "Your ID will be securely used to verify your identity. Ensure you enter the correct ID",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF707070),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .15,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .92,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, ''),
                style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: Colors.green.shade100.withOpacity(.7),
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    minimumSize: const Size(0, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
