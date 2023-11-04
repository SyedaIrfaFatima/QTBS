import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../Authentication/models/User_model.dart';
import '../../../registration/Util/utils.dart';
import '../../../registration/login.dart';
import '../Discussion Form/discussion form.dart';
import '../FeedBack/feedback.dart';
import '../Payment/pay.dart';
import '../Profile/profileScreen.dart';
import '../Profile/profile_controller.dart';

class Home extends StatefulWidget {
  final String selectRoute;

  Home({required this.selectRoute});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = FirebaseAuth.instance;
  String userName = '';
  final ProfileController profileController = Get.find();
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text('Post'), actions: [
              IconButton(
                onPressed: () {
                  auth.signOut().then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }).onError((error, stackTrace) {
                    utils().toastMessage(error.toString());
                  });
                },
                icon: Icon(Icons.logout_outlined),
              ),
              SizedBox(width: 10),
            ]),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => profile()),
                            );
                          },
                          child: CircleAvatar(
                            radius: 50.0, // Adjust size as needed
                            backgroundImage: AssetImage(
                                'assets/profileimage.jpg'), // Replace with actual driver profile image
                          ),
                        ),
                        FutureBuilder(
                          future: profileController.getUserData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                UserModel user = snapshot.data as UserModel;

                                userName = user.fullName;

                                return Text(
                                  userName,
                                  style: TextStyle(color: Colors.white),
                                );
                              }
                            }
                            // Return a loading indicator or error message if needed
                            return CircularProgressIndicator(); // Change this to suit your UI
                          },
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  ListTile(
                    title: Text('Payment'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => payfee(
                              selectRoute: widget
                                  .selectRoute), // Replace PaymentScreen with your actual payment screen
                        ),
                      ); // Update the UI to show that item 1 was selected
                    },
                  ),
                  ListTile(
                    title: Text('Refund fee'),
                    onTap: () {
                      // Update the UI to show that item 2 was selected
                    },
                  ),
                  ListTile(
                    title: Text('Notification'),
                    onTap: () {
                      // Update the UI to show that item 2 was selected
                    },
                  ),
                  ListTile(
                    title: Text('Feedback'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              feedback(), // Replace PaymentScreen with your actual payment screen
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('discussion'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              QueryScreen(), // Replace PaymentScreen with your actual payment screen
                        ),
                      ); // Update the UI to show that item 2 was selected
                    },
                  ),
                  ListTile(
                    title: Text('Setting '),
                    onTap: () {
                      // Update the UI to show that item 2 was selected
                    },
                  ),
                  ListTile(
                    title: Text('Help '),
                    onTap: () {
                      // Update the UI to show that item 2 was selected
                    },
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
                child: SafeArea(
              child: Column(children: [
                Center(
                  child: const Image(
                    width: 500,
                    height: 500,
                    image: AssetImage('assets/map live location.png'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0), // Adjust padding as needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Arrival Time',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '10:00 AM'), // Replace with actual arrival time
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Departure Time',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '11:00 AM'), // Replace with actual departure time
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bus No.',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    'LSG1297'), // Replace with actual bus number
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0), // Add spacing between rows
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30.0, // Adjust size as needed
                            backgroundImage: AssetImage(
                                'assets/driver.jpg'), // Replace with actual driver profile image
                          ),
                          SizedBox(
                              width:
                                  16.0), // Add spacing between image and text
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Driver ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  'Rizwan Ahmed '), // Replace with actual driver name
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ]),
            ))));
  }
}
