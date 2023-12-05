import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class busbookstatus extends StatefulWidget {
  const busbookstatus({Key? key}) : super(key: key);

  @override
  State<busbookstatus> createState() => _busbookstatusState();
}

class _busbookstatusState extends State<busbookstatus> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _busRegistrationCollection =
      FirebaseFirestore.instance.collection('BusRegistrations');
  DateTime parsedDate = DateTime.now();

  @override
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
                  rows: busRegistrations
                      .map((registration) => DataRow(
                            cells: <DataCell>[
                              DataCell(Text(
                                  registration['registrationDate'].toString())),
                              DataCell(Text(registration['Route'].toString())),
                              DataCell(
                                  Text(registration['busNumber'].toString())),
                              DataCell(Text(registration['fees'].toString())),
                            ],
                          ))
                      .toList(),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  // Function to fetch a list of bus registrations
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
}
