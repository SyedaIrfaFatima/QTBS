import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class voucherstatus extends StatefulWidget {
  const voucherstatus({Key? key}) : super(key: key);

  @override
  State<voucherstatus> createState() => _voucherstatusState();
}

class _voucherstatusState extends State<voucherstatus> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _busRegistrationCollection =
      FirebaseFirestore.instance.collection('BusRegistrations');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voucher Status"),
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
                      label: Text('Invoice Amount'),
                    ),
                    DataColumn(
                      label: Text('Route'),
                    ),
                    DataColumn(
                      label: Text('Payment'),
                    ),
                    DataColumn(
                      label: Text('Fine'),
                    ),
                    DataColumn(
                      label: Text('Bus'),
                    ),
                    DataColumn(
                      label: Text('Outstanding Balance'),
                    ),
                  ],
                  rows: busRegistrations
                      .map((registration) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                  Text(registration['YY/MM/DD'].toString())),
                              DataCell(Text(registration['fees'].toString())),
                              DataCell(Text(registration['Route'].toString())),
                              DataCell(
                                  Text(registration['Payment'].toString())),
                              DataCell(Text(registration['Fine'].toString())),
                              DataCell(
                                  Text(registration['busNumber'].toString())),
                              DataCell(Text(registration['Outstanding Balance']
                                  .toString())),
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
