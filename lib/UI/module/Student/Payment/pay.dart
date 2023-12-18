import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'fee_voucher.dart';
import 'jazzcash.dart';

class payfee extends StatefulWidget {
  final String selectRoute;
  final String fee;
  final String busnumber;
  payfee({
    required this.selectRoute,
    required this.fee,
    required this.busnumber,
  });

  @override
  State<payfee> createState() => _payfeeState();
}

class _payfeeState extends State<payfee> {
  String userEmail = ''; // Initialize with an empty string
  String userId = '';
  String registrationDate = ''; // Initialize with an empty string
  Future<String?> getUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.email;
    } else {
      return null;
    }
  }

  Future<void> fetchUserId(String email) async {
    // Fetch the user's data and obtain their userId based on their email
    QuerySnapshot userQuery = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .get();

    if (userQuery.docs.isNotEmpty) {
      final userDoc = userQuery.docs.first;
      userId = userDoc.id;
    } else {
      // Handle the case where the user is not found.
      print('User not found.');
    }
  }

  @override
  void initState() {
    super.initState();
    // Obtain the user's email dynamically and fetch the userId
    getUserEmail().then((userEmail) {
      if (userEmail != null) {
        fetchUserId(userEmail);
      } else {
        // Handle the case where userEmail is null (user not authenticated).
        print('User is not authenticated or email retrieval failed.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blue,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Payment selection',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                  color: Colors.white)),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Bus background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 280)),
//                     Container(
//                       alignment: Alignment.center,
//                       margin: const EdgeInsets.only(right: 40),
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.blue,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         children: [
//                           Text(
//                             ('${widget.selectRoute}'),
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 100,
//                           ),
//
// //
//                           Text(
//                             ('${widget.fee}'),
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
// //
//                         ],
//                       ),
//                     ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 40),
                      padding: const EdgeInsets.all(8),
                      // decoration: BoxDecoration(
                      //   color: Colors.white,
                      //   borderRadius: BorderRadius.circular(8),
                      //   border: Border.all(
                      //     width: 2.0,
                      //     gradient: LinearGradient(
                      //       colors: [
                      //         Colors.blue[800]!,
                      //         Colors.blue[300]!,
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white, width: 2.0),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blueGrey[600]!,
                            Colors.blue[400]!,
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.selectRoute}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            ' ${widget.fee}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Opacity(
                          opacity: 0.8,
                          child: Container(
                            margin: const EdgeInsets.only(right: 30),
                            width: 140,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors
                                  .white, // Use a slightly lighter blue for better contrast
                              borderRadius: BorderRadius.circular(
                                  10.0), // Add subtle rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(0, 2),
                                  blurRadius: 4.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/Cash.png',
                                  width: 112,
                                  height: 112,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          'Cash ', // Use a more descriptive label
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 2.0),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.blueGrey[600]!,
                                              Colors.blue[400]!,
                                            ],
                                          ),
                                        ),
                                        padding: EdgeInsets.only(left: 2.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 25.0,
                                        ),
                                      ),
                                      onPressed: () {
                                        // Navigator.of(context)
                                        //     .push(MaterialPageRoute(
                                        //   builder: (context) => voucher(
                                        //     db: FirebaseFirestore.instance,
                                        //     userId: userId,
                                        //     route: widget.selectRoute,
                                        //     fee: widget.fee,
                                        //     bus: widget.busnumber,
                                        //     // userEmail: userEmail,
                                        //   ),
                                        // )
                                        // );
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            child: voucher(
                                              db: FirebaseFirestore.instance,
                                              userId: userId,
                                              route: widget.selectRoute,
                                              fee: widget.fee,
                                              bus: widget.busnumber,
                                              // userEmail: userEmail,
                                            ), // Replace with the screen you want to navigate to
                                            type: PageTransitionType
                                                .topToBottom, // or any other transition type you prefer
                                            duration: Duration(
                                                seconds:
                                                    1), // Specify your desired duration
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Opacity(
                          opacity: 0.8,
                          child: Container(
                            margin: const EdgeInsets.only(right: 30),
                            width: 140,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors
                                  .white, // Use a slightly lighter blue for better contrast
                              borderRadius: BorderRadius.circular(
                                  10.0), // Add subtle rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(0, 2),
                                  blurRadius: 4.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/jazz cash.png',
                                  width: 115,
                                  height: 108,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          'Jazz Cash ', // Use a more descriptive label
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 2.0),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.blueGrey[600]!,
                                              Colors.blue[400]!,
                                            ],
                                          ),
                                        ),
                                        padding: EdgeInsets.only(left: 2.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 25.0,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => JazzCashPage(
                                            title: '',
                                            selectRoute: widget.selectRoute,
                                            fee: widget.fee,
                                            // userEmail: userEmail,
                                          ),
                                        ));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
