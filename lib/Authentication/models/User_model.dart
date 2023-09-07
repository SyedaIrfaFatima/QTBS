import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // final String  id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String Sapid;
  final String Address;
  final String Password;
  final String ConfirmPassword;

  UserModel(
      {required this.fullName,
      required this.email,
      required this.phoneNo,
      required this.Sapid,
      required this.Address,
      required this.Password,
      required this.ConfirmPassword});

  toJson() {
    return {
      // "id": id,
      "FullName": fullName,
      "Email": email,
      "phone": phoneNo,
      "SapId": Sapid,
      "Address": Address,
      "Password": Password,
      "ConfirmPassword": ConfirmPassword,
    };
  }

  // factory UserModel.fromSnapshot(Map<String, dynamic> document) {
  //   final data = document;

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      // id: document.id,
      email: data["Email"] ?? "",
      fullName: data["FullName"] ?? "",
      phoneNo: data["phone"] ?? "",
      Sapid: data["SapId"] ?? "",
      Address: data["Address"] ?? "",
      Password: data["Password"] ?? "",
      ConfirmPassword: data["ConfirmPassword"] ?? "",
    );
  }
}
