import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/Authentication/models/User_model.dart';
import 'package:test_project/UI/module/all_user_usage_interface/Users.dart';

import 'package:test_project/UI/module/Student/student%20routes/regionn.dart';
import 'package:test_project/UI/module/Student/student%20registration/login.dart';
import 'package:get/get.dart';

import '../UI/module/Guardian/guardian_student_sapid/student_sap.dart';
import '../UI/module/Manager/manager_routes/man_region.dart';

class Authcontroller extends GetxController {
  final String selectRoute;
  final String fees;

  Authcontroller({required this.selectRoute, required this.fees});
  static Authcontroller instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("Login page");
      Get.offAll(() => LoginScreen(
            selectRoute: '',
            fee: '',
            voucherDocumentID: '',
            voucherURL: '',
            bus: '',
          ));
    } else {
      // Check the email of the logged-in user
      if (user.email != null) {
        if (user.email == "student@example.com") {
          Get.offAll(() => regionnnn());
        } else if (user.email == "manager@example.com") {
          Get.offAll(() => RegionManagerScreen());
        }
        // Add more role checks for other user types
      }
    }
  }

  void register(String email, password, String role) {
    try {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredential) {
        // Create a User object and set the email
        RollButton user = RollButton(email: email, role: role);
        // Store this user object in your database with the associated role
        // ...

        // After storing the user object, you can proceed with navigation based on the role
        if (role == "student") {
          Get.offAll(() => regionnnn());
        } else if (role == "manager") {
          Get.offAll(() => RegionManagerScreen());
        } else if (role == "guardain") {
          Get.offAll(() => Studentsapid());
        }
        // Add more role checks for other user types
      });
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
