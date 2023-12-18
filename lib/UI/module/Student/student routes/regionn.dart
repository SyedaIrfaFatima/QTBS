import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_project/UI/module/Student/student%20routes/Nearbystop.dart';

import 'Route.dart';

// class regionnnn extends StatefulWidget {
//   //
//   // final String voucherDocumentID;
//   // const regionnnn({Key? key}) : super(key: key);
//   // regionnn({
//   //   required this.voucherDocumentID,
//   // });
//   //
//   @override
//   State<regionnnn> createState() => _regionnnnState();
// }
//
// class _regionnnnState extends State<regionnnn> {
//   String selectregion = '';
//
//   Future<List<QueryDocumentSnapshot>> _fetchRegion() async {
//     final regionquery =
//         await FirebaseFirestore.instance.collection('Region').get();
//
//     final regionDataList = regionquery.docs.where((doc) => doc.exists).toList();
//     print("My Debug: $regionDataList");
//
//     return regionDataList;
//   }
//
//   // Stream<QuerySnapshot<Map<String, dynamic>>> _fetchData() {
//   //   return FirebaseFirestore.instance.collection('Region').snapshots();
//
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Choose Region'),
//         backgroundColor: Colors.blue,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(
//               (context),
//             );
//           },
//         ),
//       ),
//       body: FutureBuilder<List<QueryDocumentSnapshot>>(
//         future: _fetchRegion(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData) {
//               final regionDataList = snapshot.data!;
//               return Stack(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/reg manager.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   SingleChildScrollView(
//                     padding: EdgeInsets.only(
//                         left: 100, top: 370, right: 70, bottom: 70),
//
//                     child: Column(
//                       children: regionDataList.map((document) {
//                         return TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => RouteScreen(
//                                   selectregion: document.id,
//                                   voucherDocumentID: 'widget.voucherDocumentID',
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             padding: EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: Colors.blue,
//                             ),
//                             child: Text(
//                               document.id.toUpperCase(),
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
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

class regionnnn extends StatefulWidget {
  //
  // final String voucherDocumentID;
  // const regionnnn({Key? key}) : super(key: key);
  // regionnn({
  //   required this.voucherDocumentID,
  // });
  //
  @override
  State<regionnnn> createState() => _regionnnnState();
}

class _regionnnnState extends State<regionnnn> {
  String selectregion = '';

  Future<List<QueryDocumentSnapshot>> _fetchRegion() async {
    final regionquery =
        await FirebaseFirestore.instance.collection('Region').get();

    final regionDataList = regionquery.docs.where((doc) => doc.exists).toList();
    print("My Debug: $regionDataList");

    return regionDataList;
  }

  Future<List<QueryDocumentSnapshot>> _fetchRoute(String selectedRegion) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Region')
        .doc(selectedRegion)
        .collection('Route')
        .get();

    final routeDataList =
        querySnapshot.docs.where((doc) => doc.exists).toList();
    print("My Debug: $routeDataList");

    return routeDataList;
  }

  void _showRouteBottomSheet(String selectedRegion) {
    showModalBottomSheet(
      backgroundColor: Colors.blue,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
      context: context,
      builder: (context) {
        return FutureBuilder<List<QueryDocumentSnapshot>>(
          future: _fetchRoute(selectedRegion),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final routeDataList = snapshot.data!;
                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue[600],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Routes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: routeDataList.length,
                          itemBuilder: (context, index) {
                            final document = routeDataList[index];
                            final routeName = document.id;
                            final fee = document.get('fees');

                            return Card(
                              elevation: 4.0,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text(
                                  routeName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'Fee: $fee',
                                  style: TextStyle(fontSize: 14),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NearbyStop(
                                          selectedRoute: document.id,
                                          selectregion: selectedRegion,
                                          fee: fee,
                                          voucherDocumentID:
                                              'widget.voucherDocumentID,'),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: Text('No route data available'));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }

  // Stream<QuerySnapshot<Map<String, dynamic>>> _fetchData() {
  //   return FirebaseFirestore.instance.collection('Region').snapshots();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Region'),
        backgroundColor: Colors.blue,
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
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _fetchRegion(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final regionDataList = snapshot.data!;
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/reg manager.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.only(
                        left: 100, top: 370, right: 70, bottom: 70),
                    child: Column(
                      children: regionDataList.map((document) {
                        return TextButton(
                          onPressed: () {
                            _showRouteBottomSheet(document.id);
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.blue,
                            ),
                            child: Text(
                              document.id.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
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

class RouteScreen extends StatefulWidget {
  final String selectregion;
  final String voucherDocumentID;

  RouteScreen({
    required this.selectregion,
    required this.voucherDocumentID,
  });

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  Future<List<QueryDocumentSnapshot>> _fetchRoute() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Region')
        .doc(widget.selectregion)
        .collection('Route')
        .get();

    final routeDataList = querySnapshot.docs.toList();
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
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: FutureBuilder<List<QueryDocumentSnapshot>>(
          future: _fetchRoute(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final routeDataList = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: routeDataList.map((document) {
                      final routeName = document.id;
                      final fee = document.get('fees');

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            width: 1.0,
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade400,
                              Colors.blue.shade700,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            title: Text(
                              routeName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            subtitle: Text(
                              'Fee: $fee',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NearbyStop(
                                    selectedRoute: document.id,
                                    selectregion: widget.selectregion,
                                    fee: fee,
                                    voucherDocumentID: widget.voucherDocumentID,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              } else {
                return Center(child: Text('No route data available'));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
