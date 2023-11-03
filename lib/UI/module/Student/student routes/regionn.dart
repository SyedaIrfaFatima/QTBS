import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Route.dart';

class regionnnn extends StatefulWidget {
  const regionnnn({Key? key}) : super(key: key);

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
                        return ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RouteScreen(
                                  selectregion: document.id,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            ' ${document.id.toUpperCase()}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
