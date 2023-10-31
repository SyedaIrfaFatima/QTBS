import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../Authentication/models/User_model.dart';

import '../../Student/Profile/profileScreen.dart';
import '../../Student/Profile/profile_controller.dart';
import '../manager_busesdetails/bus registration record.dart';
import '../manager_routes/man_region.dart';

class mdashboard extends StatefulWidget {
  const mdashboard({Key? key}) : super(key: key);

  @override
  State<mdashboard> createState() => _mdashboardState();
}

class _mdashboardState extends State<mdashboard> {
  String userName = '';
  final ProfileController profileController = Get.find();
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Track Live Location'),
        ),
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
                          MaterialPageRoute(builder: (context) => profile()),
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
                        if (snapshot.connectionState == ConnectionState.done) {
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
                  // Navigator.of(context).push(
                  // // MaterialPageRoute(
                  // // builder: (context) => payfee(
                  // // selectRoute: widget
                  // //     .selectRoute), // Replace PaymentScreen with your actual payment screen
                  // // ),
                  // ); // Update the UI to show that item 1 was selected
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
                  // Update the UI to show that item 2 was selected
                },
              ),
              ListTile(
                title: Text('discussion'),
                onTap: () {
                  // Update the UI to show that item 2 was selected
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
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 260),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => busregistration(),
                                ));

                                // Add your button 1 action here
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ), // Adjust the padding to make the button bigger
                              ),
                              child: Text(
                                'Manage Route',
                                style: TextStyle(
                                  fontSize: 19, // Customize the font size
                                  fontWeight: FontWeight
                                      .bold, // Customize the font weight
                                  color:
                                      Colors.white, // Customize the text color
                                ),
                              ),
                            ),
                            SizedBox(width: 16), // Spacer between buttons
                            ElevatedButton(
                              onPressed: () {
                                // Add your button 2 action here
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ), // Adjust the padding to make the button bigger
                              ),
                              child: Text(
                                'Allocate Driver',
                                style: TextStyle(
                                  fontSize: 19, // Customize the font size
                                  fontWeight: FontWeight
                                      .bold, // Customize the font weight
                                  color:
                                      Colors.white, // Customize the text color
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 20), // Spacer between the two sets of buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ElevatedButton(
                          //   onPressed: () {
                          //     // Add your button 3 action here
                          //   },
                          //   style: ElevatedButton.styleFrom(
                          //     padding: EdgeInsets.symmetric(
                          //       horizontal: 20,
                          //       vertical: 16,
                          //     ), // Adjust the padding to make the button bigger
                          //   ),
                          //   // child: Text(
                          //   //   'Allocate Buses',
                          //   //   style: TextStyle(
                          //   //     fontSize: 19, // Customize the font size
                          //   //     fontWeight: FontWeight
                          //   //         .bold, // Customize the font weight
                          //   //     color: Colors.white, // Customize the text color
                          //   //   ),
                          //   // ),
                          // ),
                          SizedBox(width: 16), // Spacer between buttons
                          ElevatedButton(
                            onPressed: () {
                              // Add your button 4 action here
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ), // Adjust the padding to make the button bigger
                            ),
                            child: Text(
                              'Time Schedule',
                              style: TextStyle(
                                fontSize: 19, // Customize the font size
                                fontWeight: FontWeight
                                    .bold, // Customize the font weight
                                color: Colors.white, // Customize the text color
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
