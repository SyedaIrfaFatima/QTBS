import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:ui' as ui; // Import 'dart:ui' for ui.Image

import 'package:image/image.dart' as img;
import '../../../../Authentication/models/User_model.dart';
import '../../../../main.dart';
import '../Profile/profile_controller.dart';
import 'Uploadvoucher.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class voucher extends StatefulWidget {
  final FirebaseFirestore db;
  final String userId;
  final String route;
  final String fee;
  final String bus;
  voucher({
    required this.db,
    required this.userId,
    required this.route,
    required this.fee,
    required this.bus,
  });

  @override
  _voucherState createState() => _voucherState();
}

class _voucherState extends State<voucher> {
  String userName = ''; // Store the user's name
  String sapId = '';
  final ProfileController profileController = Get.find();
  DateTime parsedDate = DateTime.now();

  String registrationDate = '';

  final GlobalKey repaintBoundaryKey = GlobalKey();
  final _auth = FirebaseAuth.instance;

  final busRegistrationCollection =
      FirebaseFirestore.instance.collection('BusRegistrations');
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    initNotifications();

    fetchRegistrationData().then((registrationDate) {
      // Schedule the first payment notification
      schedulePaymentNotification(registrationDate);
    });
  }

  Future<void> saveDataToFirestore() async {
    // final userId =

    try {
      final user = FirebaseAuth.instance.currentUser;
      await widget.db.collection('VouchersStatus').add({
        'userId': user?.uid,
        'name': userName,
        'sapid': sapId,
        'route': widget.route,
        'date': registrationDate,
        'fee': widget.fee,
        'fine': calculateFineAfterDeadline(parsedDate).toString(),
      });

      print('Data saved to Firestore successfully!');
    } catch (error) {
      print('Error saving data to Firestore: $error');
    }
  }

  Future<void> _captureAndSavePdf(GlobalKey repaintKey) async {
    try {
      RenderRepaintBoundary boundary = repaintKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Convert the image to a PDF
      final pdf = pw.Document();
      pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Image(pw.MemoryImage(pngBytes));
        },
      ));

      // Get the app's documents directory
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/voucher.pdf';

      // Save the PDF to the app's documents directory
      File file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      // Display a download link
      print('PDF saved to: $filePath');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Voucher PDF saved successfully!'),
        ),
      );
    } catch (e) {
      print('Error capturing and saving PDF: $e');
    }
  }

  Future<void> initNotifications() async {
    tz.initializeTimeZones();
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'fee_channel',
      'Fee Notifications',
      description: 'Notifications for fee payments',
    );

    await flutterLocalNotificationsPlugin
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
      final querySnapshot = await busRegistrationCollection
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        final busNumber = data['busNumber'];
        final dateFromFirestore = data['registrationDate'];

        // Validate and convert the date to 'yyyy-MM-dd' format
        final validDate = validateAndConvertDate(dateFromFirestore);

        if (validDate != null) {
          parsedDate = validDate;

          // Calculate the next notification date as one month after the registration date
          final nextNotificationDate = parsedDate.add(Duration(days: 1));

          // Schedule the first payment notification using parsedDate
          schedulePaymentNotification(parsedDate);

          setState(() {
            registrationDate = DateFormat('yyyy-MM-dd').format(parsedDate);
          });

          return nextNotificationDate; // Return the calculated date
        } else {
          print('Invalid date format: $dateFromFirestore');
          // Handle the case where the date is in an invalid format
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

  int calculateTotalFee(DateTime registrationDate) {
    DateTime paymentDeadline = registrationDate.add(Duration(days: 5));

    if (registrationDate.weekday == DateTime.saturday ||
        registrationDate.weekday == DateTime.sunday) {
      paymentDeadline = paymentDeadline.add(Duration(days: 2));
    }

    // Calculate the number of days between today and the payment deadline
    DateTime today = DateTime.now();
    int daysDifference = paymentDeadline.difference(today).inDays;

    // If the payment deadline is exceeded, add a fine of 100 Rupees per day
    int fine = 0;
    if (daysDifference < 0) {
      fine = -daysDifference * 100;
      sendPaymentDeadlineNotification();
    }

    // Remove commas from the fee string and parse it into an integer
    int initialFee = int.parse(widget.fee.replaceAll(',', ''));

    // Calculate the total fee by adding the fine to the initial fee
    int totalFee = initialFee + fine;
    return totalFee;
  }

  int calculateFineAfterDeadline(DateTime registrationDate) {
    DateTime paymentDeadline = registrationDate.add(Duration(days: 5));

    if (registrationDate.weekday == DateTime.saturday ||
        registrationDate.weekday == DateTime.sunday) {
      paymentDeadline = paymentDeadline.add(Duration(days: 2));
    }

    // Calculate the number of days between today and the payment deadline
    DateTime today = DateTime.now();
    int daysDifference = paymentDeadline.difference(today).inDays;

    // If the payment deadline is exceeded, calculate the fine after the deadline
    if (daysDifference < 0) {
      int dailyFine = 100; // Adjust the fine amount as needed
      return -daysDifference * dailyFine;
    }

    return 0; // No fine if the payment is not overdue
  }

  bool isPaymentDeadlineExceeded(DateTime registrationDate) {
    DateTime paymentDeadline = registrationDate.add(Duration(days: 5));

    if (registrationDate.weekday == DateTime.saturday ||
        registrationDate.weekday == DateTime.sunday) {
      paymentDeadline = paymentDeadline.add(Duration(days: 2));
    }

    DateTime today = DateTime.now();
    int daysDifference = paymentDeadline.difference(today).inDays;

    return daysDifference < 0;
  }

  void sendPaymentDeadlineNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      'Payment Deadline Exceeded',
      'Please pay your monthly fee to avoid additional charges.',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'fee_channel',
          'Fee Notifications',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Widget buildVoucherContent() {
    return RepaintBoundary(
      key: GlobalKey(), // Create a key for the RepaintBoundary
      child: Container(
        width: 360,
        height: 340,
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Include the same content as before
            // ...
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSingleSection() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0),
          child: Text(
            ' RIU Gulberg Green Isb \n  Transport Fee Challan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 7.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSingleSectionWithUnderline() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 40),
          child: Row(
            children: [
              Row(
                children: [
                  Center(
                    child: Text(
                      'Bank Meezan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 9.0,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }

  Widget buildSingleCard() {
    return Row(
      children: [
        Card(
          margin: EdgeInsets.all(2),
          child: FutureBuilder(
            future: profileController.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;

                  userName = user.fullName;
                  sapId = user.Sapid;

                  return Padding(
                    padding: EdgeInsets.all(1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Date:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 9.0,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(width: 10),
                            Text(
                              registrationDate,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 7.0,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'Name:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 6.5,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(width: 5),
                            Text(
                              userName,
                              style: TextStyle(
                                fontSize: 6.5,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Sap Id:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 6.5,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(width: 5),
                            Text(
                              sapId,
                              style: TextStyle(
                                fontSize: 6.5,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),

                        // SizedBox(height: 10),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'Bus:',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 6.5,
                        //       ),
                        //       textAlign: TextAlign.justify,
                        //     ),
                        //     SizedBox(width: 5),
                        //     Text(
                        //       widget.bus,
                        //       style: TextStyle(
                        //         fontSize: 6.5,
                        //       ),
                        //       textAlign: TextAlign.justify,
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Route',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 6.5,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(width: 5),
                            Text(
                              widget.route,
                              style: TextStyle(
                                fontSize: 6.5,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              }
              // Return a loading indicator or error message if needed
              return CircularProgressIndicator(); // Change this to suit your UI
            },
          ),
        ),
        SizedBox(
          width: 18,
        ),
      ],
    );
  }

  Widget builddescription() {
    return Row(children: [
      Card(
          margin: EdgeInsets.all(2), // Adjust margin as needed
          child: Padding(
            padding: EdgeInsets.all(1), // Adjust padding as needed
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 10),
              Row(children: [
                Text(
                  'Description:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 9.0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(width: 10),
                Text(
                  'Amount',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 9.0,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ])
            ]),
          )),
      SizedBox(width: 20),
    ]);
  }

  Widget tranferfee() {
    int totalFee = calculateTotalFee(parsedDate);
    return Row(
      children: [
        Text(
          'Transport Fee:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 9.0,
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(width: 10),
        Text(
          '$totalFee',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 9.0,
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(width: 20),
      ],
    );
  }

  Widget fineaddedd() {
    int fineAfterDeadline = calculateFineAfterDeadline(parsedDate);

    return Row(
      children: [
        Text(
          ' Fine',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 8.0,
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(width: 40),
        Text(
          '$fineAfterDeadline',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 8.0,
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(width: 40),
      ],
    );
  }

  Widget paymentdeadline(currentDateStr, isDeadlineExceeded) {
    bool isDeadlineExceeded = isPaymentDeadlineExceeded(parsedDate);
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 0),
          child: Row(
            children: [
              Text(
                'Payment deadline',
                style: TextStyle(
                  fontSize: 6.5,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(width: 2),
              Text(
                DateFormat('yyyy-MM-dd').format(
                  DateTime.parse(registrationDate).add(Duration(days: 5)),
                ), // Use the fixed payment deadline
                style: TextStyle(
                  fontSize: 6.5,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(width: 25),
            ],
          ),
        ),
      ],
    );
  }

  Widget stamp() {
    return Row(
      children: [
        Text(
          'Bank Stamp:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10.0,
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(width: 58),
      ],
    );
  }

  Widget Signature() {
    return Row(
      children: [
        Text(
          'Signature:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10.0,
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(width: 70),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentDateTime = DateTime.now();

    // Format dates as strings
    final currentDateStr = DateFormat('dd/MM/yyyy').format(currentDateTime);
    // Check if the payment deadline is exceeded
    bool isDeadlineExceeded = isPaymentDeadlineExceeded(parsedDate);

    return MaterialApp(
      color: Colors.blue,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Voucher',
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
              }),
          actions: [
            IconButton(
              icon: Icon(
                Icons.download,
                color: Colors.white,
              ),
              onPressed: () async {
                // Capture and save PDF as before
                await _captureAndSavePdf(repaintBoundaryKey);

                // Get the app's documents directory
                final directory = await getApplicationDocumentsDirectory();
                final filePath = '${directory.path}/voucher.pdf';

                // Show a confirmation message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Voucher downloaded successfully!'),
                  ),
                );

                // Optionally, open or share the saved PDF
                // Example: Open the file using the default PDF viewer
                OpenFile.open(filePath);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Bus background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 250, top: 190),
                // child: Container(
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: Colors.blue,
                //     ),
                //     child: IconButton(
                //       icon: Icon(
                //         Icons.arrow_forward_ios,
                //         color: Colors.white,
                //       ),
                //       onPressed: () async {
                //         await saveDataToFirestore();
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => VoucherUpload(
                //                       selectRoute: widget.route,
                //                       fee: widget.fee,
                //                       bus: widget.bus,
                //                     ))
                //             //
                //             // MaterialPageRoute(
                //             //     builder: (context) => linkedscreen())
                //             );
                //       },
                //     )),

                child: ClipRRect(
                    child: Align(
                  alignment: Alignment.topRight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5.0),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.blueGrey[600]!,
                              Colors.blue[400]!,
                            ],
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 32.0,
                          ),
                          onPressed: () async {
                            await saveDataToFirestore();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VoucherUpload(
                                          selectRoute: widget.route,
                                          fee: widget.fee,
                                          bus: widget.bus,
                                        ))
                                //
                                // MaterialPageRoute(
                                //     builder: (context) => linkedscreen())
                                );
                          },
                        )),
                  ),
                ))),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 180),
                width: 360,
                height: 340,
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      for (int i = 0; i < 3; i++) buildSingleSection(),
                    ]),
                    Row(children: [
                      for (int i = 0; i < 3; i++)
                        buildSingleSectionWithUnderline(),
                    ]),
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              const Center(
                                child: Text(
                                  'University Copy',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9.0,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 45,
                          ),
                          Row(
                            children: [
                              const Center(
                                child: Text(
                                  'Student Copy',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9.0,
                                    decoration: TextDecoration.underline,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Row(
                            children: [
                              const Center(
                                child: Text(
                                  'Bank Copy',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9.0,
                                    decoration: TextDecoration.underline,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(children: [
                      for (int i = 0; i < 3; i++) buildSingleCard(),
                    ]),
                    Row(children: [
                      for (int i = 0; i < 3; i++) builddescription(),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      for (int i = 0; i < 3; i++) tranferfee(),
                    ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: [
                      for (int i = 0; i < 3; i++) fineaddedd(),
                    ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: [
                      for (int i = 0; i < 3; i++)
                        paymentdeadline(currentDateStr, isDeadlineExceeded),
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      for (int i = 0; i < 3; i++) stamp(),
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      for (int i = 0; i < 3; i++) Signature(),
                    ]),
                  ],
                ),
              ),
            ),


            // bottomNavigationBar: BottomNavigationBar(
            //   currentIndex: 0,
            //   items: [
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.home),
            //       label: 'Home',
            //       backgroundColor: Colors.blue,
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.upload),
            //       label: 'Upload Voucher',
            //       backgroundColor: Colors.blue,
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.boarding_pass),
            //       label: 'Boarding pass',
            //       backgroundColor: Colors.blue,
            //     ),
            //   ],
            // ),


          ],
        ),
      ),
    );
  }
}
