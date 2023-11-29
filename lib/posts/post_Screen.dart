import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/UI/module/Student/student%20registration/login.dart';
import 'package:test_project/posts/add_post.dart';

import '../UI/module/all_user_usage_interface/Util/utils.dart';

class postscreen extends StatefulWidget {
  const postscreen({Key? key}) : super(key: key);

  @override
  State<postscreen> createState() => _postscreenState();
}

class _postscreenState extends State<postscreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post'), actions: [
        IconButton(
          onPressed: () {
            auth.signOut().then((value) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen(
                            selectRoute: '',
                            fee: '',
                            voucherDocumentID: '',
                          )));
            }).onError((error, stackTrace) {
              utils().toastMessage(error.toString());
            });
          },
          icon: Icon(Icons.logout_outlined),
        ),
        SizedBox(width: 10),
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => addpost()));
          },
          child: Icon(Icons.add)),
    );
  }
}
