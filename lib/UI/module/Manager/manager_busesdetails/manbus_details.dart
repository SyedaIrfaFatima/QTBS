import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Student/student_bus_selection/bus description.dart';

class mandetails extends StatefulWidget {
  final String selectRoute;

  mandetails({required this.selectRoute});

  @override
  State<StatefulWidget> createState() => _mandetailsState();
}

class _mandetailsState extends State<mandetails> {
  late CollectionReference busesCollection; // Removed the generic type

  List<String> busIds = [];
  bool busesLoaded = false;
  bool busAdded = false;
  String selectedBusNumber = "";

  @override
  void initState() {
    super.initState();
    // Initialize the Firestore path for the selected route's buses
    busesCollection = FirebaseFirestore.instance
        .collection('Region')
        .doc('Islamabad')
        .collection('Route')
        .doc(widget.selectRoute)
        .collection('Buses');

    // Call fetchBuses to load the data when the widget is first created
    fetchBuses();
  }

  Future<void> fetchBuses() async {
    try {
      print("Fetching buses..."); // Update the log message
      QuerySnapshot busesQuery =
          await busesCollection.get(); // Removed the generic type

      setState(() {
        busIds = busesQuery.docs.map((doc) {
          return doc.id;
        }).toList();
        busesLoaded = true;
      });

      print("Buses fetched successfully: ${busIds.length} buses");
    } catch (e) {
      print("Error fetching buses: $e");
      // Handle the error as needed, e.g., show an error message to the user.
    }
  }

