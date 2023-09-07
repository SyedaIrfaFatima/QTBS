import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_project/UI/Module/Bus Booking/Route.dart';

class region extends StatelessWidget {
  const region({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Region',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Region(),
    );
  }
}

class Region extends StatefulWidget {
  @override
  State<Region> createState() => _RegionState();
}

class _RegionState extends State<Region> {
  Stream<QuerySnapshot<Map<String, dynamic>>> _fetchData() {
    return FirebaseFirestore.instance.collection('Region').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Region'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Container.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 60, top: 350, right: 50),
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No data available.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final docSnapshot = snapshot.data!.docs[index];
                    final documentID = docSnapshot.id;

                    return Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Container(
                        height: 45,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RouteScreen(),
                              ),
                            );
                          },
                          child: Center(
                            child: Text(
                              documentID.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Oswald",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
