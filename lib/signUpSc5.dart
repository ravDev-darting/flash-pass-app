import 'package:flash_pass/succRegistered.dart';
import 'package:flutter/material.dart';

class SignUpScreen5 extends StatefulWidget {
  final String verificationCode;
  const SignUpScreen5({super.key, this.verificationCode = ''});

  @override
  State<SignUpScreen5> createState() => _SignUpScreen5State();
}

class _SignUpScreen5State extends State<SignUpScreen5> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose(); // Clean up the controller
    super.dispose();
  }

  void _validateOtp(BuildContext context) {
    String enteredOtp = _otpController.text.trim();
    if (enteredOtp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the OTP')),
      );
      return;
    }

    if (enteredOtp == widget.verificationCode) {
      // OTP is valid, navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RegistrationDoneScreen()),
      );
    } else {
      // OTP is invalid, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade100,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                      fontSize: 18,
                      color: Color.fromARGB(178, 4, 31, 5),
                    ),
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
                                .withOpacity(.25),
                          ),
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
                  "PLEASE ENTER THE CODE",
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  "The verification code sent to your phone number",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .016,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: const Color.fromARGB(178, 4, 31, 5),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(1),
                child: TextField(
                  controller: _otpController,
                  decoration: const InputDecoration(
                    hintText: '  VERIFICATION CODE',
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    hintStyle:
                        TextStyle(fontSize: 13, color: Color(0xFF707070)),
                  ),
                  keyboardType: TextInputType.number, // OTP is usually numeric
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .35),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .92,
                  child: ElevatedButton(
                    onPressed: () => _validateOtp(context),
                    style: ElevatedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      backgroundColor: Colors.green.shade100.withOpacity(.7),
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      minimumSize: const Size(0, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
