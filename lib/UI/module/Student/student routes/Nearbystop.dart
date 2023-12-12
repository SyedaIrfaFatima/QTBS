import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../student_bus_selection/Select bus.dart'; // Import Firestore

class NearbyStop extends StatefulWidget {
  final String selectedRoute;
  final String selectregion;
  final String fee;
  final String voucherDocumentID;

  NearbyStop({
    required this.selectedRoute,
    required this.selectregion,
    required this.fee,
    required this.voucherDocumentID,
  });

  @override
  _NearbyStopState createState() => _NearbyStopState();
}

class _NearbyStopState extends State<NearbyStop> {
  late CollectionReference stopsCollection;
  List<String> stopIds = [];

  @override
  void initState() {
    super.initState();
    // Initialize the Firestore path for the selected route's stops
    stopsCollection = FirebaseFirestore.instance
        .collection('Region')
        .doc(widget.selectregion)
        .collection('Route')
        .doc(widget.selectedRoute)
        .collection('Stops');
  }

  Future<void> fetchStops() async {
    try {
      print("Fetching stops...");
      QuerySnapshot<Map<String, dynamic>> stopsQuery =
          await stopsCollection.get() as QuerySnapshot<Map<String, dynamic>>;

      setState(() {
        stopIds = stopsQuery.docs.map((doc) {
          return doc.id;
        }).toList();
      });

      print("Stops fetched successfully: ${stopIds.length} stops");
    } catch (e) {
      print("Error fetching stops: $e");
      // Handle the error as needed, e.g., show an error message to the user.
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchStops();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Stop'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Center(
                    child: Image(
                      width: 500,
                      height: 500,
                      image: AssetImage('assets/NearBy Stop.png'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 210),
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   // MaterialPageRoute(
                  //   //   builder: (context) =>
                  //   //       voucher(
                  //   //           db: FirebaseFirestore
                  //   //               .instance),
                  //   // ),
                  // );
                },
                child: Text(
                  'Nearby Stops',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(9.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          ('${widget.selectedRoute}'),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 90,
                        ),
                        Text(
                          '${widget.fee}',
                          style: TextStyle(
                            fontSize: 15, // Adjust the font size as needed
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent[100],
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: stopIds.isEmpty
                          ? Center(
                              // Display CircularProgressIndicator when loading
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount: stopIds.length,
                              itemBuilder: (context, index) {
                                String stopId = stopIds[index];
                                return ListTile(
                                  title: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyBus(
                                            selectRoute: widget.selectedRoute,
                                            fee: widget.fee,
                                            busname: '',
                                            color: '',
                                            totalseats: 87,
                                            selectregion: widget.selectregion,
                                            voucherDocumentID:
                                                widget.voucherDocumentID,
                                            voucherURL: '',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(stopId),
                                  ),
                                );
                              },
                            ),
                    ),
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
