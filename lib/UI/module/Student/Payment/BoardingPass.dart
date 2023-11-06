import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test_project/UI/module/Student/HomeScreen/Homee.dart';

import '../../../../Authentication/models/User_model.dart';
import '../Profile/profile_controller.dart';

class BoardingPass extends StatefulWidget {
  final String selectRoute;
  final String fee;

  BoardingPass({required this.selectRoute, required this.fee});

  @override
  State<BoardingPass> createState() => _BoardingPassState();
}

class _BoardingPassState extends State<BoardingPass> {
  String userName = ''; // Store the user's name
  String sapId = '';
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        title: Text('Boarding Pass'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.download,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Bus background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(
                        selectRoute: widget.selectRoute,
                        fee: widget.fee,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
              width: 360,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Text(
                          'BOARDING PASS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/logo.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' Student Name',
                          style: TextStyle(
                            fontSize: 10.0,
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
                                sapId = user.Sapid;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                    Text(
                                      ' SapId',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                      ),
                                    ),
                                    Text(
                                      sapId,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }
                            return Container(); // Return an empty container for better layout
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Text(
                              ' Stop',
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                          Text(
                            ' G14/4 Islamabad',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Text(
                              ' Bus No',
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                          Text(
                            ' LF357',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Text(
                              'Fee',
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                          Text(
                            ' 9500',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Text(
                              'Start Date',
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                          Text(
                            ' 5th May 2022',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Text(
                              'End Date',
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                          Text(
                            ' 5th June 2022',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
