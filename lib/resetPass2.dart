import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassScreen2 extends StatefulWidget {
  const ResetPassScreen2({super.key});

  @override
  State<ResetPassScreen2> createState() => _ResetPassScreen2State();
}

class _ResetPassScreen2State extends State<ResetPassScreen2> {
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendPasswordResetEmail(
      String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showAlert(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'RESET PASSWORD!',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Password Reset Email Sent!',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    border: Border.all(color: Colors.black, width: 1)),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0, backgroundColor: Colors.transparent),
                  child: const Text(
                    'CLOSE',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
                "EMAIL",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(6.0),
              child: Text(
                "Please enter your email address to reset your password.",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
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
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                    hintText: '  EMAIL ADDRESS',
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    hintStyle:
                        TextStyle(fontSize: 13, color: Color(0xFF707070))),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .92,
                child: ElevatedButton(
                  onPressed: () {
                    sendPasswordResetEmail(
                        _confirmPasswordController.text, context);
                  },
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
}
