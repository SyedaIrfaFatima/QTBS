import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:test_project/UI/module/Student/Payment/BoardingPass.dart';

import '../../../../Authentication/models/User_model.dart';

import '../../Manager/Payment_handler/authentic_user_voucher.dart';

import '../../all_user_usage_interface/Util/utils.dart';
import '../Payment/Uploadvoucher.dart';
import '../student registration/login.dart';
import '../Discussion Form/discussion form.dart';
import '../FeedBack/feedback.dart';
import '../Payment/Voucher_status.dart';
import '../Payment/pay.dart';
import '../Profile/profileScreen.dart';
import '../Profile/profile_controller.dart';
import '../student_bus_selection/Bus book status.dart';

// class Home extends StatefulWidget {
//   final String selectRoute;
//   final String fees;
//   final String busnumber;
//   final String voucherDocumentID;
//   final String voucherURL;
//
//   Home(
//       {required this.selectRoute,
//       required this.fees,
//       required this.busnumber,
//       required this.voucherDocumentID,
//       required this.voucherURL}) {
//     assert(voucherDocumentID != null);
//   }
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   final auth = FirebaseAuth.instance;
//   String userName = '';
//   String? uploadedVoucherURL;
//
//   final ProfileController profileController = Get.find();
//
//   // Future<String> getVoucherStatus() async {
//   //   // Replace with your Firestore logic to get the voucher status
//   //   DocumentSnapshot voucherSnapshot = await FirebaseFirestore.instance
//   //       .collection('Vouchers')
//   //       .doc(widget.voucherDocumentID)
//   //       .get();
//   //
//   //   if (voucherSnapshot.exists) {
//   //     return voucherSnapshot['status'] ?? 'pending';
//   //   } else {
//   //     return 'pending';
//   //   }
//   // }
//
//   // Future<String> getVoucherStatus() async {
//   //   // Replace with your Firestore logic to get the voucher status
//   //   DocumentSnapshot voucherSnapshot = await FirebaseFirestore.instance
//   //       .collection('Vouchers')
//   //       .doc(widget.voucherDocumentID)
//   //       .get();
//   //
//   //   if (voucherSnapshot.exists) {
//   //     String status = voucherSnapshot['status'] ?? 'pending';
//   //     print('Voucher Status: $status'); // Add this line to print the status
//   //     return status;
//   //   } else {
//   //     print(
//   //         'Voucher Status: pending'); // Add this line to print the default status
//   //     return 'pending';
//   //   }
//   // }
//
//   Future<String> getVoucherStatus() async {
//     print('Voucher Document ID: ${widget.voucherDocumentID}');
//     // Check if the voucherDocumentID is valid
//     if (widget.voucherDocumentID == null || widget.voucherDocumentID.isEmpty) {
//       print('Voucher Document ID is null or empty.');
//       return 'pending';
//     }
//
//     // Replace with your Firestore logic to get the voucher status
//     DocumentSnapshot voucherSnapshot = await FirebaseFirestore.instance
//         .collection('Vouchers')
//         .doc(widget.voucherDocumentID)
//         .get();
//
//     if (voucherSnapshot.exists) {
//       String status = voucherSnapshot['status'] ?? 'pending';
//       print('Voucher Status: $status');
//       return status;
//     } else {
//       print('Voucher Status: pending');
//       return 'pending';
//     }
//   }
//
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//             appBar: AppBar(title: Text('Home'), actions: [
//               IconButton(
//                 onPressed: () {
//                   auth.signOut().then((value) {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => LoginScreen(
//                                   selectRoute: widget.selectRoute,
//                                   fee: widget.fees,
//                                 )));
//                   }).onError((error, stackTrace) {
//                     utils().toastMessage(error.toString());
//                   });
//                 },
//                 icon: Icon(Icons.logout_outlined),
//               ),
//               SizedBox(width: 10),
//             ]),
//             drawer: Drawer(
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 children: <Widget>[
//                   DrawerHeader(
//                     child: Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => profile()),
//                             );
//                           },
//                           child: CircleAvatar(
//                             radius: 50.0, // Adjust size as needed
//                             backgroundImage: AssetImage(
//                                 'assets/profileimage.jpg'), // Replace with actual driver profile image
//                           ),
//                         ),
//                         FutureBuilder(
//                           future: profileController.getUserData(),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.done) {
//                               if (snapshot.hasData) {
//                                 UserModel user = snapshot.data as UserModel;
//
//                                 userName = user.fullName;
//
//                                 return Text(
//                                   userName,
//                                   style: TextStyle(color: Colors.white),
//                                 );
//                               }
//                             }
//                             // Return a loading indicator or error message if needed
//                             return CircularProgressIndicator(); // Change this to suit your UI
//                           },
//                         ),
//                       ],
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                     ),
//                   ),
//                   ListTile(
//                     title: Text('Payment'),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => payfee(
//                               selectRoute: widget.selectRoute,
//                               fee: widget.fees,
//                               busnumber: widget
//                                   .busnumber), // Replace PaymentScreen with your actual payment screen
//                         ),
//                       ); // Update the UI to show that item 1 was selected
//                     },
//                   ),
//                   ListTile(
//                     title: Text('Voucher'),
//                     onTap: () async {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) {
//                             return VoucherUpload(
//                               selectRoute: widget.selectRoute,
//                               fee: widget.fees,
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                   ListTile(
//                     title: Text('Boarding pass '),
//                     onTap: () async {
//                       // Check voucher status from Firestore
//                       String voucherStatus = await getVoucherStatus();
//
//                       if (voucherStatus == 'accepted') {
//                         // Navigate to the BoardingPass screen if the voucher is accepted
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => BoardingPass(
//                               selectRoute: widget
//                                   .selectRoute, // Replace with actual route
//                               fee: widget.fees, // Replace with actual fee
//                             ),
//                           ),
//                         );
//                       } else {
//                         // Show a message for rejected or pending voucher
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content:
//                                 Text('Please submit an authentic voucher.'),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//
//                   // ListTile(
//                   //   title: Text('Boarding pass'),
//                   //   onTap: () async {
//                   //     // Navigate to the VoucherDisplayScreen and wait for a result
//                   //     bool isVoucherAccepted = await Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(
//                   //         builder: (context) {
//                   //           return VoucherDisplayScreen(
//                   //             voucherDocumentID: widget.voucherDocumentID,
//                   //             voucherURL: widget.voucherURL,
//                   //           );
//                   //         },
//                   //       ),
//                   //     );
//                   //
//                   //     if (isVoucherAccepted == true) {
//                   //       // Navigate to the BoardingPass screen if the voucher is accepted
//                   //       Navigator.pushReplacement(
//                   //         context,
//                   //         MaterialPageRoute(
//                   //           builder: (context) => BoardingPass(
//                   //             selectRoute: '', // Replace with actual route
//                   //             fee: '', // Replace with actual fee
//                   //           ),
//                   //         ),
//                   //       );
//                   //     } else {
//                   //       // Show a message for rejected voucher
//                   //       ScaffoldMessenger.of(context).showSnackBar(
//                   //         SnackBar(
//                   //           content:
//                   //               Text('Please submit an authentic voucher.'),
//                   //         ),
//                   //       );
//                   //     }
//                   //   },
//                   // ),
//
//                   // ListView(
//                   //   children: [
//                   //     ListTile(
//                   //       title: Text('Boarding Pass'),
//                   //       onTap: () {
//                   //         Navigator.push(
//                   //           context,
//                   //           MaterialPageRoute(
//                   //             builder: (context) => VoucherDisplayScreen(
//                   //               voucherDocumentID: '', // Replace with your data
//                   //               voucherURL: '', // Replace with your data
//                   //             ),
//                   //           ),
//                   //         );
//                   //       },
//                   //     ),
//                   //   ],
//                   // ),
//
//                   ListTile(
//                     title: Text('Voucher Status '),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               voucherstatus(), // Replace PaymentScreen with your actual payment screen
//                         ),
//                       ); // Update the UI to show that item 1 was selected
//                     },
//                   ),
//                   ListTile(
//                     title: Text('Notification'),
//                     onTap: () {
//                       // Update the UI to show that item 2 was selected
//                     },
//                   ),
//                   ListTile(
//                     title: Text('Feedback'),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               feedback(), // Replace PaymentScreen with your actual payment screen
//                         ),
//                       );
//                     },
//                   ),
//                   ListTile(
//                     title: Text('discussion'),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               QueryScreen(), // Replace PaymentScreen with your actual payment screen
//                         ),
//                       ); // Update the UI to show that item 2 was selected
//                     },
//                   ),
//                   ListTile(
//                     title: Text('Setting '),
//                     onTap: () {
//                       // Update the UI to show that item 2 was selected
//                     },
//                   ),
//                   ListTile(
//                     title: Text('Help '),
//                     onTap: () {
//                       // Update the UI to show that item 2 was selected
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             body: SingleChildScrollView(
//                 child: SafeArea(
//               child: Column(children: [
//                 Center(
//                   child: const Image(
//                     width: 500,
//                     height: 500,
//                     image: AssetImage('assets/map live location.png'),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//
//                 // Display the "Upload Voucher" button if no voucher is uploaded
//
//                 Container(
//                   padding: EdgeInsets.all(16.0), // Adjust padding as needed
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Arrival Time',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                     '10:00 AM'), // Replace with actual arrival time
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Departure Time',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                     '11:00 AM'), // Replace with actual departure time
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Bus No.',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                     'LSG1297'), // Replace with actual bus number
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16.0), // Add spacing between rows
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 30.0, // Adjust size as needed
//                             backgroundImage: AssetImage(
//                                 'assets/driver.jpg'), // Replace with actual driver profile image
//                           ),
//                           SizedBox(
//                               width:
//                                   16.0), // Add spacing between image and text
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Driver ',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                   'Rizwan Ahmed '), // Replace with actual driver name
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )
//               ]),
//             ))));
//   }
// }

// class Home extends StatefulWidget {
//   final String selectRoute;
//   final String fees;
//   final String busnumber;
//   final String voucherDocumentID;
//   final String voucherURL;
//
//   Home(
//       {required this.selectRoute,
//       required this.fees,
//       required this.busnumber,
//       required this.voucherDocumentID,
//       required this.voucherURL}) {
//     assert(voucherDocumentID != null);
//   }
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   final auth = FirebaseAuth.instance;
//   String userName = '';
//   String? uploadedVoucherURL;
//
//   final ProfileController profileController = Get.find();
//
//   Future<String> getVoucherStatus() async {
//     // Check if the voucherDocumentID is null or empty
//     if (widget.voucherDocumentID == null || widget.voucherDocumentID.isEmpty) {
//       print('Voucher Document ID is null or empty.');
//       return 'pending';
//     }
//
//     // Replace with your Firestore logic to get the voucher status
//     DocumentSnapshot voucherSnapshot = await FirebaseFirestore.instance
//         .collection('Vouchers')
//         .doc('984QYKuJEwNO7MfsK9qj0ZjXAXB3')
//         .get();
//
//     if (voucherSnapshot.exists) {
//       String status = voucherSnapshot['status'] ?? 'pending';
//       print('Voucher Status: $status');
//       return status;
//     } else {
//       print('Voucher Status: pending');
//       return 'pending';
//     }
//   }
//
//   Widget build(BuildContext context) {
//     print('Voucher Document ID: ${widget.voucherDocumentID}');
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(title: Text('Home'), actions: [
//           IconButton(
//             onPressed: () {
//               auth.signOut().then((value) {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => LoginScreen(
//                               selectRoute: widget.selectRoute,
//                               fee: widget.fees,
//                               // voucherDocumentID: widget.voucherDocumentID,
//                               voucherDocumentID: (widget.voucherDocumentID),
//                             )));
//               }).onError((error, stackTrace) {
//                 utils().toastMessage(error.toString());
//               });
//             },
//             icon: Icon(Icons.logout_outlined),
//           ),
//           SizedBox(width: 10),
//         ]),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: <Widget>[
//               DrawerHeader(
//                 child: Column(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => profile()),
//                         );
//                       },
//                       child: CircleAvatar(
//                         radius: 50.0, // Adjust size as needed
//                         backgroundImage: AssetImage(
//                             'assets/profileimage.jpg'), // Replace with actual driver profile image
//                       ),
//                     ),
//                     FutureBuilder(
//                       future: profileController.getUserData(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           if (snapshot.hasData) {
//                             UserModel user = snapshot.data as UserModel;
//
//                             userName = user.fullName;
//
//                             return Text(
//                               userName,
//                               style: TextStyle(color: Colors.white),
//                             );
//                           }
//                         }
//                         // Return a loading indicator or error message if needed
//                         return CircularProgressIndicator(); // Change this to suit your UI
//                       },
//                     ),
//                   ],
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                 ),
//               ),
//               ListTile(
//                 title: Text('Payment'),
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => payfee(
//                           selectRoute: widget.selectRoute,
//                           fee: widget.fees,
//                           busnumber: widget
//                               .busnumber), // Replace PaymentScreen with your actual payment screen
//                     ),
//                   ); // Update the UI to show that item 1 was selected
//                 },
//               ),
//               ListTile(
//                 title: Text('Voucher'),
//                 onTap: () async {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return VoucherUpload(
//                           selectRoute: widget.selectRoute,
//                           fee: widget.fees,
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//               // ListTile(
//               //   title: Text('Boarding pass '),
//               //   onTap: () async {
//               //     // Check voucher status from Firestore
//               //     String voucherStatus = await getVoucherStatus();
//               //
//               //     if (voucherStatus == 'accepted') {
//               //       // Navigate to the BoardingPass screen if the voucher is accepted
//               //       Navigator.push(
//               //         context,
//               //         MaterialPageRoute(
//               //           builder: (context) => BoardingPass(
//               //             selectRoute: widget.selectRoute,
//               //             fee: widget.fees,
//               //           ),
//               //         ),
//               //       );
//               //     } else {
//               //       // Show a message for rejected or pending voucher
//               //       if (voucherStatus == 'rejected') {
//               //         // Show dialog for rejected voucher
//               //         showDialog(
//               //           context: context,
//               //           builder: (BuildContext context) {
//               //             return AlertDialog(
//               //               title: Text('Voucher Rejected'),
//               //               content: Text(
//               //                   'Your voucher has been rejected. Please submit an authentic voucher.'),
//               //               actions: <Widget>[
//               //                 TextButton(
//               //                   onPressed: () {
//               //                     Navigator.of(context).pop();
//               //                   },
//               //                   child: Text('OK'),
//               //                 ),
//               //               ],
//               //             );
//               //           },
//               //         );
//               //       } else if (voucherStatus == 'pending') {
//               //         // Show dialog for pending voucher
//               //         showDialog(
//               //           context: context,
//               //           builder: (BuildContext context) {
//               //             return AlertDialog(
//               //               title: Text('Voucher Pending'),
//               //               content: Text(
//               //                   'Your voucher is pending. Please wait for approval.'),
//               //               actions: <Widget>[
//               //                 TextButton(
//               //                   onPressed: () {
//               //                     Navigator.of(context).pop();
//               //                   },
//               //                   child: Text('OK'),
//               //                 ),
//               //               ],
//               //             );
//               //           },
//               //         );
//               //       } else if (voucherStatus == 'no_voucher') {
//               //         // Show dialog for no voucher uploaded
//               //         showDialog(
//               //           context: context,
//               //           builder: (BuildContext context) {
//               //             return AlertDialog(
//               //               title: Text('No Voucher Uploaded'),
//               //               content: Text(
//               //                 'You have not uploaded a voucher yet. Please upload a voucher.',
//               //               ),
//               //               actions: <Widget>[
//               //                 TextButton(
//               //                   onPressed: () {
//               //                     Navigator.of(context).pop();
//               //                   },
//               //                   child: Text('OK'),
//               //                 ),
//               //               ],
//               //             );
//               //           },
//               //         );
//               //       } else {
//               //         // Show a SnackBar for pending voucher
//               //         ScaffoldMessenger.of(context).showSnackBar(
//               //           SnackBar(
//               //             content: Text('Voucher status is pending.'),
//               //           ),
//               //         );
//               //       }
//               //     }
//               //   },
//               // ),
//               ListTile(
//                 title: Text('Boarding pass '),
//                 onTap: () async {
//                   // Check voucher status from Firestore
//                   String voucherStatus = await getVoucherStatus();
//
//                   if (voucherStatus == 'accepted') {
//                     // Navigate to the BoardingPass screen if the voucher is accepted
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => BoardingPass(
//                           selectRoute: widget.selectRoute,
//                           fee: widget.fees,
//                         ),
//                       ),
//                     );
//                   } else {
//                     // Show a message for rejected or pending voucher
//                     if (voucherStatus == 'rejected') {
//                       // Show dialog for rejected voucher
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: Text('Voucher Rejected'),
//                             content: Text(
//                                 'Your voucher has been rejected. Please submit an authentic voucher.'),
//                             actions: <Widget>[
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: Text('OK'),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     } else if (voucherStatus == 'pending') {
//                       // Show dialog for pending voucher
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: Text('Voucher Pending'),
//                             content: Text(
//                                 'Your voucher is pending. Please wait for approval.'),
//                             actions: <Widget>[
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: Text('OK'),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     } else {
//                       // Show a SnackBar for pending voucher
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Voucher status is pending.'),
//                         ),
//                       );
//                     }
//                   }
//                 },
//               ),
//               ListTile(
//                 title: Text('Voucher Status '),
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           voucherstatus(), // Replace PaymentScreen with your actual payment screen
//                     ),
//                   ); // Update the UI to show that item 1 was selected
//                 },
//               ),
//               ListTile(
//                 title: Text('Reservation Status '),
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           busbookstatus(), // Replace PaymentScreen with your actual payment screen
//                     ),
//                   ); // Update the UI to show that item 1 was selected
//                 },
//               ),
//               ListTile(
//                 title: Text('Notification'),
//                 onTap: () {
//                   // Update the UI to show that item 2 was selected
//                 },
//               ),
//               ListTile(
//                 title: Text('Feedback'),
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           feedback(), // Replace PaymentScreen with your actual payment screen
//                     ),
//                   );
//                 },
//               ),
//               ListTile(
//                 title: Text('discussion'),
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           QueryScreen(), // Replace PaymentScreen with your actual payment screen
//                     ),
//                   ); // Update the UI to show that item 2 was selected
//                 },
//               ),
//               ListTile(
//                 title: Text('Setting '),
//                 onTap: () {
//                   // Update the UI to show that item 2 was selected
//                 },
//               ),
//               ListTile(
//                 title: Text('Help '),
//                 onTap: () {
//                   // Update the UI to show that item 2 was selected
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: SafeArea(
//             child: Column(
//               children: [
//                 Center(
//                   child: const Image(
//                     width: 500,
//                     height: 500,
//                     image: AssetImage('assets/map live location.png'),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//
//                 // Display the "Upload Voucher" button if no voucher is uploaded
//
//                 Container(
//                   padding: EdgeInsets.all(16.0), // Adjust padding as needed
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Arrival Time',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                     '10:00 AM'), // Replace with actual arrival time
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Departure Time',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                     '11:00 AM'), // Replace with actual departure time
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Bus No.',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                     'LSG1297'), // Replace with actual bus number
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16.0), // Add spacing between rows
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 30.0, // Adjust size as needed
//                             backgroundImage: AssetImage(
//                                 'assets/driver.jpg'), // Replace with actual driver profile image
//                           ),
//                           SizedBox(
//                               width:
//                                   16.0), // Add spacing between image and text
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Driver ',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                   'Rizwan Ahmed '), // Replace with actual driver name
//                             ],
//                           ),
//                         ],
//                       ),
//
//                       // Check voucher status from Firestore
//                       // FutureBuilder(
//                       //   future: getVoucherStatus(),
//                       //   builder: (context, snapshot) {
//                       //     if (snapshot.connectionState ==
//                       //         ConnectionState.done) {
//                       //       String voucherStatus = snapshot.data as String;
//                       //
//                       //       // Show the Boarding Pass screen or a message based on the voucher status
//                       //       if (voucherStatus == 'accepted') {
//                       //         return ElevatedButton(
//                       //           onPressed: () {
//                       //             Navigator.push(
//                       //               context,
//                       //               MaterialPageRoute(
//                       //                 builder: (context) => BoardingPass(
//                       //                   selectRoute: widget.selectRoute,
//                       //                   fee: widget.fees,
//                       //                 ),
//                       //               ),
//                       //             );
//                       //           },
//                       //           child: Text('Go to Boarding Pass'),
//                       //         );
//                       //       } else {
//                       //         return Text(
//                       //           'Voucher Status: $voucherStatus',
//                       //           style: TextStyle(
//                       //             color: Colors.red,
//                       //             fontWeight: FontWeight.bold,
//                       //           ),
//                       //         );
//                       //       }
//                       //     } else {
//                       //       // Return a loading indicator or error message if needed
//                       //       return CircularProgressIndicator();
//                       //     }
//                       //   },
//                       // ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class Home extends StatefulWidget {
  final String selectRoute;
  final String fees;
  final String busnumber;
  final String voucherDocumentID;
  final String voucherURL;

  Home(
      {required this.selectRoute,
      required this.fees,
      required this.busnumber,
      required this.voucherDocumentID,
      required this.voucherURL}) {
    // assert(voucherDocumentID != null);
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = FirebaseAuth.instance;
  String userName = '';
  // String? uploadedVoucherURL;
  // String? voucherDocumentID;
  // String? VoucherURL;

  final ProfileController profileController = Get.find();

  Future<String> getVoucherStatus() async {
    // Check if the voucherDocumentID is null or empty
    if (widget.voucherDocumentID == null || widget.voucherDocumentID.isEmpty) {
      print('Voucher Document ID is null or empty.');
      return 'pending';
    }

    try {
      // Replace with your Firestore logic to get the voucher status
      DocumentSnapshot voucherSnapshot = await FirebaseFirestore.instance
          .collection('Vouchers')
          .doc(widget.voucherDocumentID)
          .get();

      if (voucherSnapshot.exists) {
        String status = voucherSnapshot['status'] ?? 'pending';
        print('Voucher Document ID: ${widget.voucherDocumentID}');
        print('Voucher Status: $status');
        return status;
      } else {
        print('Voucher Document ID: ${widget.voucherDocumentID}');
        print('Voucher Status: pending');
        return 'pending';
      }
    } catch (e) {
      print('Error getting voucher status: $e');
      return 'error';
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Home'), actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen(
                              selectRoute: widget.selectRoute,
                              fee: widget.fees,
                              // voucherDocumentID: widget.voucherDocumentID,
                              voucherDocumentID: (widget.voucherDocumentID),
                              voucherURL: widget.voucherURL,
                              bus: widget.busnumber,
                            )));
              }).onError((error, stackTrace) {
                utils().toastMessage(error.toString());
              });
            },
            icon: Icon(Icons.logout_outlined),
          ),
          SizedBox(width: 10),
        ]),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => profile()),
                        );
                      },
                      child: CircleAvatar(
                        radius: 50.0, // Adjust size as needed
                        backgroundImage: AssetImage(
                            'assets/profileimage.jpg'), // Replace with actual driver profile image
                      ),
                    ),
                    FutureBuilder(
                      future: profileController.getUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            UserModel user = snapshot.data as UserModel;

                            userName = user.fullName;

                            return Text(
                              userName,
                              style: TextStyle(color: Colors.white),
                            );
                          }
                        }
                        // Return a loading indicator or error message if needed
                        return CircularProgressIndicator(); // Change this to suit your UI
                      },
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Payment'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => payfee(
                          selectRoute: widget.selectRoute,
                          fee: widget.fees,
                          busnumber: widget
                              .busnumber), // Replace PaymentScreen with your actual payment screen
                    ),
                  ); // Update the UI to show that item 1 was selected
                },
              ),
              ListTile(
                title: Text('Voucher'),
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return VoucherUpload(
                          selectRoute: widget.selectRoute,
                          fee: widget.fees,
                          bus: widget.busnumber,
                        );
                      },
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Boarding pass '),
                onTap: () async {
                  // Check voucher status from Firestore
                  String voucherStatus = await getVoucherStatus();

                  if (voucherStatus == 'accepted') {
                    // Navigate to the BoardingPass screen if the voucher is accepted
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BoardingPass(
                          selectRoute: widget.selectRoute,
                          fee: widget.fees,
                          bus: widget.busnumber,
                        ),
                      ),
                    );
                  } else {
                    // Show a message for rejected or pending voucher
                    if (voucherStatus == 'rejected') {
                      // Show dialog for rejected voucher
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Voucher Rejected'),
                            content: Text(
                                'Your voucher has been rejected. Please submit an authentic voucher.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (voucherStatus == 'pending') {
                      // Show dialog for pending voucher
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Voucher Pending'),
                            content: Text(
                                'Your voucher is pending. Please wait for approval.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // Show a SnackBar for pending voucher
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Voucher status is pending.'),
                      //   ),
                      // );
                    }
                  }
                },
              ),
              ListTile(
                title: Text('Voucher Status '),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          voucherstatus(), // Replace PaymentScreen with your actual payment screen
                    ),
                  ); // Update the UI to show that item 1 was selected
                },
              ),
              ListTile(
                title: Text('Reservation Status '),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          busbookstatus(), // Replace PaymentScreen with your actual payment screen
                    ),
                  ); // Update the UI to show that item 1 was selected
                },
              ),
              ListTile(
                title: Text('Notification'),
                onTap: () {
                  // Update the UI to show that item 2 was selected
                },
              ),
              ListTile(
                title: Text('Feedback'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          feedback(), // Replace PaymentScreen with your actual payment screen
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('discussion'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          QueryScreen(), // Replace PaymentScreen with your actual payment screen
                    ),
                  ); // Update the UI to show that item 2 was selected
                },
              ),
              ListTile(
                title: Text('Setting '),
                onTap: () {
                  // Update the UI to show that item 2 was selected
                },
              ),
              ListTile(
                title: Text('Help '),
                onTap: () {
                  // Update the UI to show that item 2 was selected
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Center(
                  child: const Image(
                    width: 500,
                    height: 500,
                    image: AssetImage('assets/map live location.png'),
                  ),
                ),
                SizedBox(height: 20),

                // Display the "Upload Voucher" button if no voucher is uploaded

                Container(
                  padding: EdgeInsets.all(16.0), // Adjust padding as needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Arrival Time',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '10:00 AM'), // Replace with actual arrival time
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Departure Time',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '11:00 AM'), // Replace with actual departure time
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bus No.',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    'LSG1297'), // Replace with actual bus number
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0), // Add spacing between rows
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30.0, // Adjust size as needed
                            backgroundImage: AssetImage(
                                'assets/driver.jpg'), // Replace with actual driver profile image
                          ),
                          SizedBox(
                              width:
                                  16.0), // Add spacing between image and text
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Driver ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  'Rizwan Ahmed '), // Replace with actual driver name
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
