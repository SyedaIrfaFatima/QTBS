import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

import 'package:flutter/rendering.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:ui' as ui; // Import 'dart:ui' for ui.Image

import 'package:image/image.dart' as img;

import '../../../../Authentication/models/User_model.dart';
import '../Profile/profile_controller.dart';
import 'Uploadvoucher.dart';

class voucher extends StatefulWidget {
  final FirebaseFirestore db;
  final String userId;
  final String route;
  final String fee;

  voucher({
    required this.db,
    required this.userId,
    required this.route,
    required this.fee,
  });

  @override
  _voucherState createState() => _voucherState();
}

class _voucherState extends State<voucher> {
  String userName = ''; // Store the user's name
  String sapId = '';
  final ProfileController profileController = Get.find();

  DateTime registrationDate = DateTime.now();
  DateTime fixedPaymentDeadline = DateTime.now().add(Duration(days: 5));

  final GlobalKey repaintBoundaryKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    fetchRegistrationDate();
    uploadVoucherToFirebaseStorage();
  }

  Future<void> fetchRegistrationDate() async {
    try {
      // Fetch user-specific data from Firestore based on the authenticated user's ID
      final userDoc = await widget.db
          .collection('BusRegistrations')
          .doc(widget.userId)
          .get();
      if (userDoc.exists) {
        final registrationTimestamp =
            userDoc.data()?['registrationTimestamp'] as Timestamp?;
        if (registrationTimestamp != null) {
          final registrationDateTime = registrationTimestamp.toDate();
          setState(() {
            registrationDate =
                registrationDateTime; // Set registration date to match the Firestore value
            fixedPaymentDeadline = registrationDateTime.add(Duration(days: 5));
          });
        }
      }
    } catch (e) {
      print("Error fetching registration date: $e");
    }
  }

  Future<void> uploadVoucherToFirebaseStorage() async {
    try {
      // Initialize Firebase Storage reference
      final storage = FirebaseStorage.instance;
      final storageReference = storage.ref().child(
          'files/voucher_save.pdf'); // Replace with your desired path and filename

      // Replace the following comment with code to create or read the content
      // final voucherSaveFileContent = ...;  // You need to provide the binary content of the file

      // Upload the content to Firebase Storage
      // await storageReference.putData(voucherSaveFileContent);

      print('Voucher save file uploaded successfully.');
    } catch (e) {
      print('Error uploading voucher save file: $e');
    }
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
                              ' ${DateFormat('dd/MM/yy').format(registrationDate)}',
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
          widget.fee,
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

  Widget paymentdeadline(String currentDate) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 0),
          child: Row(
            children: [
              Text(
                'Payment deadline',
                style: TextStyle(
                  fontSize: 7,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(width: 2),
              Text(
                ' ${DateFormat('dd/MM/yy').format(fixedPaymentDeadline)}', // Use the fixed payment deadline
                style: TextStyle(
                  fontSize: 7,
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
              }),
          actions: [
            IconButton(
              icon: Icon(
                Icons.download,
                color: Colors.white,
              ),
              onPressed: () {},
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
              child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VoucherUpload(
                                    selectRoute: widget.route,
                                    fee: widget.fee,
                                  )));
                    },
                  )),
            ),
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
                    Row(children: [
                      for (int i = 0; i < 3; i++)
                        paymentdeadline(currentDateStr),
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
          ],
        ),
      ),
    );
  }
}
