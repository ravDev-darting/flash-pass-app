import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  final String? type;
  const SupportScreen({super.key, this.type});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  // String role = "";
  // bool isLoading = true;
  // bool isVisitor = false;

  // Future<void> _checkUserType() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     isVisitor = prefs.getString('user_type') == 'visitor';
  //   });
  //   if (!isVisitor) {
  //     await _fetchUserDetails();
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  // Future<void> _fetchUserDetails() async {
  //   final User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     try {
  //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(user.uid)
  //           .get();
  //       setState(() {
  //         role = userDoc['role'] ?? 'No role specified';
  //         isLoading = false;
  //       });
  //     } catch (e) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  // List<Widget> getFAQ() {
  //   if (isVisitor) {
  //     return [
  //       ExpansionTile(
  //         title: const Text("How do I get visitor access?"),
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(
  //               "Visitor access can be obtained by registering at the main security desk and presenting valid identification.",
  //               style: TextStyle(color: Colors.grey[700]),
  //             ),
  //           )
  //         ],
  //       ),
  //       ExpansionTile(
  //         title: const Text("What areas can I access as a visitor?"),
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(
  //               "Visitors are typically granted access to public areas and any specifically approved locations. Restricted areas require escort.",
  //               style: TextStyle(color: Colors.grey[700]),
  //             ),
  //           )
  //         ],
  //       ),
  //       ExpansionTile(
  //         title: const Text("How long is my visitor pass valid?"),
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(
  //               "Standard visitor passes are valid for one business day. Extended visits require special authorization.",
  //               style: TextStyle(color: Colors.grey[700]),
  //             ),
  //           )
  //         ],
  //       ),
  //       ExpansionTile(
  //         title: const Text("What should I do in case of emergency?"),
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(
  //               "Follow all emergency instructions and proceed to the nearest designated safe area. Notify security personnel immediately.",
  //               style: TextStyle(color: Colors.grey[700]),
  //             ),
  //           )
  //         ],
  //       ),
  //     ];
  //   }

  //   switch (role) {
  //     case "police":
  //       return [
  //         ExpansionTile(
  //           title: const Text("How do I report a crime?"),
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(
  //                 "You can report a crime by calling 911 for emergencies or visiting your nearest police station for non-emergencies.",
  //                 style: TextStyle(color: Colors.grey[700]),
  //               ),
  //             )
  //           ],
  //         ),
  //         ExpansionTile(
  //           title: const Text("How can I check my traffic fines?"),
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(
  //                 "You can check your traffic fines through the official police website or visit the traffic department.",
  //                 style: TextStyle(color: Colors.grey[700]),
  //               ),
  //             )
  //           ],
  //         ),
  //         ExpansionTile(
  //           title: const Text(
  //               "How do I apply for a police clearance certificate?"),
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(
  //                 "Visit the official police website or your nearest police station to apply for a police clearance certificate.",
  //                 style: TextStyle(color: Colors.grey[700]),
  //               ),
  //             )
  //           ],
  //         ),
  //       ];
  //     case "ambulance":
  //       return [
  //         ExpansionTile(
  //           title: const Text("How do I call an ambulance?"),
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(
  //                 "You can call an ambulance by dialing 911 or your local emergency number.",
  //                 style: TextStyle(color: Colors.grey[700]),
  //               ),
  //             )
  //           ],
  //         ),
  //         ExpansionTile(
  //           title:
  //               const Text("What should I do while waiting for an ambulance?"),
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(
  //                 "Stay calm, provide first aid if necessary, and ensure a clear path for the ambulance to arrive quickly.",
  //                 style: TextStyle(color: Colors.grey[700]),
  //               ),
  //             )
  //           ],
  //         ),
  //         ExpansionTile(
  //           title: const Text("How do I become a certified paramedic?"),
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(
  //                 "To become a certified paramedic, you must complete a recognized emergency medical training program and obtain certification from the appropriate health authorities.",
  //                 style: TextStyle(color: Colors.grey[700]),
  //               ),
  //             )
  //           ],
  //         ),
  //       ];
  //     case "fireman":
  //       return [
  //         ExpansionTile(
  //           title: const Text("How do I report a fire emergency?"),
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(
  //                 "Dial 911 or your local fire emergency number to report a fire.",
  //                 style: TextStyle(color: Colors.grey[700]),
  //               ),
  //             )
  //           ],
  //         ),
  //         ExpansionTile(
  //           title: const Text("What fire safety precautions should I take?"),
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(
  //                 "Install smoke detectors, have a fire escape plan, and never leave open flames unattended.",
  //                 style: TextStyle(color: Colors.grey[700]),
  //               ),
  //             )
  //           ],
  //         ),
  //         ExpansionTile(
  //           title: const Text("How do I become a firefighter?"),
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(
  //                 "To become a firefighter, you must complete fire training programs and pass physical and written exams as required by your local fire department.",
  //                 style: TextStyle(color: Colors.grey[700]),
  //               ),
  //             )
  //           ],
  //         ),
  //       ];
  //     default:
  //       return [
  //         const Center(
  //           child: Padding(
  //             padding: EdgeInsets.all(8.0),
  //             child: Text("No FAQ available for your role."),
  //           ),
  //         )
  //       ];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: Text(
        //     isVisitor
        //         ? "VISITOR SUPPORT"
        //         : "${role.isNotEmpty ? role.toUpperCase() : "Department"} - FAQ",
        //     style: const TextStyle(color: Colors.white),
        //   ),
        //   backgroundColor: const Color.fromARGB(255, 4, 31, 5),
        //   centerTitle: true,
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.type == "accounts"
                    ? Align(
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
                      )
                    : const SizedBox(),
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
                SizedBox(height: MediaQuery.of(context).size.height * .06),
                const Text(
                  'Call Us',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .01),
                _buildDetailRow(
                    '+966 51234567', Icons.whatsapp_outlined, Colors.green),
                _buildDetailRow(
                    '+966 51234500', Icons.whatsapp_outlined, Colors.green),
                SizedBox(height: MediaQuery.of(context).size.height * .04),
                const Text(
                  'Email Us',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .01),
                _buildDetailRow(
                    'support@flashpass.com', Icons.email_outlined, Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          color: Colors.green.shade100.withOpacity(.7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              icon,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildContactCard(String title, String number) {
  //   return Card(
  //     margin: const EdgeInsets.only(bottom: 10),
  //     child: ListTile(
  //       leading: const Icon(Icons.phone, color: Color.fromARGB(255, 4, 31, 5)),
  //       title: Text(title),
  //       subtitle: Text(number),
  //       trailing: IconButton(
  //         icon: const Icon(Icons.call),
  //         onPressed: () {
  //           // Implement call functionality
  //         },
  //       ),
  //     ),
  //   );
  // }
}