  Future<void> addBus() async {
    String busNumber = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Bus'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  busNumber = value;
                },
                decoration: InputDecoration(labelText: 'Enter Bus Number'),
              ),
              SizedBox(height: 10),
              Text(
                'Only alphabets and numbers allowed, maximum 10 characters.',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () async {
                if (RegExp(r'^[a-zA-Z0-9]{1,10}$').hasMatch(busNumber)) {
                  try {
                    await busesCollection.doc(busNumber).set({
                      'time': '0',
                      'seats': 0,
                    });
                    fetchBuses();
                    Navigator.of(context).pop();
                    setState(() {
                      busAdded = true;
                    });
                    selectedBusNumber = busNumber;
                  } catch (e) {
                    print('Error adding bus: $e');
                    // Handle the Firestore write error as needed
                  }
                } else {
                  print('Invalid input. Please follow the constraints.');
                  // You can show an error message to the user if needed
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addTime(String busId) async {
    String time = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Time'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  time = value;
                },
                decoration: InputDecoration(labelText: 'Enter Time'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add Time'),
              onPressed: () async {
                // Perform validation and update the time for the bus
                if (time.isNotEmpty) {
                  try {
                    await busesCollection.doc(busId).update({
                      'time': time,
                    });
                    fetchBuses(); // Refresh the bus list
                    Navigator.of(context).pop();
                  } catch (e) {
                    print('Error adding time: $e');
                    // Handle the Firestore update error as needed
                  }
                } else {
                  print('Invalid input. Please enter a time.');
                  // You can show an error message to the user if needed
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addSeats(String busId) async {
    int totalseats = 0;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Seats'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  totalseats = int.tryParse(value) ?? 0;
                },
                decoration: InputDecoration(labelText: 'Enter Seats'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add Seats'),
              onPressed: () async {
                // Perform validation and update the seats for the bus
                if (totalseats > 0) {
                  try {
                    await busesCollection.doc(busId).update({
                      'totalseats': totalseats,
                    });
                    fetchBuses(); // Refresh the bus list
                    Navigator.of(context).pop();
                  } catch (e) {
                    print('Error adding seats: $e');
                    // Handle the Firestore update error as needed
                  }
                } else {
                  print('Invalid input. Please enter a valid number of seats.');
                  // You can show an error message to the user if needed
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteBus(String busId) async {
    try {
      await busesCollection.doc(busId).delete();
      fetchBuses(); // Refresh the bus list
    } catch (e) {
      print('Error deleting bus: $e');
      // Handle the Firestore delete error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blue,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Manage Bus'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigator.pop(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => NearbyStop(),
              //   ),
              // );
            },
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Bus background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 260),
                  child: Row(
                    children: [
                      // Expanded(
                      //     // child: TextField(
                      //     //   // controller: regionNameController,
                      //     //   decoration: InputDecoration(
                      //     //     hintText: 'Enter name',
                      //     //   ),
                      //     // ),
                      //     ),
                      Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: PopupMenuButton<int>(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: Text("Add Bus"),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Text("Add Time"),
                                enabled: busAdded,
                              ),
                              PopupMenuItem(
                                value: 3,
                                child: Text("Add Seats"),
                                enabled: busAdded,
                              ),
                            ],
                            onSelected: (value) {
                              if (value == 1) {
                                addBus();
                                //Handle add bus option
                              } else if (value == 2) {
                                if (busAdded) {
                                  // Call the addTime function for the selected bus here
                                  addTime(
                                      selectedBusNumber); // Pass the bus number or bus ID to the function
                                }
                                // Handle "Add Time" option
                              } else if (value == 3) {
                                if (busAdded) {
                                  // Call the addSeats function for the selected bus here
                                  addSeats(
                                      selectedBusNumber); // Pass the bus number or bus ID to the function
                                } // Handle "Add Seats" option
                              }
                            },
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 400,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Center(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: busesCollection.snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<QueryDocumentSnapshot> busDocuments =
                                      snapshot.data!.docs;

                                  return Column(
                                    children: busDocuments.map((busDocument) {
                                      final busData = busDocument.data()
                                          as Map<String, dynamic>;

                                      final timeData = busDocument.data()
                                          as Map<String, dynamic>;
                                      final time =
                                          timeData['time'] as String? ?? '0';

                                      final busNumber =
                                          busDocument.id.toString();
                                      int seats = int.tryParse(
                                              busData['seats'].toString()) ??
                                          0;

                                      final b = busDocument.id.toString();
                                      int totalseats = int.tryParse(
                                              busData['totalseats']
                                                  .toString()) ??
                                          0;

                                      // final busNumber =
                                      // busDocument.id.toString();
                                      // int total_seat = int.tryParse(
                                      //     busData['total seat '].toString()) ??
                                      //     0;

                                      return Column(
                                        children: [
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 160,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Colors.lightBlue[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Image.asset(
                                                            'assets/bus_icon.png',
                                                            width: 60,
                                                            height: 60,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            busNumber,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          IconButton(
                                                            icon: Icon(
                                                                Icons.edit),
                                                            onPressed: () {},
                                                          ),
                                                          IconButton(
                                                            icon: Icon(
                                                                Icons.delete),
                                                            onPressed: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'Delete Bus'),
                                                                    content: Text(
                                                                        'Are you sure you want to delete this bus?'),
                                                                    actions: <Widget>[
                                                                      TextButton(
                                                                        child: Text(
                                                                            'Cancel'),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      ),
                                                                      TextButton(
                                                                        child: Text(
                                                                            'Delete'),
                                                                        onPressed:
                                                                            () {
                                                                          deleteBus(
                                                                              busDocument.id); // Call the deleteBus function
                                                                          Navigator.of(context)
                                                                              .pop(); // Close the dialog
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              ); // Add delete icon's onPressed functionality here
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Container(
                                                  width: 150,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Colors.lightBlue[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Time',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      Text(
                                                        ' $time',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                            icon: Icon(
                                                                Icons.edit),
                                                            onPressed: () {
                                                              // Add edit icon's onPressed functionality here
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Container(
                                                  width: 110,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Colors.lightBlue[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Column(children: [
                                                    Text(
                                                      'Total seats',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      ' $totalseats',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        IconButton(
                                                          icon:
                                                              Icon(Icons.edit),
                                                          onPressed: () {
                                                            addSeats(
                                                                busNumber); // Add seats to this bus// Add edit icon's onPressed functionality here
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ]),
                                                ),
                                                SizedBox(width: 10),
                                                Container(
                                                  width: 150,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Colors.lightBlue[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  child: Column(children: [
                                                    Text(
                                                      'Available seats',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      '$seats',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                bdescription(),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        'description',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 3,
                                              top: 10,
                                              bottom: 50,
                                            ),
                                            child: SingleChildScrollView(
                                              child: Container(
                                                width: 350,
                                                decoration: BoxDecoration(
                                                  color: Colors.lightBlue[400],
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 3,
                                                    top: 20,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            ('${widget.selectRoute}'), // Corrected from 'widget.selectedroute'
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            ' $time',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 30,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 12,
                                                          right: 3,
                                                          bottom: 12,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              'Total Seats: $totalseats',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'Available Seats: $seats',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  );
                                } else {
                                  return Text(
                                    'No documents found',
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
