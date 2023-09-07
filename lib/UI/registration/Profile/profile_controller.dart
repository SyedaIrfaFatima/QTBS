import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_project/Authentication/Auth_reprository/User_Repository/user_repository.dart';
import 'package:test_project/Authentication/auth_controller.dart';

import '../../../Authentication/models/User_model.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(Authcontroller());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    // final email = _authRepo.auth.value?.email;

    final email = _authRepo.auth.currentUser?.email;
    print("updata:email:$email");
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  Future<List<UserModel>> getAllUsers() async => await _userRepo.allUsers();

  updateRecord(UserModel user) async {
    await _userRepo.UpdateUserRecord(user);

    // Future<void> updateRecord(UserModel user) async {
    //   try {
    //     await _userRepo.UpdateUserRecord(user);
    //     print("User profile updated successfully");
    //   } catch (e) {
    //     print("Error updating user profile: $e");
    //   }
  }
}
