import 'package:flash_pass/loginSc.dart';
import 'package:flutter/material.dart';

class RegistrationDoneScreen extends StatefulWidget {
  const RegistrationDoneScreen({super.key});

  @override
  State<RegistrationDoneScreen> createState() => _RegistrationDoneScreenState();
}

class _RegistrationDoneScreenState extends State<RegistrationDoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 45,
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
              height: MediaQuery.of(context).size.height * .08,
            ),
            const Center(
              child: Text(
                'YOU HAVE\nSUCCESSFULLY\nREGISTERED',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .39,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .92,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const LoginScreen())),
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
                      'Log In',
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
      ),
    );
  }
}
