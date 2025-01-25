import 'package:flash_pass/loginSc.dart';
import 'package:flash_pass/signUpSc1.dart';
import 'package:flutter/material.dart';

class LoginOrSignUp extends StatefulWidget {
  const LoginOrSignUp({super.key});

  @override
  State<LoginOrSignUp> createState() => _LoginOrSignUpState();
}

class _LoginOrSignUpState extends State<LoginOrSignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
            height: MediaQuery.of(context).size.height * .06,
          ),
          const Text(
            "IF YOU ARE",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 23, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          const Text(
            "POLICE",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 23, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          const Text(
            "FIREMAN",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 23, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          const Text(
            "AMBULANCE",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 23, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .18,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            widthFactor: 1.9,
            child: Text(
              "PLEASE CHOOSE TO",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 7),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const LoginScreen())),
            child: Container(
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
          ),
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.centerLeft,
            widthFactor: 2.45,
            child: Text(
              "new account".toUpperCase(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 7),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SignUpScreen1())),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .37,
                  vertical: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.green.shade100.withOpacity(.43)),
              child: const Text(
                'SIGN UP',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
