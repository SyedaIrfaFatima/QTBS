import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Nearbystop.dart';

// class RouteScreen extends StatefulWidget {
//   final String selectregion;
//   final String voucherDocumentID;
//
//   RouteScreen({required this.selectregion, required this.voucherDocumentID});
//
//   @override
//   _RouteScreenState createState() => _RouteScreenState();
// }
//
// class _RouteScreenState extends State<RouteScreen> {
//   String selectedRoute = '';
//   Future<List<QueryDocumentSnapshot>> _fetchRoute() async {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('Region')
//         .doc(widget.selectregion)
//         .collection('Route')
//         .get();
//
//     final routeDataList =
//         querySnapshot.docs.where((doc) => doc.exists).toList();
//     print("My Debug: $routeDataList");
//
//     return routeDataList;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Choose Route"),
//         backgroundColor: Colors.blue,
//       ),
//       body: FutureBuilder<List<QueryDocumentSnapshot>>(
//         future: _fetchRoute(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData) {
//               final routeDataList = snapshot.data!;
//               return Stack(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/img_route.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   // ListWheelScrollView(
//                   //   itemExtent: 70,
//                   //   clipBehavior: Clip.antiAlias,
//                   //   children: routeDataList.map((document) {
//                   //     final routeName = document.id;
//                   //     SizedBox(height: 4);
//                   //     final fee = document.get('fees');
//                   //     return ElevatedButton(
//                   //       onPressed: () {
//                   //         Navigator.push(
//                   //           context,
//                   //           MaterialPageRoute(
//                   //             builder: (context) => NearbyStop(
//                   //               selectedRoute: document.id,
//                   //               selectregion: widget.selectregion,
//                   //               fee: fee,
//                   //               voucherDocumentID: widget.voucherDocumentID,
//                   //             ),
//                   //             // MyBus(selectRoute: document.id),
//                   //           ),
//                   //         );
//                   //       },
//                   //       child: Column(
//                   //         children: [
//                   //           Text(
//                   //             '$routeName',
//                   //             textAlign: TextAlign.center,
//                   //             style: TextStyle(
//                   //               fontSize: 15,
//                   //               color: Colors.white,
//                   //               fontWeight: FontWeight.bold,
//                   //             ),
//                   //           ),
//                   //           SizedBox(
//                   //             height: 5,
//                   //           ),
//                   //           Text(
//                   //             'Fee: $fee',
//                   //             textAlign: TextAlign.center,
//                   //             style: TextStyle(
//                   //               fontSize: 12,
//                   //               color: Colors.white,
//                   //             ),
//                   //           ),
//                   //         ],
//                   //       ),
//                   //     );
//                   //   }).toList(),
//                   // ),
//                   ListWheelScrollView(
//                     itemExtent: 80,
//                     clipBehavior: Clip.antiAlias,
//                     children: routeDataList.map((document) {
//                       final routeName = document.id;
//                       final fee = document.get('fees');
//
//                       return Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.0),
//                           border: Border.all(
//                             width: 1.0,
//                           ),
//                           gradient: LinearGradient(
//                             colors: [
//                               Colors.blue.shade400,
//                               Colors.blue.shade700,
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                         ),
//                         child: Card(
//                           elevation: 4.0,
//                           margin: EdgeInsets.symmetric(horizontal: 10),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           child: ListTile(
//                             title: Text(
//                               routeName,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             subtitle: Text(
//                               'Fee: $fee',
//                               style: TextStyle(
//                                 fontSize: 12,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => NearbyStop(
//                                     selectedRoute: document.id,
//                                     selectregion: widget.selectregion,
//                                     fee: fee,
//                                     voucherDocumentID: widget.voucherDocumentID,
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               );
//             } else {
//               return Center(child: Text('No route data available'));
//             }
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
