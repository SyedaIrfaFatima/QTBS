import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

import 'package:test_project/UI/module/Student/student%20routes/Nearbystop.dart';
import 'package:test_project/UI/module/Student/Payment/fee_voucher.dart';

import '../HomeScreen/Homee.dart';
import '../Payment/pay.dart';
import 'bus description.dart';

class MyBus extends StatefulWidget {
  final String selectRoute;
  final String fee;

  MyBus({required this.selectRoute, required this.fee});

  @override
  State<MyBus> createState() => _MyBusState();
}

class _MyBusState extends State<MyBus> {
  late CollectionReference<Map<String, dynamic>> busesCollection;
  List<String> busIds = [];
  bool busesLoaded = false;

  Future<void> updateAvaliableseats(String busId, int newSeats) async {
    try {
      //Reference to the specific bus document
      DocumentReference<Map<String, dynamic>> busDocRef =
          busesCollection.doc(busId);

      await busDocRef.update({
        'seats': newSeats,
      });
    } catch (e) {
      print("Error updating available seats: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize the Firestore path for the selected route's buses
    busesCollection = FirebaseFirestore.instance
        .collection('Region')
        .doc('Islamabad')
        .collection('Route')
        .doc(widget.selectRoute)
        .collection('Buses');

    // Call fetchBuses to load the data when the widget is first created
    fetchBuses();
  }

  Future<void> fetchBuses() async {
    try {
      print("Fetching buses..."); // Update the log message
      QuerySnapshot<Map<String, dynamic>> busesQuery =
          await busesCollection.get();

      setState(() {
        busIds = busesQuery.docs.map((doc) {
          return doc.id;
        }).toList();
        busesLoaded = true;
      });

      print("Buses fetched successfully: ${busIds.length} buses");
    } catch (e) {
      print("Error fetching buses: $e");
      // Handle the error as needed, e.g., show an error message to the user.
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blue,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Select Bus'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(
                (context),
              );
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
            Padding(
              padding: EdgeInsets.only(left: 300, top: 200),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onPressed: () async {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      final userId = user.uid;
                      final busRegistrationCollection = FirebaseFirestore
                          .instance
                          .collection('BusRegistrations');

                      // Check if the user has registered for any bus
                      QuerySnapshot<Map<String, dynamic>> querySnapshot =
                          await busRegistrationCollection
                              .where('userId', isEqualTo: userId)
                              .get();

                      if (querySnapshot.size > 0) {
                        // The user has registered for a bus, navigate to the "payfee" page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(
                              selectRoute: widget.selectRoute,
                              fees: widget.fee,
                              busnumber: '',
                            ),
                          ),
                        );
                      } else {
                        // The user has not registered for a bus, show a dialog box
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Register First'),
                              content:
                                  Text('You must register for a bus first.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      // Handle the case when the user is not logged in.
                      // Prompt the user to log in or display an error message.
                    }
                  },
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 400,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Center(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: busesCollection.snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<QueryDocumentSnapshot> busDocuments =
                                      snapshot.data!.docs;

                                  return Column(
                                    children: busDocuments.map((busDocument) {
                                      final busData = busDocument.data()
                                          as Map<String, dynamic>;

                                      final timeData = busDocument.data()
                                          as Map<String, dynamic>;
                                      final time =
                                          timeData['time'] as String? ??
                                              '0'; // Access 'time' as a string
                                      // final time =
                                      //     int.tryParse(timeString) ?? 0;
                                      final busNumber =
                                          busDocument.id.toString();
                                      // int seats = busData['seats'] ?? 0;
                                      int seats = int.tryParse(
                                              busData['seats'].toString()) ??
                                          0;

                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(height: 3),
                                              Image.asset(
                                                'assets/bus_icon.png',
                                                width: 60,
                                                height: 60,
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                busNumber,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 250),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (seats > 0) {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Register Confirmation'),
                                                        content: Text(
                                                            'Do you want to register for this bus?'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: Text('No'),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: Text('Yes'),
                                                            onPressed: () {
                                                              final user =
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser;
                                                              if (user !=
                                                                  null) {
                                                                final userId =
                                                                    user.uid;
                                                                final userEmail =
                                                                    user.email; // Retrieve the student's email.
                                                                final busRegistrationCollection =
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'BusRegistrations');

                                                                // Check if the user has already registered for any bus
                                                                busRegistrationCollection
                                                                    .where(
                                                                        'userId',
                                                                        isEqualTo:
                                                                            userId)
                                                                    .get()
                                                                    .then(
                                                                        (querySnapshot) {
                                                                  if (querySnapshot
                                                                          .size >
                                                                      0) {
                                                                    // The user has already registered for a bus
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        content:
                                                                            Text('You have already registered for a bus.'),
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    // User has not registered for any bus, proceed with registration
                                                                    int newSeats =
                                                                        seats -
                                                                            1;
                                                                    updateAvaliableseats(
                                                                        busNumber,
                                                                        newSeats);

                                                                    setState(
                                                                        () {
                                                                      seats--;
                                                                    });
                                                                    final registrationDate =
                                                                        DateTime
                                                                            .now();
                                                                    final registrationDateFormatted =
                                                                        '${registrationDate.year}-${registrationDate.month}-${registrationDate.day}'; // Format the date as a string

                                                                    // Save the registration in Firestore
                                                                    busRegistrationCollection
                                                                        .add({
                                                                      'userId':
                                                                          userId,
                                                                      'userEmail':
                                                                          userEmail, // Store the student's email.
                                                                      'busNumber':
                                                                          busNumber,
                                                                      'Route':
                                                                          widget
                                                                              .selectRoute,
                                                                      'registrationDate':
                                                                          registrationDateFormatted,
                                                                      'fees':
                                                                          widget
                                                                              .fee,
                                                                    });

                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();

                                                                    // Show a success message for 2 seconds
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        content:
                                                                            Text('You have successfully registered for the bus.'),
                                                                        duration:
                                                                            Duration(seconds: 2),
                                                                      ),
                                                                    );
                                                                  }
                                                                });
                                                              } else {
                                                                // Handle the case when the user is not logged in.
                                                                // Prompt the user to log in or display an error message.
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  // Show a dialog indicating that the bus is fully booked
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Bus Fully Booked'),
                                                        content: Text(
                                                            'This bus is fully booked. Please select another bus.'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: Text('OK'),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                              child: Text(
                                                'Register',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Display available seats count

                                          Container(
                                            width: 350,
                                            margin:
                                                const EdgeInsets.only(top: 0),
                                            decoration: BoxDecoration(
                                              color: Colors.lightBlue[400],
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 3, top: 10),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        ('${widget.selectRoute}'),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),

//
                                                      Text(
                                                        ' $time',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
//
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 12,
                                                        right: 3,
                                                        bottom: 12),
                                                    child: Column(
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        bdescription(),
                                                              ),
                                                            );
                                                          },
                                                          child: Text(
                                                            'description',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Available Seats: $seats',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  );
                                } else {
                                  return Text(
                                    'No documents found',
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
