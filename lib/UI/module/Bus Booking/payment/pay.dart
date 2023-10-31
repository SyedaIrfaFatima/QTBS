import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/UI/Module/Bus%20Booking/Camera.dart';

import 'fee_voucher.dart';

class payfee extends StatefulWidget {
  final String selectRoute;

  payfee({
    required this.selectRoute,
  });

  // Use an empty string as a default value

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
          title: Text('Voucher'),
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 300)),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 40),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            ('${widget.selectRoute}'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 100,
                          ),

//
                          Text(
                            ' 8000',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
//
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Opacity(
                          opacity: 0.8,
                          child: Container(
                            margin: const EdgeInsets.only(right: 40),
                            width: 132,
                            height: 132,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/voucher.png',
                                  width: 80,
                                  height: 80,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 50),
                                      child: Text(
                                        'Cash',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 2),
                                      // child: IconButton(
                                      //   icon: Icon(
                                      //     Icons.arrow_forward_ios,
                                      //     color: Colors.white,
                                      //   ),
                                      //   onPressed: () async {
                                      //     final userQuery = await FirebaseFirestore
                                      //         .instance
                                      //         .collection('Users')
                                      //         .where('email',
                                      //             isEqualTo:
                                      //                 'yaqoob@gmail.com') // Replace with actual user's email
                                      //         .get();
                                      //
                                      //     if (userQuery.docs.isNotEmpty) {
                                      //       final userDoc =
                                      //           userQuery.docs.first;
                                      //       final userId = userDoc.id;
                                      //
                                      //       Navigator.of(context)
                                      //           .push(MaterialPageRoute(
                                      //         builder: (context) => voucher(
                                      //           db: FirebaseFirestore.instance,
                                      //           userId: userId,
                                      //         ),
                                      //       ));
                                      //     } else {
                                      //       print('User not found.');
                                      //     }
                                      //   },
                                      // ),

                                      // child: IconButton(
                                      //   icon: Icon(
                                      //     Icons.arrow_forward_ios,
                                      //     color: Colors.white,
                                      //   ),
                                      //   onPressed: () async {
                                      //     // Obtain the user's email dynamically, for example, through user authentication.
                                      //     // Set the userEmail variable with the user's email.
                                      //     userEmail =
                                      //         'user@example.com'; // Replace with actual email retrieval logic
                                      //
                                      //     Navigator.of(context)
                                      //         .push(MaterialPageRoute(
                                      //       builder: (context) => voucher(
                                      //         db: FirebaseFirestore.instance,
                                      //         userId:
                                      //             userId, // Assuming you already have the userId
                                      //         userEmail:
                                      //             userEmail, // Pass the userEmail to the voucher class
                                      //       ),
                                      //     ));
                                      //   },
                                      // ),

                                      child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) => voucher(
                                                db: FirebaseFirestore.instance,
                                                userId: userId,
                                                selectRoute: widget.selectRoute,
                                                // userEmail: userEmail,
                                              ),
                                            ));
                                          }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Opacity(
                          opacity: 0.8,
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            width: 132,
                            height: 132,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/tickets.png',
                                  width: 80,
                                  height: 80,
                                ),
                                const SizedBox(height: 8),

                                Center(
                                  child: Text(
                                    'JazzCash',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // Icon(Icons.upload, color: Colors.white),
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
