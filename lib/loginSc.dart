import 'package:flash_pass/customtabs.dart';
import 'package:flash_pass/dashSc.dart';
import 'package:flash_pass/forgetPass.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth import
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final bool _loader = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade100,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const DashScreen()), // Navigate to the new screen
                    );
                  },
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
            SizedBox(height: MediaQuery.of(context).size.height * .04),
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
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    hintText: '  ID - IQAMA NUMBER',
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    hintStyle:
                        TextStyle(fontSize: 13, color: Color(0xFF707070))),
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.all(6.0),
              child: Text(
                "ENTER YOUR PASSWORD",
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
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: '  PASSWORD',
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    hintStyle:
                        TextStyle(fontSize: 13, color: Color(0xFF707070))),
              ),
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                const Text(
                  "  Forgot your password?",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF707070),
                      fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ForgetPassScreen())),
                  child: Text(
                    " Forgot password",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.green.shade600.withOpacity(.6),
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .18),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .92,
                child: ElevatedButton(
                  onPressed: () => _login(),
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
      ),
    );
  }

  Future<void> _login() async {
    final String email =
        'user${_emailController.text}@domain.com'; // Appending the domain
    final String password = _passwordController.text;

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Close the loading dialog
      Navigator.pop(context);

      // After successful login, navigate to CustomNav screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const CustomNav(),
        ),
        (route) => false,
      );
    } catch (e) {
      // Close the loading dialog
      Navigator.pop(context);

      // Show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Invalid ID or Password"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}
