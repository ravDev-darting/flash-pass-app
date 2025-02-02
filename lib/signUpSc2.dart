import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_pass/signUpSc3.dart';

class SignUpScreen2 extends StatefulWidget {
  final String? idNumber;
  const SignUpScreen2({super.key, this.idNumber});

  @override
  State<SignUpScreen2> createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _createAccount() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match!")),
      );
      return;
    }

    if (!_isPasswordValid(_passwordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password does not meet criteria!")),
      );
      return;
    }

    try {
      String randomEmail = 'user${widget.idNumber}@domain.com';
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: randomEmail, // Replace with user input email
        password: _passwordController.text,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => SignUpScreen3(
                  password: _passwordController.text,
                  iqamaNumber: widget.idNumber.toString(),
                )),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  bool _isPasswordValid(String password) {
    final RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,32}$');
    return regex.hasMatch(password);
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
            const SizedBox(height: 25),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'BACK',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromARGB(178, 4, 31, 5)),
                ),
              ),
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
                        child: const Icon(Icons.traffic_outlined,
                            size: 80, color: Color.fromARGB(178, 4, 31, 5)),
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
                                color: Color.fromARGB(178, 4, 31, 5)),
                          ),
                          Text(
                            "  EMERGENCY",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color.fromARGB(178, 4, 31, 5)),
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
                "CREATE PASSWORD",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            _buildPasswordField("PASSWORD", _passwordController),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.all(6.0),
              child: Text(
                "CONFIRM PASSWORD",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            _buildPasswordField("CONFIRM PASSWORD", _confirmPasswordController),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Your password must include:\n8-32 characters long\n1 lowercase character (a-z)\n1 uppercase (A-Z)\n1 number\n1 special character e.g !@#\$%",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .15),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .92,
                child: ElevatedButton(
                  onPressed: _createAccount,
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: Colors.green.shade100.withOpacity(.7),
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    minimumSize: const Size(0, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
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

  Widget _buildPasswordField(String hint, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .016, vertical: 2),
      decoration: BoxDecoration(
        border:
            Border.all(width: 2, color: const Color.fromARGB(178, 4, 31, 5)),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(1),
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          hintText: '  $hint',
          enabledBorder:
              const UnderlineInputBorder(borderSide: BorderSide.none),
          focusedBorder:
              const UnderlineInputBorder(borderSide: BorderSide.none),
          hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF707070)),
        ),
      ),
    );
  }
}
