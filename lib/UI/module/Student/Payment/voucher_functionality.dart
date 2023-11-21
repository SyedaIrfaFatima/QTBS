import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:test_project/UI/module/Student/HomeScreen/Homee.dart';

import '../../../../Authentication/models/User_model.dart';
import '../Profile/profile_controller.dart';
import 'package:timezone/timezone.dart' as tz;

class BoardingPassFunctionality {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _busRegistrationCollection = FirebaseFirestore
      .instance
      .collection('BusRegistrations'); // Define it as a CollectionReference
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<void> initNotifications() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'fee_channel', // ID
      'Fee Notifications', // Title
      description: 'Notifications for fee payments',
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<DateTime> fetchRegistrationData() async {
    final user = _auth.currentUser;
    if (user == null) {
      return DateTime.now(); // Return the current date in case of an error
    }

    final userId = user.uid;

    try {
      final querySnapshot = await _busRegistrationCollection
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        final dateFromFirestore = data['registrationDate'];

        // Validate and convert the date to 'yyyy-MM-dd' format
        final validDate = validateAndConvertDate(dateFromFirestore);

        if (validDate != null) {
          // Calculate the next notification date as one day after the registration date
          final nextNotificationDate = validDate.add(Duration(days: 30));

          // Schedule the first payment notification
          schedulePaymentNotification(nextNotificationDate);

          return nextNotificationDate; // Return the calculated date
        }
      }
    } catch (error) {
      // Handle errors here if needed
      print('Error fetching Firestore data: $error');
    }

    return DateTime.now(); // Return the current date if any error occurs
  }

  DateTime? validateAndConvertDate(String dateFromFirestore) {
    try {
      final parts = dateFromFirestore.split('-');
      if (parts.length == 3) {
        final year = int.tryParse(parts[0]);
        final month = int.tryParse(parts[1]);
        final day = int.tryParse(parts[2]);
        if (year != null && month != null && day != null) {
          return DateTime(year, month, day);
        }
      }
    } catch (e) {
      print('Error validating and converting date: $e');
    }
    return null; // Invalid date
  }

  void schedulePaymentNotification(DateTime registrationDate) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final now = tz.TZDateTime.now(tz.local);
    final nextPaymentDate = tz.TZDateTime(tz.local, registrationDate.year,
        registrationDate.month, registrationDate.day + 30);
    final difference = nextPaymentDate.isBefore(now) ? now : nextPaymentDate;

    if (difference.isAfter(now)) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Payment Reminder',
        'It\'s time to pay your monthly fee!',
        difference,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'fee_channel', // Channel ID
            'Fee Notifications',
            // 'Notifications for fee payments',
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}
