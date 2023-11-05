import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../student_bus_selection/Select bus.dart';
import 'Nearbystop.dart';

class RouteScreen extends StatefulWidget {
  final String selectregion;

  RouteScreen({required this.selectregion});

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  String selectedRoute = '';
  Future<List<QueryDocumentSnapshot>> _fetchRoute() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Region')
        .doc(widget.selectregion)
        .collection('Route')
        .get();

    final routeDataList =
        querySnapshot.docs.where((doc) => doc.exists).toList();
    print("My Debug: $routeDataList");

    return routeDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Route"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _fetchRoute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final routeDataList = snapshot.data!;
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/background container.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ListWheelScrollView(
                    itemExtent: 70,
                    clipBehavior: Clip.antiAlias,
                    children: routeDataList.map((document) {
                      final routeName = document.id;
                      SizedBox(height: 4);
                      final fee = document.get('fees');
                      return ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NearbyStop(
                                selectedRoute: document.id,
                                selectregion: widget.selectregion,
                                fee: fee,
                              ),
                              // MyBus(selectRoute: document.id),
                            ),
                          );
                        },
                        //   child: Text(
                        //     ' ${document.id}',
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //       fontSize: 15,
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // );
                        child: Column(
                          children: [
                            Text(
                              '$routeName',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Fee: $fee',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            } else {
              return Center(child: Text('No route data available'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
