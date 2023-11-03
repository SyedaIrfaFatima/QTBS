import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../Authentication/models/User_model.dart';
import '../Profile/profile_controller.dart';

class feedback extends StatefulWidget {
  const feedback({Key? key}) : super(key: key);

  @override
  State<feedback> createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
  String Email = '';
  double feedbackRating = 3.0; // Default rating value
  final ProfileController profileController = Get.find();
  TextEditingController commentController = TextEditingController();
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void saveFeedback() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      final String uid = user.uid;

      FirebaseFirestore.instance.collection('feedback').doc(uid).set({
        'rating': feedbackRating,
        'comment': commentController.text,
        'email': user.email,
        'timestamp': FieldValue.serverTimestamp(),
      });
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Feedback sent successfully'),
          duration: Duration(seconds: 2),
        ),
      );
      commentController.clear();
      // Optionally, you can show a success message to the user here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Feedback',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(children: [
          Container(
            // Wrap with Container
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/feedbackk.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 60, top: 280),
            child: FutureBuilder(
              future: profileController.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel user = snapshot.data as UserModel;

                    Email = user.email;

                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: Column(
                          children: [
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(
                                      8), // Adjust the padding as needed
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: Colors.blue,
                                      )),

                                  child: Text(
                                    Email,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors
                                          .black, // Change text color to make it visible
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 230),
                                  child: Text(
                                    'Rating',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors
                                          .black, // Change text color to make it visible
                                    ),
                                  ),
                                ),
                                RatingBar.builder(
                                  initialRating: feedbackRating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemSize: 40,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      feedbackRating = rating;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 210),
                              child: Text(
                                ' Comment',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Center(
                              child: TextField(
                                controller: commentController,
                                maxLength: 300,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: 'Enter your feedback here',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .blue, // Change the border color when focused
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                ),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 10, right: 90),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (commentController.text.isNotEmpty) {
                                      saveFeedback();
                                    } else {
                                      SnackBar(
                                        content: Text(
                                            'Please enter a comment before sending.'),
                                        duration: Duration(seconds: 3),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 12,
                                    ), // Adjust the padding to make the button bigger
                                  ),
                                  child: Text('Send'),
                                )),
                          ],
                        ),
                      ),
                    );
                  }
                }
                // Return a loading indicator or error message if needed
                return CircularProgressIndicator(); // Change this to suit your UI
              },
            ),
          ),
        ]));
  }
}
