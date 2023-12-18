import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'man_region.dart';
import 'man_stops.dart';

class RouteManagerScreen extends StatefulWidget {
  final String selectregion;

  RouteManagerScreen({required this.selectregion});

  @override
  State<RouteManagerScreen> createState() => _RouteManagerScreenState();
}

class _RouteManagerScreenState extends State<RouteManagerScreen> {
  String selectroute = '';
  List<String> routeDataList = [];

  TextEditingController routeNameController = TextEditingController();
  TextEditingController updatedRouteNameController = TextEditingController();

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

  Future<void> deleteRoute(String routeId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Region')
          .doc(widget.selectregion)
          .collection('Route')
          .doc(routeId)
          .delete();

      // Remove the deleted region from the UI
      setState(() {
        routeDataList.remove(routeId);
      });
    } catch (e) {
      // Handle errors here.
      print('Error deleting region: $e');
    }
  }

  Future<void> _showDeleteConfirmationDialog(String routeId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to delete this route?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                deleteRoute(routeId); // Delete the region
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addRoute(String routeName) async {
    if (routeDataList.contains(routeName)) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Region name already exists'),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      return;
    }
    final RegExp alphabetsPattern = RegExp(r'^[A-Za-z]+$');
    if (!alphabetsPattern.hasMatch(routeName)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'Route name should consist of alphabets only. Spaces ,number and special character  are not allowed'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return; // Exit the function if the constraint is not met
    }
    try {
      await FirebaseFirestore.instance
          .collection('Region')
          .doc(widget.selectregion)
          .collection('Route')
          .doc(routeName)
          .set({
        'name': routeName,
        // You can add more fields if needed
      });

      // Add the new region to the UI
      setState(() {
        routeDataList.add(routeName);
      });

      // Clear the text field after adding the region
      routeNameController.clear();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Route added successfully!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle errors here.
      print('Error adding route: $e');
    }
  }

  Future<void> updateRouteName(
      String currentRouteName, String updatedRouteName) async {
    final RegExp alphabetsPattern = RegExp(r'^[A-Za-z\s]+$');
    if (!alphabetsPattern.hasMatch(updatedRouteName)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
              'Region name should consist of alphabets. numbers and special characters are not allowed',
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return; // Exit the function if the constraint is not met
    }

    if (routeDataList.contains(updatedRouteName)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Route name already exists'),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  updatedRouteNameController.clear();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }
    try {
      if (currentRouteName != updatedRouteName) {
        // Create a new document with the updated name
        await FirebaseFirestore.instance
            .collection('Region')
            .doc(widget.selectregion)
            .collection('Route')
            .doc(updatedRouteName)
            .set({'name': updatedRouteName});

        // Delete the old document with the previous name
        await FirebaseFirestore.instance
            .collection('Region')
            .doc(widget.selectregion)
            .collection('Route')
            .doc(currentRouteName)
            .delete();

        print('Route name updated: $updatedRouteName');
      }

      // Update the region name in the UI
      setState(() {
        final index = routeDataList.indexOf(currentRouteName);
        if (index != -1) {
          routeDataList[index] = updatedRouteName;
        }
      });

      // Show a success message using AlertDialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Route name updated successfully!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  updatedRouteNameController.clear();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle errors here.
      print('Error updating route name: $e');
    }
  }

  void handleUpdateRouteName(String currentRouteName, String updatedRouteName) {
    if (currentRouteName != updatedRouteName) {
      // Call the updateRegionName function
      updateRouteName(currentRouteName, updatedRouteName);
    } else {
      // Show a message to inform the user that the names are the same
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Warning'),
            content: Text('The new name is the same as the current name.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRoute(); // Fetch regions when the screen initializes
  }

  @override
  void dispose() {
    routeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Route manager",
        ),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _fetchRoute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final routeDataList = snapshot.data!;
              return Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/manroute.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(children: [
                          Expanded(
                            child: TextField(
                              controller: routeNameController,
                              decoration:
                                  InputDecoration(hintText: 'Enter route name'),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.add, color: Colors.white),
                                onPressed: () {
                                  String routeName =
                                      routeNameController.text.trim();
                                  if (routeName.isNotEmpty) {
                                    addRoute(routeName);
                                  }
                                },
                              ))
                        ])),
                    Container(
                      height: MediaQuery.of(context).size.height - 300,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: routeDataList.map((document) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    StopManagerScreen(
                                                  selectedroute: document.id,
                                                  selectregion:
                                                      widget.selectregion,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            ' ${document.id}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          _showDeleteConfirmationDialog(document
                                              .id); // Use document.id as the route name
                                          // Trigger the delete action
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          // When the edit button is pressed, show a dialog for editing the route name
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Edit Route Name'),
                                                content: TextField(
                                                  controller:
                                                      updatedRouteNameController,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Enter updated route name',
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('Save'),
                                                    onPressed: () {
                                                      String updatedRouteName =
                                                          updatedRouteNameController
                                                              .text
                                                              .trim();

                                                      // Check constraints for the updated route name
                                                      final RegExp
                                                          alphabetsPattern =
                                                          RegExp(
                                                              r'^[A-Za-z\s]+$');
                                                      if (!alphabetsPattern
                                                          .hasMatch(
                                                              updatedRouteName)) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title:
                                                                  Text('Error'),
                                                              content: Text(
                                                                'Route name should consist of alphabets only. Numbers, and special characters are not allowed.',
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: Text(
                                                                      'OK'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        // Update the region name in Firestore
                                                        updateRouteName(
                                                            document.id,
                                                            updatedRouteName);

                                                        // Close the dialog
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ]);
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
