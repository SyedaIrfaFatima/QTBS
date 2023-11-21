// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:intl/intl.dart';
// import 'package:test_project/UI/module/Student/HomeScreen/Homee.dart';
// import 'package:test_project/UI/module/Student/Payment/voucher_controller.dart';
//
// import '../../../../Authentication/models/User_model.dart';
// import '../Profile/profile_controller.dart';
// import 'package:timezone/timezone.dart' as tz;
//
// class voucherUI extends StatefulWidget {
//   final VoucherFunctionality functionality;
//
//   voucherUI({required this.functionality});
//
//   @override
//   State<voucherUI> createState() => _voucherUIState();
// }
//
// class _voucherUIState extends State<voucherUI> {
//   String userName = ''; // Store the user's name
//   String sapId = '';
//   String registrationDate = '';
//   DateTime parsedDate = DateTime.now();
//   bool isDeadlineExceeded = false;
//   final ProfileController profileController = Get.find();
//   DateTime parsedDate = DateTime.now();
//
//   final GlobalKey repaintBoundaryKey = GlobalKey();
//
//   @override
//   void initState() {
//     super.initState();
//     initNotifications();
//     // Fetch the registration date
//     // fetchRegistrationData();
//     // DateTime parsedDate = DateTime.now();
//     //
//     // // Schedule the first payment notification
//     // schedulePaymentNotification(parsedDate);
//
//     fetchRegistrationData().then((registrationDate) {
//       // Schedule the first payment notification
//       schedulePaymentNotification(registrationDate);
//       setState(() {
//         isDeadlineExceeded = isPaymentDeadlineExceeded(parsedDate);
//       });
//     });
//   }
//
//   Widget buildVoucherContent() {
//     return RepaintBoundary(
//       key: GlobalKey(), // Create a key for the RepaintBoundary
//       child: Container(
//         width: 360,
//         height: 340,
//         padding: EdgeInsets.all(4.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Include the same content as before
//             // ...
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget buildSingleSection() {
//     return Row(
//       children: [
//         Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/logo.png'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(top: 0),
//           child: Text(
//             ' RIU Gulberg Green Isb \n  Transport Fee Challan',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 7.0,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget buildSingleSectionWithUnderline() {
//     return Row(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(left: 40),
//           child: Row(
//             children: [
//               Row(
//                 children: [
//                   Center(
//                     child: Text(
//                       'Bank Meezan',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 9.0,
//                       ),
//                       textAlign: TextAlign.justify,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           width: 15,
//         ),
//       ],
//     );
//   }
//
//   Widget buildSingleCard() {
//     return Row(
//       children: [
//         Card(
//           margin: EdgeInsets.all(2),
//           child: FutureBuilder(
//             future: profileController.getUserData(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.hasData) {
//                   UserModel user = snapshot.data as UserModel;
//
//                   userName = user.fullName;
//                   sapId = user.Sapid;
//
//                   return Padding(
//                     padding: EdgeInsets.all(1),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 20),
//                         Row(
//                           children: [
//                             Text(
//                               'Date:',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 9.0,
//                               ),
//                               textAlign: TextAlign.justify,
//                             ),
//                             SizedBox(width: 10),
//                             Text(
//                               registrationDate,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 7.0,
//                               ),
//                               textAlign: TextAlign.justify,
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 15),
//                         Row(
//                           children: [
//                             Text(
//                               'Name:',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 6.5,
//                               ),
//                               textAlign: TextAlign.justify,
//                             ),
//                             SizedBox(width: 5),
//                             Text(
//                               userName,
//                               style: TextStyle(
//                                 fontSize: 6.5,
//                               ),
//                               textAlign: TextAlign.justify,
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           children: [
//                             Text(
//                               'Sap Id:',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 6.5,
//                               ),
//                               textAlign: TextAlign.justify,
//                             ),
//                             SizedBox(width: 5),
//                             Text(
//                               sapId,
//                               style: TextStyle(
//                                 fontSize: 6.5,
//                               ),
//                               textAlign: TextAlign.justify,
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10),
//                         // Row(
//                         //   children: [
//                         //     Text(
//                         //       'Bus:',
//                         //       style: TextStyle(
//                         //         fontWeight: FontWeight.bold,
//                         //         fontSize: 6.5,
//                         //       ),
//                         //       textAlign: TextAlign.justify,
//                         //     ),
//                         //     SizedBox(width: 5),
//                         //     Text(
//                         //       widget.bus,
//                         //       style: TextStyle(
//                         //         fontSize: 6.5,
//                         //       ),
//                         //       textAlign: TextAlign.justify,
//                         //     ),
//                         //   ],
//                         // ),
//                         SizedBox(height: 10),
//                         Row(
//                           children: [
//                             Text(
//                               'Route',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 6.5,
//                               ),
//                               textAlign: TextAlign.justify,
//                             ),
//                             SizedBox(width: 5),
//                             Text(
//                               widget.route,
//                               style: TextStyle(
//                                 fontSize: 6.5,
//                               ),
//                               textAlign: TextAlign.justify,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               }
//               // Return a loading indicator or error message if needed
//               return CircularProgressIndicator(); // Change this to suit your UI
//             },
//           ),
//         ),
//         SizedBox(
//           width: 18,
//         ),
//       ],
//     );
//   }
//
//   Widget builddescription() {
//     return Row(children: [
//       Card(
//           margin: EdgeInsets.all(2), // Adjust margin as needed
//           child: Padding(
//             padding: EdgeInsets.all(1), // Adjust padding as needed
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               SizedBox(height: 10),
//               Row(children: [
//                 Text(
//                   'Description:',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 9.0,
//                   ),
//                   textAlign: TextAlign.justify,
//                 ),
//                 SizedBox(width: 10),
//                 Text(
//                   'Amount',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 9.0,
//                   ),
//                   textAlign: TextAlign.justify,
//                 ),
//               ])
//             ]),
//           )),
//       SizedBox(width: 20),
//     ]);
//   }
//
//   Widget tranferfee() {
//     int totalFee = calculateTotalFee(parsedDate);
//     return Row(
//       children: [
//         Text(
//           'Transport Fee:',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 9.0,
//           ),
//           textAlign: TextAlign.justify,
//         ),
//         SizedBox(width: 10),
//         Text(
//           '$totalFee',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 9.0,
//           ),
//           textAlign: TextAlign.justify,
//         ),
//         SizedBox(width: 20),
//       ],
//     );
//   }
//
//   Widget paymentdeadline(currentDateStr, isDeadlineExceeded) {
//     bool isDeadlineExceeded = isPaymentDeadlineExceeded(parsedDate);
//     return Row(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(left: 0),
//           child: Row(
//             children: [
//               Text(
//                 'Payment deadline',
//                 style: TextStyle(
//                   fontSize: 6.5,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.justify,
//               ),
//               SizedBox(width: 2),
//               Text(
//                 DateFormat('yyyy-MM-dd').format(
//                   DateTime.parse(registrationDate).add(Duration(days: 5)),
//                 ), // Use the fixed payment deadline
//                 style: TextStyle(
//                   fontSize: 6.5,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.justify,
//               ),
//               SizedBox(width: 25),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget stamp() {
//     return Row(
//       children: [
//         Text(
//           'Bank Stamp:',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 10.0,
//           ),
//           textAlign: TextAlign.justify,
//         ),
//         SizedBox(width: 58),
//       ],
//     );
//   }
//
//   Widget Signature() {
//     return Row(
//       children: [
//         Text(
//           'Signature:',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 10.0,
//           ),
//           textAlign: TextAlign.justify,
//         ),
//         SizedBox(width: 70),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final currentDateTime = DateTime.now();
//
//     // Format dates as strings
//     final currentDateStr = DateFormat('dd/MM/yyyy').format(currentDateTime);
//     // Check if the payment deadline is exceeded
//     bool isDeadlineExceeded = isPaymentDeadlineExceeded(parsedDate);
//
//     return MaterialApp(
//       color: Colors.blue,
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Voucher'),
//           leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               }),
//           actions: [
//             IconButton(
//               icon: Icon(
//                 Icons.download,
//                 color: Colors.white,
//               ),
//               onPressed: () async {
//                 // Capture and save PDF as before
//                 await _captureAndSavePdf(repaintBoundaryKey);
//
//                 // Get the app's documents directory
//                 final directory = await getApplicationDocumentsDirectory();
//                 final filePath = '${directory.path}/voucher.pdf';
//
//                 // Show a confirmation message
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Voucher downloaded successfully!'),
//                   ),
//                 );
//
//                 // Optionally, open or share the saved PDF
//                 // Example: Open the file using the default PDF viewer
//                 OpenFile.open(filePath);
//               },
//             ),
//             IconButton(
//               icon: Icon(
//                 Icons.share,
//                 color: Colors.white,
//               ),
//               onPressed: () {},
//             ),
//           ],
//         ),
//         body: Stack(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/Bus background.png'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 250, top: 190),
//               child: Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.blue,
//                   ),
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.arrow_forward_ios,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           // MaterialPageRoute(
//                           //     builder: (context) => VoucherUpload(
//                           //           selectRoute: widget.route,
//                           //           fee: widget.fee,
//                           //         ))
//
//                           MaterialPageRoute(
//                               builder: (context) => linkedscreen()));
//                     },
//                   )),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Trigger a test notification
//                 _showTestNotification();
//               },
//               child: Text('Test Notification'),
//             ),
//             Center(
//               child: Container(
//                 margin: EdgeInsets.only(top: 180),
//                 width: 360,
//                 height: 340,
//                 padding: EdgeInsets.all(4.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8.0),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(children: [
//                       for (int i = 0; i < 3; i++) buildSingleSection(),
//                     ]),
//                     Row(children: [
//                       for (int i = 0; i < 3; i++)
//                         buildSingleSectionWithUnderline(),
//                     ]),
//                     Padding(
//                       padding: EdgeInsets.only(left: 40),
//                       child: Row(
//                         children: [
//                           Row(
//                             children: [
//                               const Center(
//                                 child: Text(
//                                   'University Copy',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 9.0,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             width: 45,
//                           ),
//                           Row(
//                             children: [
//                               const Center(
//                                 child: Text(
//                                   'Student Copy',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 9.0,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                   textAlign: TextAlign.justify,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             width: 60,
//                           ),
//                           Row(
//                             children: [
//                               const Center(
//                                 child: Text(
//                                   'Bank Copy',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 9.0,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                   textAlign: TextAlign.justify,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(children: [
//                       for (int i = 0; i < 3; i++) buildSingleCard(),
//                     ]),
//                     Row(children: [
//                       for (int i = 0; i < 3; i++) builddescription(),
//                     ]),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(children: [
//                       for (int i = 0; i < 3; i++) tranferfee(),
//                     ]),
//                     Row(children: [
//                       for (int i = 0; i < 3; i++)
//                         paymentdeadline(currentDateStr, isDeadlineExceeded),
//                     ]),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(children: [
//                       for (int i = 0; i < 3; i++) stamp(),
//                     ]),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(children: [
//                       for (int i = 0; i < 3; i++) Signature(),
//                     ]),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
