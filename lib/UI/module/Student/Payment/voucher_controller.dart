// import 'dart:js';
// import 'dart:typed_data';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:open_file/open_file.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:path_provider/path_provider.dart';
//
// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
//
// import 'package:flutter/rendering.dart';
// import 'package:http/http.dart' as http;
//
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'dart:io';
// import 'dart:ui' as ui; // Import 'dart:ui' for ui.Image
//
// import 'package:image/image.dart' as img;
// import 'package:test_project/UI/module/Student/notification_services/linkedscreen.dart';
//
// import '../../../../Authentication/models/User_model.dart';
// import '../../../../main.dart';
// import '../Profile/profile_controller.dart';
// import 'Uploadvoucher.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
//
// class VoucherFunctionality {
//   final FirebaseFirestore db;
//   final String userId;
//   final String route;
//   final String fee;
//   final String bus;
//
//   VoucherFunctionality({
//     required this.db,
//     required this.userId,
//     required this.route,
//     required this.fee,
//     required this.bus,
//   });
//
//   String userName = '';
//   String sapId = '';
//   DateTime parsedDate = DateTime.now();
//   String registrationDate = '';
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final busRegistrationCollection =
//       FirebaseFirestore.instance.collection('BusRegistrations');
//   String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   Future<void> _captureAndSavePdf(GlobalKey repaintKey) async {
//     try {
//       RenderRepaintBoundary boundary = repaintKey.currentContext!
//           .findRenderObject() as RenderRepaintBoundary;
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData? byteData =
//           await image.toByteData(format: ui.ImageByteFormat.png);
//       Uint8List pngBytes = byteData!.buffer.asUint8List();
//
//       // Convert the image to a PDF
//       final pdf = pw.Document();
//       pdf.addPage(pw.Page(
//         build: (pw.Context context) {
//           return pw.Image(pw.MemoryImage(pngBytes));
//         },
//       ));
//
//       // Get the app's documents directory
//       final directory = await getApplicationDocumentsDirectory();
//       final filePath = '${directory.path}/voucher.pdf';
//
//       // Save the PDF to the app's documents directory
//       File file = File(filePath);
//       await file.writeAsBytes(await pdf.save());
//
//       // Display a download link
//       print('PDF saved to: $filePath');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Voucher PDF saved successfully!'),
//         ),
//       );
//     } catch (e) {
//       print('Error capturing and saving PDF: $e');
//     }
//   }
//
//   Future<void> initNotifications() async {
//     tz.initializeTimeZones();
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'fee_channel',
//       'Fee Notifications',
//       description: 'Notifications for fee payments',
//     );
//
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//   }
//
//   Future<DateTime> fetchRegistrationData() async {
//     final user = _auth.currentUser;
//     if (user == null) {
//       return DateTime.now(); // Return the current date in case of an error
//     }
//
//     final userId = user.uid;
//
//     try {
//       final querySnapshot = await busRegistrationCollection
//           .where('userId', isEqualTo: userId)
//           .get();
//
//       if (querySnapshot.docs.isNotEmpty) {
//         final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
//         final busNumber = data['busNumber'];
//         final dateFromFirestore = data['registrationDate'];
//
//         // Validate and convert the date to 'yyyy-MM-dd' format
//         final validDate = validateAndConvertDate(dateFromFirestore);
//
//         if (validDate != null) {
//           parsedDate = validDate;
//
//           // Calculate the next notification date as one month after the registration date
//           final nextNotificationDate = parsedDate.add(Duration(days: 1));
//
//           // Schedule the first payment notification using parsedDate
//           schedulePaymentNotification(parsedDate);
//
//           setState(() {
//             registrationDate = DateFormat('yyyy-MM-dd').format(parsedDate);
//           });
//
//           return nextNotificationDate; // Return the calculated date
//         } else {
//           print('Invalid date format: $dateFromFirestore');
//           // Handle the case where the date is in an invalid format
//         }
//       }
//     } catch (error) {
//       // Handle errors here if needed
//       print('Error fetching Firestore data: $error');
//     }
//
//     return DateTime.now(); // Return the current date if any error occurs
//   }
//
//   DateTime? validateAndConvertDate(String dateFromFirestore) {
//     try {
//       final parts = dateFromFirestore.split('-');
//       if (parts.length == 3) {
//         final year = int.tryParse(parts[0]);
//         final month = int.tryParse(parts[1]);
//         final day = int.tryParse(parts[2]);
//         if (year != null && month != null && day != null) {
//           return DateTime(year, month, day);
//         }
//       }
//     } catch (e) {
//       print('Error validating and converting date: $e');
//     }
//     return null; // Invalid date
//   }
//
//   void schedulePaymentNotification(DateTime registrationDate) async {
//     final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     final now = tz.TZDateTime.now(tz.local);
//     final nextPaymentDate = tz.TZDateTime(tz.local, registrationDate.year,
//         registrationDate.month, registrationDate.day + 30);
//     final difference = nextPaymentDate.isBefore(now) ? now : nextPaymentDate;
//
//     if (difference.isAfter(now)) {
//       await flutterLocalNotificationsPlugin.zonedSchedule(
//         0,
//         'Payment Reminder',
//         'It\'s time to pay your monthly fee!',
//         difference,
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'fee_channel', // Channel ID
//             'Fee Notifications',
//             // 'Notifications for fee payments',
//           ),
//         ),
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//       );
//     }
//   }
//
//   int calculateTotalFee(DateTime registrationDate) {
//     DateTime paymentDeadline = registrationDate.add(Duration(days: 5));
//
//     if (registrationDate.weekday == DateTime.saturday ||
//         registrationDate.weekday == DateTime.sunday) {
//       paymentDeadline = paymentDeadline.add(Duration(days: 2));
//     }
//
//     // Calculate the number of days between today and the payment deadline
//     DateTime today = DateTime.now();
//     int daysDifference = paymentDeadline.difference(today).inDays;
//
//     // If the payment deadline is exceeded, add a fine of 100 Rupees per day
//     int fine = 0;
//     if (daysDifference < 0) {
//       fine = -daysDifference * 100;
//       sendPaymentDeadlineNotification();
//     }
//
//     // Remove commas from the fee string and parse it into an integer
//     int initialFee = int.parse(widget.fee.replaceAll(',', ''));
//
//     // Calculate the total fee by adding the fine to the initial fee
//     int totalFee = initialFee + fine;
//     return totalFee;
//   }
//
//   bool isPaymentDeadlineExceeded(DateTime registrationDate) {
//     DateTime paymentDeadline = registrationDate.add(Duration(days: 5));
//
//     if (registrationDate.weekday == DateTime.saturday ||
//         registrationDate.weekday == DateTime.sunday) {
//       paymentDeadline = paymentDeadline.add(Duration(days: 2));
//     }
//
//     DateTime today = DateTime.now();
//     int daysDifference = paymentDeadline.difference(today).inDays;
//
//     return daysDifference < 0;
//   }
//
//   void sendPaymentDeadlineNotification() async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       1,
//       'Payment Deadline Exceeded',
//       'Please pay your monthly fee to avoid additional charges.',
//       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'fee_channel',
//           'Fee Notifications',
//         ),
//       ),
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }
//
//   Future<void> _showTestNotification() async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       2, // Use a unique ID for each notification
//       'Test Notification',
//       'This is a test notification.',
//       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'test_channel', // Use a unique channel ID for testing
//           'Test Notifications',
//         ),
//       ),
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }
// }
