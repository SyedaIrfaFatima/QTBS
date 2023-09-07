import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:test_project/UI/Module/Bus%20Booking/Region.dart';
import 'package:test_project/UI/registration/login.dart';
import 'package:get/get.dart';

class Authcontroller extends GetxController {
  //AutherController.intance..
  static Authcontroller instance = Get.find();
  //email,password,name..
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //our user would be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("login page");
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => Region());
    }
  }

  void register(String email, password) {
    try {
      auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("About User", "User message",
          backgroundColor: Colors.blue,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Account creation failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(e.toString()));
    }
  }
}
