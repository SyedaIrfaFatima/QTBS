import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../Authentication/models/User_model.dart';
import '../Profile/profile_controller.dart';

// class busbookstatus extends StatefulWidget {
//   const busbookstatus({Key? key}) : super(key: key);
//
//   @override
//   State<busbookstatus> createState() => _busbookstatusState();
// }
//
// class _busbookstatusState extends State<busbookstatus> {
//   String userName = ''; // Store the user's name
//   String sapId = '';
//   final ProfileController profileController = Get.find();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final CollectionReference _busRegistrationCollection =
//       FirebaseFirestore.instance.collection('BusRegistrations');
//
//   DateTime parsedDate = DateTime.now();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Reservation Status"),
//       ),
//       body: FutureBuilder(
//         future: fetchRegistrationData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
//             return Center(child: Text('No bus registrations found'));
//           } else {
//             List<Map<String, dynamic>> busRegistrations =
//                 snapshot.data as List<Map<String, dynamic>>;
//
//             return SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: DataTable(
//                   dataRowHeight: 60,
//                   columns: <DataColumn>[
//                     DataColumn(
//                       label: Text('Name'),
//                     ),
//                     DataColumn(
//                       label: Text('Sap Id'),
//                     ),
//                     DataColumn(
//                       label: Text('YY/MM/DD'),
//                     ),
//                     DataColumn(
//                       label: Text('Route'),
//                     ),
//                     DataColumn(
//                       label: Text('Bus Number'),
//                     ),
//                     DataColumn(
//                       label: Text('Payment'),
//                     ),
//                   ],
//                   rows: busRegistrations
//                       .map((registration) => DataRow(
//                             cells: <DataCell>[
//                               DataCell(Text(registration['Name'].toString())),
//                               DataCell(Text(registration['SapId'].toString())),
//                               DataCell(Text(
//                                   registration['registrationDate'].toString())),
//                               DataCell(Text(registration['Route'].toString())),
//                               DataCell(
//                                   Text(registration['busNumber'].toString())),
//                               DataCell(Text(registration['fees'].toString())),
//                             ],
//                           ))
//                       .toList(),
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   // Function to fetch a list of bus registrations
//   Future<List<Map<String, dynamic>>> fetchRegistrationData() async {
//     final user = _auth.currentUser;
//     if (user == null) {
//       return []; // Return an empty list in case of an error
//     }
//
//     final userId = user.uid;
//
//     try {
//       final querySnapshot = await _busRegistrationCollection
//           .where('userId', isEqualTo: userId)
//           .get();
//
//       if (querySnapshot.docs.isNotEmpty) {
//         final data = querySnapshot.docs
//             .map((doc) => doc.data() as Map<String, dynamic>)
//             .toList();
//         return data;
//       }
//     } catch (error) {
//       // Handle errors here if needed
//       print('Error fetching Firestore data: $error');
//     }
//
//     return []; // Return an empty list if any error occurs
//   }
//
//
//
// }

class busbookstatus extends StatefulWidget {
  const busbookstatus({Key? key}) : super(key: key);

  @override
  State<busbookstatus> createState() => _busbookstatusState();
}

class _busbookstatusState extends State<busbookstatus> {
  String userName = ''; // Store the user's name
  String sapId = '';
  final ProfileController profileController = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _busRegistrationCollection =
      FirebaseFirestore.instance.collection('BusRegistrations');

  void initState() {
    super.initState();
    initUserData();
    // Call the method to fetch user data when the widget is initialized
  }

  Future<void> initUserData() async {
    await fetchUserData(); // Wait for user data to be fetched
    await fetchRegistrationData(); // Then fetch registration data
  }

  DateTime parsedDate = DateTime.now();

  Future<void> fetchUserData() async {
    final snapshot = await profileController.getUserData();
    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
      UserModel user = snapshot.data as UserModel;
      setState(() {
        userName = user.fullName;
        sapId = user.Sapid;
      });
    }
  }

  Future<List<Map<String, dynamic>>> fetchRegistrationData() async {
    final user = _auth.currentUser;
    if (user == null) {
      return []; // Return an empty list in case of an error
    }

    final userId = user.uid;

    try {
      final querySnapshot = await _busRegistrationCollection
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        return data;
      }
    } catch (error) {
      // Handle errors here if needed
      print('Error fetching Firestore data: $error');
    }

    return []; // Return an empty list if any error occurs
  }

  // Future<void> fetchRegistrationData() async {
  //   final user = _auth.currentUser;
  //   if (user == null) {
  //     return; // Return early if there's no user
  //   }
  //
  //   final userId = user.uid;
  //
  //   try {
  //     final querySnapshot = await _busRegistrationCollection
  //         .where('userId', isEqualTo: userId)
  //         .get();
  //
  //     print('Number of documents found: ${querySnapshot.size}');
  //
  //     if (querySnapshot.docs.isNotEmpty) {
  //       final data = querySnapshot.docs
  //           .map((doc) => doc.data() as Map<String, dynamic>)
  //           .toList();
  //       // Process the data if needed
  //       print('Data from Firestore: $data');
  //     } else {
  //       print('No bus registrations found for userId: $userId');
  //     }
  //   } catch (error) {
  //     // Handle errors here if needed
  //     print('Error fetching Firestore data: $error');
  //   }
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reservation Status"),
      ),
      body: FutureBuilder(
        future: fetchRegistrationData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return Center(child: Text('No bus registrations found'));
          } else {
            List<Map<String, dynamic>> busRegistrations =
                snapshot.data as List<Map<String, dynamic>>;

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    dataRowHeight: 60,
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text('Name'),
                      ),
                      DataColumn(
                        label: Text('Sap Id'),
                      ),
                      DataColumn(
                        label: Text('YY/MM/DD'),
                      ),
                      DataColumn(
                        label: Text('Route'),
                      ),
                      DataColumn(
                        label: Text('Bus Number'),
                      ),
                      DataColumn(
                        label: Text('Payment'),
                      ),
                    ],
                    rows: busRegistrations.map((registration) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(registration['Name'].toString())),
                          DataCell(Text(registration['SapId']
                              .toString())), // Use sapId from the user's profile
                          DataCell(Text(
                              registration['registrationDate'].toString())),
                          DataCell(Text(registration['Route'].toString())),
                          DataCell(Text(registration['busNumber'].toString())),
                          DataCell(Text(registration['fees'].toString())),
                        ],
                      );
                    }).toList(),
                  )),
            );
          }
        },
      ),
    );
  }
}
