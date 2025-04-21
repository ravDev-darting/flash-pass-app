import 'package:flash_pass/dashSc.dart';
import 'package:flutter/material.dart';

class VisitorFeedback extends StatefulWidget {
  @override
  _VisitorFeedbackState createState() => _VisitorFeedbackState();
}

class _VisitorFeedbackState extends State<VisitorFeedback> {
  String _selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                const SizedBox(
                  height: 20,
                ),
                // Your Details Section
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "How was your experience?",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 7),

                // Name TextField
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                          color: Colors.black,
                          width: 3), // Even bolder when tapped
                    ),
                    hintText: "Write here...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Would you try it again?",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Radio(
                      value: 'yes',
                      groupValue: _selectedValue,
                      fillColor: MaterialStateProperty.all(Colors.black),
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value.toString();
                        });
                      },
                    ),
                    const Text(
                      'Yes',
                      style: TextStyle(fontSize: 24),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 'no',
                      groupValue: _selectedValue,
                      fillColor: MaterialStateProperty.all(Colors.black),
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value.toString();
                        });
                      },
                    ),
                    const Text(
                      'No',
                      style: TextStyle(fontSize: 24),
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .2),

                // Emergency Dropdown Section

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            insetPadding: const EdgeInsets.all(60),
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
                                    'Thank You',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const DashScreen()),
                                          ModalRoute.withName(''),
                                        ).then(
                                            (value) => Navigator.pop(context));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                      ),
                                      child: Text(
                                        'Return to homepage'.toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.green.shade100.withOpacity(.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Send FeedBack",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(178, 4, 31, 5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
