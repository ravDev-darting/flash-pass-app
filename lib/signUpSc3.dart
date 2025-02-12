import 'package:flash_pass/signUpSc4.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class SignUpScreen3 extends StatefulWidget {
  final String password;
  final String iqamaNumber;
  const SignUpScreen3(
      {super.key, required this.password, required this.iqamaNumber});

  @override
  State<SignUpScreen3> createState() => _SignUpScreen3State();
}

class _SignUpScreen3State extends State<SignUpScreen3> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _badgeNumberController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('MM/dd/yy').format(pickedDate);
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  String _selectedValue = '';
  Future<void> _saveUserDetails() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (_firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          _badgeNumberController.text.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .set({
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'badgeNumber': _badgeNumberController.text,
          'iqamaNumber': widget.iqamaNumber,
          'email': user.email,
          'dob': _dateController.text,
          'role': _selectedValue
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const SignUpScreen4()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill in all fields!")),
        );
      }
    } catch (e) {
      print('this is the error: $e');
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
                  "Your details",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 7),
                child: Text(
                  "Please enter your details",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 15,
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
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                      hintText: '  First name',
                      enabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      hintStyle:
                          TextStyle(fontSize: 13, color: Color(0xFF707070))),
                ),
              ),
              const SizedBox(
                height: 18,
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
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                      hintText: '  Last name',
                      enabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      hintStyle:
                          TextStyle(fontSize: 13, color: Color(0xFF707070))),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
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
                  controller: _dateController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: const InputDecoration(
                    hintText: '  Birthday (mm/dd/yy)',
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    hintStyle:
                        TextStyle(fontSize: 13, color: Color(0xFF707070)),
                  ),
                ),
              ),
              Row(
                children: [
                  Radio(
                    value: 'police',
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value.toString();
                      });
                    },
                  ),
                  const Text(
                    'Police',
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 'ambulance',
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value.toString();
                      });
                    },
                  ),
                  const Text(
                    'Ambulance',
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 'fireman',
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value.toString();
                      });
                    },
                  ),
                  const Text(
                    'Fireman',
                    style: TextStyle(fontSize: 22),
                  ),
                ],
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
                  controller: _badgeNumberController,
                  decoration: const InputDecoration(
                      hintText: '  Badge number',
                      enabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      hintStyle:
                          TextStyle(fontSize: 13, color: Color(0xFF707070))),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .92,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _saveUserDetails();
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
      ),
    );
  }
}
