import 'dart:convert';

import 'package:flash_pass/succRegistered.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpScreen5 extends StatefulWidget {
  final String verificationCode;
  const SignUpScreen5({super.key, this.verificationCode = ''});

  @override
  State<SignUpScreen5> createState() => _SignUpScreen5State();
}

class _SignUpScreen5State extends State<SignUpScreen5> {
  final TextEditingController _otpController = TextEditingController();

  bool _isLoading = false;
  @override
  void dispose() {
    _otpController.dispose(); // Clean up the controller
    super.dispose();
  }

  Future<void> sendSms() async {
    setState(() => _isLoading = true);
    if (_otpController.text.trim().isEmpty) {
      _showError('Please enter an OTP code');
      setState(() => _isLoading = false);
    } else {
      const accountSid = 'ACafa13591da32caac26209a332b074073';
      const authToken = 'ee96b5b609483c65c6621f0f9d106a3f';
      const twilioUrl =
          'https://verify.twilio.com/v2/Services/VAe1921f50c1ba83c0c8ff7b321931453b/VerificationCheck';

      final credentials = base64Encode(utf8.encode('$accountSid:$authToken'));

      try {
        final response = await http.post(
          Uri.parse(twilioUrl),
          headers: {
            'Authorization': 'Basic $credentials',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            'To': widget.verificationCode,
            'Code': _otpController.text.trim(),
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final decodedResponse = json.decode(response.body);
          if (decodedResponse['status'] == "pending") {
            _showError('Invalid OTP code. Please try again.');
          } else if (decodedResponse['status'] == "approved") {
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RegistrationDoneScreen()),
            );
          } // Debug raw response

          print(response.body);
        } else {
          final errorData = json.decode(response.body);
          _showError(errorData['message'] ?? 'Failed to send OTP');
        }
      } catch (e) {
        _showError('Failed to connect to Twilio: ${e.toString()}');
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
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
                    onPressed: _isLoading ? null : sendSms,
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
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Padding(
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
      ),
    );
  }
}
