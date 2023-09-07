// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import 'Nearbystop.dart';
//
// class route extends StatelessWidget {
//   const route({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ListWheelScrollView Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: Route(),
//     );
//   }
// }
//
// class Route extends StatefulWidget {
//   const Route({Key? key}) : super(key: key);
//
//   @override
//   _RouteState createState() => _RouteState();
// }
//
// class _RouteState extends State<Route> {
//   Future<List<Map<String, dynamic>>> _fetchRoutes() async {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('Region')
//         .doc('Islamabad')
//         .collection('Route')
//         .doc('7mbYV84PhgPMuP8mi5ZO')
//         .get();
//
//     final routeData = snapshot.data();
//     print("My Debug: $routeData");
//
//     if (routeData != null) {
//       final routeName = routeData['route1'] as String;
//       final routeId = routeData['Routeid'] as String;
//
//       return [
//         {'name': routeName, 'id': routeId}
//       ];
//     } else {
//       return [];
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Routes"),
//         backgroundColor: Colors.green,
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: _fetchRoutes(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData) {
//               final routes = snapshot.data;
//
//               return Stack(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/background container.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   ListWheelScrollView(
//                     itemExtent: 100,
//                     clipBehavior: Clip.antiAlias,
//                     children: routes!.map((route) {
//                       return ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => NearbyStop(),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           route['name']['id'], // Display the route name
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 25,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               );
//             } else {
//               return Center(child: Text('No routes data available'));
//             }
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
//
//

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Nearbystop.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({Key? key}) : super(key: key);

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  String selectedRoute = '';
  Future<List<QueryDocumentSnapshot>> _fetchRoute() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Region')
        .doc('Islamabad')
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
                      return ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NearbyStop(selectedRoute: document.id),
                            ),
                          );
                        },
                        child: Text(
                          ' ${document.id}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
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
