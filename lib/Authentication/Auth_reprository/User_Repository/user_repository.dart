import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/User_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instances => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db.collection("Users").doc("U25UIF5mycustomid").set(user.toJson());

    // await _db
    //     .collection("Users")
    //     .add(user.toJson())
    //     .whenComplete(
    //       () => Get.snackbar("Success", "Your account has been created",
    //           snackPosition: SnackPosition.BOTTOM,
    //           backgroundColor: Colors.green.withOpacity(0.1),
    //           colorText: Colors.green),
    //     )
    //     .catchError((error, stackTrace) {
    //   Get.snackbar("Error", "Something went wrong. Try again.",
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.red.withOpacity(0.1),
    //       colorText: Colors.red);
    //   print(error.toString());
    // });
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();

    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;

    return userData;
  }

  // Future<UserModel> getUserDetails(String email) async {
  //      print("updata:() $email}");
  //
  //   // final snapshot = await _db
  //   //     .collection("Users")
  //   //     .where("id", isEqualTo: "24j1t6WKUkAO7Q34p6lw")
  //   //     .get();
  //   final snapshot = await _db.collection("Users").doc("U25UIF5mycustomid");
  //   UserModel userData = UserModel(
  //       fullName: "fullName",
  //       email: email,
  //       // id:"",
  //       phoneNo: "phoneNo",
  //       Sapid: "Sapid",
  //       Address: "Address",
  //       Password: "Password",
  //       ConfirmPassword: "ConfirmPassword");
  //
  //   final snapshot2 = await _db
  //       .collection("Users")
  //       .where("Email", isEqualTo: "maida@gmail.com")
  //       .get();
  //   //     .then(
  //   //   (querySnapshot) {
  //   //     print("udata:Successfully completed");
  //   //     for (var docSnapshot in querySnapshot.docs) {
  //   //       print("udata:new: ${userData.fullName}");
  //   //     }
  //   //   },
  //   //   onError: (e) => print("Error completing: $e"),
  //   // );
  //   //print("updata: ${snapshot.docs.length.toString()}");
  //   // print("updata:${snapshot.docs.first.toString()}");
  //   // final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
  //   // print("updata:${userData.fullName}");
  //   return UserModel.fromSnapshot(snapshot2.docs.first.data());
  //
  //   return UserModel(
  //       fullName: "",
  //       email: email,
  //       phoneNo: "phoneNo",
  //       Sapid: "Sapid",
  //       Address: "Address",
  //       Password: "Password",
  //       ConfirmPassword: "ConfirmPassword");
  // }

  Future<List<UserModel>> allUsers() async {
    final snapshot = await _db.collection("Users").get();
    final userData = snapshot.docs
        .map((e) =>
            UserModel.fromSnapshot(e.data() as DocumentSnapshot<Object?>))
        .toList();
    return userData;
  }

  Future<void> UpdateUserRecord(UserModel user) async {
    await _db.collection("users").doc(user.email).update(user.toJson());
    // final userRef = _db.collection("Users").doc(user.email);
    // final userDoc = await userRef.get();
    //
    // if (userDoc.exists) {
    //   try {
    //     await userRef.update(user.toJson());
    //     print("User updated successfully: ${user.email}");
    //   } catch (e) {
    //     print("Error updating user: ${user.email}, Error: $e");
    //   }
    // } else {
    //   print("User does not exist in Firestore: ${user.email}");
  }
}

// print("Updating user with email: ${user.email}");
// await _db.collection("users").doc(user.email).update(user.toJson());
