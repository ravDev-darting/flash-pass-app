import 'package:flash_pass/signUpSc5.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpScreen4 extends StatefulWidget {
  const SignUpScreen4({super.key});

  @override
  State<SignUpScreen4> createState() => _SignUpScreen4State();
}

class _SignUpScreen4State extends State<SignUpScreen4> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  Future<void> sendSms() async {
    setState(() => _isLoading = true);

    final phoneNumber = _phoneController.text.trim();
    if (phoneNumber.isEmpty) {
      _showError('Please enter a valid phone number');
      setState(() => _isLoading = false);
      return;
    }

    // Generate a random 6-digit OTP
    final otp =
        (100000 + (DateTime.now().millisecondsSinceEpoch % 900000)).toString();
    const accountSid = 'ACafa13591da32caac26209a332b074073';
    const authToken = 'ee96b5b609483c65c6621f0f9d106a3f';
    const twilioUrl =
        'https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json';

    final credentials = base64Encode(utf8.encode('$accountSid:$authToken'));

    try {
      final response = await http.post(
        Uri.parse(twilioUrl),
        headers: {
          'Authorization': 'Basic $credentials',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'To': '+966$phoneNumber',
          'From': '+16315402092',
          'Body': 'Your FlashPass OTP code is: $otp',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _navigateToOTPVerification(otp);
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

  // Function to show error message
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

  // Navigate to OTP verification screen with the generated OTP
  void _navigateToOTPVerification(String otp) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SignUpScreen5(verificationCode: otp),
      ),
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
                  "PLEASE ENTER YOUR PHONE NUMBER",
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 8),
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
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      hintText: '  PHONE NUMBER',
                      enabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      hintStyle:
                          TextStyle(fontSize: 13, color: Color(0xFF707070))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(Icons.sms_outlined, color: Colors.grey),
                    SizedBox(width: 5),
                    Text(
                      'CODE WILL BE SENT TO YOUR PHONE NUMBER',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    )
                  ],
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
                            borderRadius: BorderRadius.circular(20))),
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
